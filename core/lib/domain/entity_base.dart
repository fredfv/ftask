abstract class EntityBase{
  String id;
  DateTime created;

  EntityBase({required this.id, required this.created});

  Map<String, dynamic> toJson();
}