import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/counter_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const initialValue = 0;
  late CounterRobot counterRobot;

  group('Counter', () {
    testWidgets('renders the initial value correctly', (tester) async {
      counterRobot = CounterRobot(tester: tester);

      await counterRobot.show(10);
      await counterRobot.verifyCounterValue(10);
    });

    testWidgets(
      'increments successfuly when button is tapped on',
      (tester) async {
        counterRobot = CounterRobot(tester: tester);

        await counterRobot.show(initialValue);
        await counterRobot.verifyCounterValue(initialValue);
        await counterRobot.tapIncrementButton();
        await counterRobot.verifyCounterValue(initialValue + 1);
      },
    );

    testWidgets(
      'does not increment when button is not tapped on',
      (tester) async {
        counterRobot = CounterRobot(tester: tester);

        await counterRobot.show(initialValue);
        await counterRobot.verifyCounterValue(initialValue);
        await counterRobot.verifyCounterValue(initialValue);
      },
    );
  });
}
