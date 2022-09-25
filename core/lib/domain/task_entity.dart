import 'package:core/domain/value_objects/description_vo.dart';
import 'package:core/domain/value_objects/due_date_vo.dart';

import 'entity_base.dart';
import 'map/mapper.dart';

class TaskEntity extends EntityBase {
  DescriptionVO _description;
  DueDateVO _dueDate;

  DescriptionVO get description => _description;

  void setDescription(String? value) =>
      _description = DescriptionVO(value ?? '');

  DueDateVO get dueDate => _dueDate;

  void setDueDate(String? value) => _dueDate = DueDateVO(value ?? '');

  TaskEntity(
      {required String description,
      required String dueDate,
      required String id,
      required DateTime created})
      : _description = DescriptionVO(description),
        _dueDate = DueDateVO(dueDate),
        super(id: id, created: created);

  factory TaskEntity.empty() {
    return TaskEntity(
      description: '',
      dueDate: '',
      id: '',
      created: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'description': description.toString(),
      'dueDate': dueDate,
      'id': id.toString(),
      'created': created
    };
  }

  factory TaskEntity.fromJson(Map<String, dynamic> map) {
    return TaskEntity(
      description: map['description'] as String,
      dueDate: map['dueDate'] as String,
      id: map['id'] as String,
      created: map['created'] as DateTime,
    );
  }

  @override
  String toString() {
    return 'TaskEntity{dueDate: $dueDate description: $description, id: $id, created: $created}';
  }
}

class TaskMapper extends Mapper<TaskEntity> {
  @override
  TaskEntity? fromJson(Map<String, dynamic>? map) {
    if (map == null) return null;
    return TaskEntity.fromJson(map);
  }

  @override
  Map<String, dynamic> toJson(TaskEntity value) {
    return value.toJson();
  }
}
