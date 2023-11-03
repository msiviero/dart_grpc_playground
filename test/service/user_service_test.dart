import 'package:dart_grpc_playground/service/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([
  MockSpec<MySQLConnectionPool>(),
  MockSpec<ResultSet>(),
  MockSpec<ResultSetRow>(),
])
import 'user_service_test.mocks.dart';

void main() {
  test('Should fetch one user', () async {
    final expected = User(
      id: 1,
      name: "marco",
      email: "m.siviero@example.com",
      age: 40,
    );

    final mockSql = MockMySQLConnectionPool();
    final mockResultSet = MockResultSet();

    when(mockSql.execute('SELECT * FROM users WHERE id=:id', {'id': 1}, false))
        .thenAnswer((_) => Future.value(mockResultSet));

    final userRow = expected.toMockRow();

    when(mockResultSet.rows).thenReturn([
      userRow,
    ]);

    final underTest = UserService(mockSql);

    expect(await underTest.get(1), expected);
  });

  test('Should fetch all users', () async {
    final users = [
      User(
        id: 1,
        name: "marco",
        email: "m.siviero@example.com",
        age: 40,
      ),
      User(
        id: 2,
        name: "ambra",
        email: "ambra@example.com",
        age: 38,
      ),
    ];

    final mockSql = MockMySQLConnectionPool();
    final mockResultSet = MockResultSet();

    when(mockSql.execute('SELECT * FROM users', {}, true))
        .thenAnswer((_) => Future.value(mockResultSet));

    final row1 = users[0].toMockRow();
    final row2 = users[1].toMockRow();

    when(mockResultSet.rowsStream)
        .thenAnswer((_) => Stream.fromIterable([row1, row2]));

    final underTest = UserService(mockSql);

    expect(await underTest.list().toList(), equals(users));
  });

  test("Should insert user", () async {
    final mockSql = MockMySQLConnectionPool();
    ();

    final user = User(
      id: 0,
      name: "marco",
      email: "m.siviero@example.com",
      age: 40,
    );

    final underTest = UserService(mockSql);

    underTest.put(user);

    verify(mockSql.execute(
      'INSERT INTO users (name, email, age) values (:name, :email, :age)',
      {
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "age": user.age,
      },
    ));
  });
}

extension _NewMockUserRow on User {
  MockResultSetRow toMockRow() {
    final mock = MockResultSetRow();
    when(mock.typedAssoc()).thenReturn(toMap());
    return mock;
  }
}
