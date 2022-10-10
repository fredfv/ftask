import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task/src/core/domain/user_entity.dart';

class MockUserFromAuth extends Mock {
  final Map<String, dynamic> authData = {
    'person': {
      'id': '1',
      'insertDate': '2021-09-01T00:00:00.000Z',
      'username': 'username',
      'password': 'password',
      'name': 'name',
      'role': 'role',
    },
    'token': 'token'
  };
}

void main() {
  test('should create an new instance', () {
    UserEntity userEntity = UserEntity(
      id: '',
      name: '',
      login: '',
      secret: '',
      role: '',
      token: '',
      created: DateTime.now(),
    );
    expect(userEntity, isA<UserEntity>());
  });

  UserEntity userEntity = UserEntity(
    id: '',
    name: '',
    login: '',
    secret: '',
    role: '',
    token: '',
    created: DateTime.fromMillisecondsSinceEpoch(1),
  );

  test('should implement toString', () {
    expect(userEntity.toString(), isA<String>());
  });

  test('should set values to all fields using setters', () {
    userEntity.setId('id');
    userEntity.setName('name');
    userEntity.setLogin('login');
    userEntity.setSecret('secret');
    userEntity.setRole('role');
    userEntity.setToken('token');
    userEntity.setCreated(DateTime.fromMillisecondsSinceEpoch(1));
    expect(userEntity.id, 'id');
    expect(userEntity.name, 'name');
    expect(userEntity.login, 'login');
    expect(userEntity.secret, 'secret');
    expect(userEntity.role, 'role');
    expect(userEntity.token, 'token');
  });

  test('should implement toJson', () {
    expect(userEntity.toJson(), isA<Map<String, dynamic>>());
  });

  test('should return a json with the values of the fields', () {
    userEntity = UserEntity(
      id: 'id',
      name: 'name',
      login: 'login',
      secret: 'secret',
      role: 'role',
      token: 'token',
      created: DateTime.fromMillisecondsSinceEpoch(1),
    );
    expect(userEntity.toJson(), {
      'id': 'id',
      'name': 'name',
      'login': 'login',
      'secret': 'secret',
      'role': 'role',
      'token': 'token',
      'created': DateTime.fromMillisecondsSinceEpoch(1),
    });
  });

  test('should return a new instance with the values of the json', () {
    userEntity = UserEntity.fromJson({
      'id': 'id',
      'name': 'name',
      'login': 'login',
      'secret': 'secret',
      'role': 'role',
      'token': 'token',
      'created': DateTime.fromMillisecondsSinceEpoch(1),
    });
    expect(userEntity.id, 'id');
    expect(userEntity.name, 'name');
    expect(userEntity.login, 'login');
    expect(userEntity.secret, 'secret');
    expect(userEntity.role, 'role');
    expect(userEntity.token, 'token');
    expect(userEntity.created, DateTime.fromMillisecondsSinceEpoch(1));
  });

  test('should create a UserEntity using the values of the auth mocked at UserMockAuth', () {
    final userMockAuth = MockUserFromAuth();
    userEntity = UserEntity.fromAuth(userMockAuth.authData);
    expect(userEntity.id, '1');
    expect(userEntity.name, 'name');
    expect(userEntity.login, 'username');
    expect(userEntity.secret, 'password');
    expect(userEntity.role, 'role');
    expect(userEntity.token, 'token');
  });
}
