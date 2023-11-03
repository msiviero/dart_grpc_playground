import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import 'package:loggy/loggy.dart';

import '../grpc_gen/user_route.pbgrpc.dart';

part 'user_route.g.dart';

@Singleton()
class UserRoute extends UserRouteServiceBase with UiLoggy {
  final List<User> users = [];

  @override
  Future<UserMessage> getUser(ServiceCall call, UserRequest request) async {
    for (final user in users) {
      if (user.id == request.id) {
        return user.toUserMessage();
      }
    }
    throw GrpcError.notFound("No user found with id ${request.id}");
  }

  @override
  Stream<UserMessage> getUsers(ServiceCall call, EmptyRequest request) async* {
    for (final user in users) {
      yield user.toUserMessage();
    }
  }

  @override
  Future<EmptyReply> putUser(ServiceCall call, UserMessage request) async {
    users.add(request.toUser());
    return EmptyReply();
  }
}

extension _ToUser on UserMessage {
  User toUser() => User(
        id: id,
        name: name,
        email: email,
        age: age,
      );
}

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final int age;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  @override
  List<Object> get props => [id, name, email, age];

  @override
  bool get stringify => true;

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        age: map['age'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
    };
  }

  UserMessage toUserMessage() => UserMessage(
        id: id,
        name: name,
        email: email,
        age: age,
      );
}
