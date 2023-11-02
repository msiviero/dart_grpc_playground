import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:mysql1/mysql1.dart';

part 'mysql_provider.g.dart';

@Provider()
class CustomerRepoProvider implements ProviderBase<MySqlConnection> {
  MySqlConnection? _instance;

  @override
  Future<MySqlConnection> provide() async {
    final settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'root',
      password: 'example',
      db: 'dart_playground',
    );

    _instance ??= await MySqlConnection.connect(settings);

    return _instance!;
  }
}
