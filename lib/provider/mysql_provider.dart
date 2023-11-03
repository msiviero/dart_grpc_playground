import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:mysql_client/mysql_client.dart';

part 'mysql_provider.g.dart';

@Provider()
class SqlProvider implements ProviderBase<MySQLConnectionPool> {
  MySQLConnectionPool? _instance;

  @override
  Future<MySQLConnectionPool> provide() async {
    _instance ??= MySQLConnectionPool(
      host: '127.0.0.1',
      port: 3306,
      userName: 'root',
      password: 'example',
      maxConnections: 10,
      databaseName: 'dart_playground',
      secure: false,
    );

    return _instance!;
  }
}
