import 'entity_base.dart';

class TaskEntity extends EntityBase {
  String _description;
  String _title;
  String _dueDate;

  String get description => _description;

  void setDescription(String? value) => _description = value ?? '';

  String get dueDate => _dueDate;

  void setDueDate(String? value) => _dueDate = value ?? '';

  String get title => _title;

  void setTitle(String? value) => _title = value ?? '';

  TaskEntity(
      {required String description,
      required String dueDate,
      required String id,
      required DateTime created,
      required String title})
      : _description = description,
        _dueDate = dueDate,
        _title = title,
        super(
          id: id,
          created: created,
        );

  factory TaskEntity.empty() {
    return TaskEntity(
      description: '',
      dueDate: '',
      id: '',
      created: DateTime.fromMillisecondsSinceEpoch(0),
      title: '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'dueDate': dueDate,
      'id': id,
      'created': created,
      'title': title,
    };
  }

  //factory TaskEntity.fromJson(Map<String, dynamic> map) {
  factory TaskEntity.fromJson(dynamic map) {
    return TaskEntity(
      description: map['description'] as String,
      dueDate: map['dueDate'] as String,
      id: map['id'] as String,
      created: map['created'] as DateTime,
      title: map['title'] ?? '',
    );
  }

  factory TaskEntity.fromApi(dynamic map) {
    return TaskEntity(
      description: map['description'] as String,
      dueDate: map['dueDate'] as String,
      id: map['id'] as String,
      created: DateTime.parse(map['insertDate']),
      title: map['title'] ?? '',
    );
  }

  @override
  String toString() {
    return 'TaskEntity{dueDate: $dueDate description: $description, id: $id, created: $created}';
  }
}
