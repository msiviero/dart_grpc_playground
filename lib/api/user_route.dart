import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:grpc/grpc.dart';
import 'package:loggy/loggy.dart';

import '../grpc_gen/user_route.pbgrpc.dart';
import '../service/user_service.dart';

part 'user_route.g.dart';

@Singleton()
class UserRoute extends UserRouteServiceBase with UiLoggy {
  final UserService _userService;

  UserRoute(this._userService);

  @override
  Future<UserMessage> getUser(ServiceCall call, UserRequest request) async {
    final user = await _userService.get(request.id);
    if (user == null) {
      throw GrpcError.notFound("No user found with id ${request.id}");
    }
    return user.toUserMessage();
  }

  @override
  Stream<UserMessage> getUsers(ServiceCall call, EmptyRequest request) async* {
    await for (final user in _userService.list()) {
      yield user.toUserMessage();
    }
  }

  @override
  Future<EmptyReply> putUser(ServiceCall call, UserMessage request) async {
    await _userService.put(request.toUser());
    return EmptyReply();
  }
}

extension _ToUserMessage on User {
  UserMessage toUserMessage() => UserMessage(
        id: id,
        name: name,
        email: email,
        age: age,
      );
}

extension _ToUser on UserMessage {
  User toUser() => User(
        id: id,
        name: name,
        email: email,
        age: age,
      );
}
