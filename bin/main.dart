import 'package:dart_grpc_playground/app.dart';
import 'package:loggy/loggy.dart';

void main(List<String> arguments) async {
  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));

  final app = await AppFactory().create();
  await app.run();
}
