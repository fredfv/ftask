import 'entity_base.dart';

class TaskEntity extends EntityBase {
  String _description;
  String _title;
  String _dueDate;
  bool _onBoard;

  String get description => _description;

  void setDescription(String? value) => _description = value ?? '';

  String get title => _title;

  void setTitle(String? value) => _title = value ?? '';

  String get dueDate => _dueDate;

  void setDueDate(String? value) => _dueDate = value ?? '';

  bool get onBoard => _onBoard;

  void setOnBoard(bool value) => _onBoard = value;

  TaskEntity({
    required String description,
    required String title,
    required String dueDate,
    required bool onBoard,
    required String id,
    required DateTime created,
    required DateTime persisted,
    DateTime? deleted,
  })  : _description = description,
        _dueDate = dueDate,
        _title = title,
        _onBoard = onBoard,
        super(
          id: id,
          created: created,
          persisted: persisted,
          deleted: deleted,
        );

  factory TaskEntity.empty() {
    return TaskEntity(
      description: '',
      title: '',
      dueDate: '',
      onBoard: false,
      id: '',
      created: DateTime.fromMillisecondsSinceEpoch(0),
      persisted: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'title': title,
      'dueDate': dueDate,
      'onBoard': onBoard,
      'id': id,
      'created': created,
      'persisted': persisted,
      'deleted': deleted,
    };
  }

  //factory TaskEntity.fromJson(Map<String, dynamic> map) {
  factory TaskEntity.fromJson(dynamic map) {
    return TaskEntity(
      description: map['description'] as String,
      title: map['title'] ?? '',
      dueDate: map['dueDate'] as String,
      onBoard: map['onBoard'] as bool,
      id: map['id'] as String,
      created: map['created'] as DateTime,
      persisted: map['persisted'] as DateTime,
      deleted: map['deleted'] as DateTime?,
    );
  }

  factory TaskEntity.fromCloud(dynamic map) {
    return TaskEntity(
      description: map['description'] as String,
      title: map['title'] ?? '',
      dueDate: map['dueDate'] as String,
      onBoard: map['onBoard'] as bool,
      id: map['id'] as String,
      created: DateTime.parse(map['insertDate']),
      persisted: DateTime.parse(map['persistenceDate']),
      deleted: map['deletionDate'] == null
          ? null
          : DateTime.tryParse(map['deletionDate']),
    );
  }

  @override
  String toString() {
    return 'TaskEntity(description: $description, title: $title, dueDate: $dueDate, onBoard: $onBoard, id: $id, created: $created, persisted: $persisted, deleted: $deleted)';
  }
}
