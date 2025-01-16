import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_tests/login/login.dart';
import 'package:mocktail/mocktail.dart';
import 'package:post_repository/post_repository.dart';

import 'robots/login_robot.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late LoginRobot loginRobot;
  late AuthRepository authRepository;
  late PostRepository postRepository;

  void setUpLoginSuccesful({
    required String email,
    required String password,
  }) {
    when(
      () => authRepository.login(
        email: email,
        password: password,
      ),
    ).thenAnswer((_) async {});
  }

  void setUpLoginFailure({
    required String email,
    required String password,
  }) {
    when(
      () => authRepository.login(
        email: email,
        password: password,
      ),
    ).thenThrow(Exception('Login failed'));
  }

  setUp(() {
    authRepository = MockAuthRepository();
    postRepository = MockPostRepository();
  });

  group('LoginView', () {
    testWidgets(
      'renders correctly',
      (tester) async {
        loginRobot = LoginRobot(
          tester: tester,
        );

        await loginRobot.show(
          authRepository,
          postRepository,
        );
        loginRobot.assertLoginViewRendersCorrectly();
      },
    );

    testWidgets(
      'navigates to [HomePage] after a succesful login',
      (tester) async {
        const email = 'email';
        const password = 'password';

        loginRobot = LoginRobot(
          tester: tester,
        );

        setUpLoginSuccesful(email: email, password: password);

        await loginRobot.show(
          authRepository,
          postRepository,
        );
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
        );

        setUpLoginFailure(email: email, password: password);

        await loginRobot.show(
          authRepository,
          postRepository,
        );
        await loginRobot.enterEmail(email);
        await loginRobot.enterPassword(password);
        await loginRobot.tapSubmitLoginButton();
        loginRobot.assertLoginError();
      },
    );
  });
}
