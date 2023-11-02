import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:mysql1/mysql1.dart';

import '../provider/mysql_provider.dart';

part 'user_service.g.dart';

@Singleton()
class UserService {
  final MySqlConnection _sql;

  UserService(@ProvidedBy(SqlProvider) this._sql);
}
