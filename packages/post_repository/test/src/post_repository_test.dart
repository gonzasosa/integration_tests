// ignore_for_file: prefer_const_constructors
import 'package:post_repository/post_repository.dart';
import 'package:test/test.dart';

void main() {
  group('PostRepository', () {
    test('can be instantiated', () {
      expect(PostRepository(), isNotNull);
    });
  });
}
