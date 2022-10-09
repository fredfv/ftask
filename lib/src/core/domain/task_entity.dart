import 'entity_base.dart';
import 'value_objects/description_vo.dart';
import 'value_objects/due_date_vo.dart';
import 'value_objects/title_vo.dart';

class TaskEntity extends EntityBase {
  DescriptionVO _description;
  TitleVO _title;
  DueDateVO _dueDate;

  DescriptionVO get description => _description;

  void setDescription(String? value) =>
      _description = DescriptionVO(value ?? '');

  DueDateVO get dueDate => _dueDate;

  void setDueDate(String? value) => _dueDate = DueDateVO(value ?? '');

  TitleVO get title => _title;

  void setTitle(String? value) => _title = TitleVO(value ?? '');

  TaskEntity(
      {required String description,
      required String dueDate,
      required String id,
      required DateTime created,
      required String title})
      : _description = DescriptionVO(description),
        _dueDate = DueDateVO(dueDate),
        _title = TitleVO(title),
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
      'description': description.toString(),
      'dueDate': dueDate.toString(),
      'id': id,
      'created': created,
      'title': title.toString()
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

  @override
  String toString() {
    return 'TaskEntity{dueDate: $dueDate description: $description, id: $id, created: $created}';
  }
}
