import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_tests/login/login.dart';
import 'package:mocktail/mocktail.dart';

import 'robots/counter_robot.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const initialValue = 0;
  late CounterRobot counterRobot;
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('Counter', () {
    testWidgets('renders the initial value correctly', (tester) async {
      counterRobot = CounterRobot(
        tester: tester,
        authRepository: authRepository,
      );

      await counterRobot.show();
      await counterRobot.verifyCounterValue(initialValue);
    });

    testWidgets(
      'increments successfuly when button is tapped on',
      (tester) async {
        counterRobot = CounterRobot(
          tester: tester,
          authRepository: authRepository,
        );

        await counterRobot.show();
        await counterRobot.verifyCounterValue(initialValue);
        await counterRobot.tapIncrementButton();
        await counterRobot.verifyCounterValue(initialValue + 1);
      },
    );

    testWidgets(
      'does not increment when button is not tapped on',
      (tester) async {
        counterRobot = CounterRobot(
          tester: tester,
          authRepository: authRepository,
        );

        await counterRobot.show();
        await counterRobot.verifyCounterValue(initialValue);
        await counterRobot.verifyCounterValue(initialValue);
      },
    );
  });
}
