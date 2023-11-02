import 'package:dart_grpc_playground/api/user_route.dart';
import 'package:dart_grpc_playground/app.dart';
import 'package:test/test.dart';

void main() {
  test('app exists', () {
    expect(App(UserRoute()), isNotNull);
  });
}
