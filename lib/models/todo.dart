import 'package:meta/meta.dart';

@immutable
class Todo {
  final bool complete;
  final String id;
  final String note;
  final String task;

  Todo(this.complete, this.id, this.note, this.task);

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "id": id,
    };
  }

  static Todo fromJson(Map<String, Object> json) {
    return Todo(
      json["complete"] as bool,
      json["task"] as String,
      json["id"] as String,
      json["note"] as String,
    );
  }
}