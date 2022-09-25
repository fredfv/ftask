import 'entity_base.dart';
import 'map/mapper.dart';

class TaskEntity extends EntityBase {
  String description;

  TaskEntity(
      {required this.description,
      required String id,
      required DateTime created})
      : super(id: id, created: created);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'created': created,
    };
  }

  factory TaskEntity.fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map['id'] as String,
      description: map['description'] as String,
      created: map['created'] as DateTime,
    );
  }

  @override
  String toString() {
    return 'TaskEntity{id: $id, description: $description, created: $created}';
  }
}

class TaskMapper extends Mapper<TaskEntity>{
  @override
  TaskEntity? fromMap(Map<String, dynamic>? map) {
    if(map == null) return null;
    return TaskEntity.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(TaskEntity value) {
    return value.toJson();
  }
}

