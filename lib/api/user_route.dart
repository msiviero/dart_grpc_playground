import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:grpc/grpc.dart';
import 'package:loggy/loggy.dart';

import '../grpc_gen/user_route.pbgrpc.dart';

part 'user_route.g.dart';

@Singleton()
class UserRoute extends UserRouteServiceBase with UiLoggy {
  @override
  Future<UserMessage> getUser(ServiceCall call, UserRequest request) {
    throw UnimplementedError();
  }

  @override
  Stream<UserMessage> getUsers(ServiceCall call, EmptyRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<EmptyReply> putUser(ServiceCall call, UserMessage request) {
    throw UnimplementedError();
  }
}
