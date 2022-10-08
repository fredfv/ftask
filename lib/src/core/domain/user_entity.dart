import 'entity_base.dart';

class UserEntity extends EntityBase {
  String login;
  String secret;
  String name;
  String role;
  String token;

  UserEntity({
    required this.login,
    required this.secret,
    required this.name,
    required this.token,
    required this.role,
    required String id,
    required DateTime created,
  }) : super(id: id, created: created);

  @override
  Map<String, dynamic> toJson() {
    return {'login': login, 'secret': secret, 'name': name, 'token': token, 'id': id, 'created': created};
  }

  factory UserEntity.fromJson(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] as String,
      created: map['created'] as DateTime,
      login: map['login'] as String,
      secret: map['secret'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
      role: map['token'] as String,
    );
  }

  factory UserEntity.fromAuth(Map<String, dynamic> map) {
    return UserEntity(
      id: map['person']['id'] as String,
      created: DateTime.tryParse(map['person']['insertDate']) as DateTime,
      login: map['person']['username'] as String,
      secret: map['person']['password'] as String,
      name: map['person']['name'] as String,
      token: map['token'] as String,
      role: map['person']['role'] as String,
    );
  }

  @override
  String toString() {
    return 'UserEntity{login: $login, secret: $secret, name: $name, id: $id, created: $created} ,  token: $token';
  }
}
