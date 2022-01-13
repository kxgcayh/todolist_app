class TodoListModel {
  TodoListModel({
    required this.statusCode,
    required this.message,
    this.errorMessage,
    this.data,
  });

  final int statusCode;
  final String message;
  final String? errorMessage;
  final List<TodoData>? data;

  factory TodoListModel.fromJson(Map<String, dynamic> json) => TodoListModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data:
            List<TodoData>.from(json["data"].map((x) => TodoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TodoData {
  TodoData({
    required this.id,
    required this.name,
    this.items,
    required this.checklistCompletionStatus,
  });

  final int id;
  final String name;
  final List<TodoItem>? items;
  final bool checklistCompletionStatus;

  factory TodoData.fromJson(Map<String, dynamic> json) => TodoData(
        id: json["id"],
        name: json["name"],
        items: json["items"] == null
            ? null
            : List<TodoItem>.from(
                json["items"].map((x) => TodoItem.fromJson(x))),
        checklistCompletionStatus: json["checklistCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "checklistCompletionStatus": checklistCompletionStatus,
      };
}

class TodoItem {
  TodoItem({
    required this.id,
    required this.name,
    required this.itemCompletionStatus,
  });

  final int id;
  final String name;
  final bool itemCompletionStatus;

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        id: json["id"],
        name: json["name"],
        itemCompletionStatus: json["itemCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "itemCompletionStatus": itemCompletionStatus,
      };
}
