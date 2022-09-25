import 'package:core/domain/entity_base.dart';
import 'package:core/domain/map/mapper.dart';

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
    return {
      'login': login,
      'secret': secret,
      'name': name,
      'token': token,
      'id': id,
      'created': created
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
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

class UserMapper extends Mapper<UserEntity> {
  @override
  UserEntity? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return UserEntity.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(UserEntity value) {
    return value.toJson();
  }
}
