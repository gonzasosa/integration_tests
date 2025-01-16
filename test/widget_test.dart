import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tests/login/login.dart';

import 'package:integration_tests/main.dart';
import 'package:mocktail/mocktail.dart';
import 'package:post_repository/post_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late AuthRepository authRepository;
  late PostRepository postRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    postRepository = MockPostRepository();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      App(
        count: 0,
        authRepository: authRepository,
        postRepository: postRepository,
      ),
    );

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
