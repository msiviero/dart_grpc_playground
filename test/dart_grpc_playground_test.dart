import 'package:dart_grpc_playground/dart_grpc_playground.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });
}
