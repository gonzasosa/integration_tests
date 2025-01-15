import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_tests/login/login.dart';
import 'package:mocktail/mocktail.dart';

import 'robots/login_robot.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late LoginRobot loginRobot;
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('LoginView', () {
    testWidgets(
      'renders correctly',
      (tester) async {
        loginRobot = LoginRobot(
          tester: tester,
          authRepository: authRepository,
        );

        await loginRobot.show();
        loginRobot.assertLoginViewRendersCorrectly();
      },
    );

    testWidgets(
      'navigates to [CounterPage] after a succesful login',
      (tester) async {
        const email = 'email';
        const password = 'password';

        loginRobot = LoginRobot(
          tester: tester,
          authRepository: authRepository,
        );

        loginRobot.setUpLoginSuccesful(
          email: email,
          password: password,
        );
        await loginRobot.show();
        await loginRobot.enterEmail(email);
        await loginRobot.enterPassword(password);
        await loginRobot.tapSubmitLoginButton();
        loginRobot.assertLoginSuccesful();
      },
    );

    testWidgets(
      'show error message when login fails',
      (tester) async {
        const email = 'email';
        const password = 'invalid';

        loginRobot = LoginRobot(
          tester: tester,
          authRepository: authRepository,
        );

        loginRobot.setUpLoginFailure(
          email: email,
          password: password,
        );
        await loginRobot.show();
        await loginRobot.enterEmail(email);
        await loginRobot.enterPassword(password);
        await loginRobot.tapSubmitLoginButton();
        loginRobot.assertLoginError();
      },
    );
  });
}
