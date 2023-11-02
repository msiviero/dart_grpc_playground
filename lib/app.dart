import 'dart:io';

import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:grpc/grpc.dart';
import 'package:loggy/loggy.dart';

import 'api/user_route.dart';

part 'app.g.dart';

@Singleton()
class App with UiLoggy {
  final UserRoute _userRoute;

  App(this._userRoute);

  Future<void> run() async {
    loggy.info("Hello world");

    Server.create(services: [
      _userRoute,
    ]).serve(
        address: "0.0.0.0",
        port: int.tryParse(Platform.environment["PORT"] ?? "50051"));
  }
}
