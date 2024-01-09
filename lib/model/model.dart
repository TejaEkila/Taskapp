class DataModel {
  int? id;
  late String taskname;
  late String setdate;
  late String description;
  late bool isImportant; // New property
  late bool isNone;      // New property

  DataModel({
    this.id,
    required this.taskname,
    required this.setdate,
    required this.description,
    required this.isImportant,
    required this.isNone,
  });

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        id: json["id"],
        taskname: json["taskname"],
        setdate: json["setdate"],
        description: json["description"],
        isImportant: json["isImportant"] == 1, // 1 represents true in SQLite
        isNone: json["isNone"] == 1,           // 1 represents true in SQLite
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "taskname": taskname,
        "setdate": setdate,
        "description": description,
        "isImportant": isImportant ? 1 : 0, // Convert bool to 1 or 0
        "isNone": isNone ? 1 : 0,           // Convert bool to 1 or 0
      };
}
