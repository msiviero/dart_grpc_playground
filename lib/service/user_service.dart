import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:loggy/loggy.dart';
import 'package:mysql_client/mysql_client.dart';

import '../provider/mysql_provider.dart';

part 'user_service.g.dart';

@Singleton()
class UserService with UiLoggy {
  final MySQLConnectionPool _sql;

  UserService(@ProvidedBy(SqlProvider) this._sql);

  Future<User?> get(final int id) async {
    final result = await _sql.execute(
      'SELECT * FROM users WHERE id=:id',
      {'id': id},
    );

    final row = result.rows.firstOrNull;

    if (row == null) {
      return null;
    }

    return User.fromMap(row.typedAssoc());
  }

  Stream<User> list() async* {
    final results = await _sql.execute('SELECT * FROM users', {}, true);

    await for (final row in results.rowsStream) {
      yield User.fromMap(row.typedAssoc());
    }
  }

  Future<void> put(final User user) async {
    await _sql.execute(
      'INSERT INTO users (name, email, age) values (:name, :email, :age)',
      user.toMap(),
    );
  }
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
}
