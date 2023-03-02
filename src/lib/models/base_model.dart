class BaseModel {
  int id;
  String name;
  DateTime? createdAt = DateTime.now();
  BaseModel({
    this.id = 0,
    this.name = '',
  });
}
