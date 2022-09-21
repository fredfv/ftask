import 'package:core/domain/entity_base.dart';
import 'package:core/domain/map/mapper.dart';

class UserEntity extends EntityBase {
  String login;
  String secret;
  String name;

  UserEntity(
      {required this.login,
      required this.secret,
      required this.name,
      required String id,
      required DateTime created})
      : super(id: id, created: created);

  @override
  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'secret': secret,
      'name': name,
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
    );
  }

  @override
  String toString() {
    return 'UserEntity{login: $login, secret: $secret, name: $name, id: $id, created: $created}';
  }
}

class TaskMapper extends Mapper<UserEntity> {
  @override
  UserEntity? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return UserEntity.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(UserEntity value) {
    return value.toMap();
  }
}
