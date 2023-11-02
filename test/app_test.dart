import 'package:dart_grpc_playground/api/user_route.dart';
import 'package:dart_grpc_playground/app.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<UserRoute>()])
import 'app_test.mocks.dart';

void main() {
  test('app exists', () {
    expect(App(MockUserRoute()), isNotNull);
  });
}
