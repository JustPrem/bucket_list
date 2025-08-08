/* ---- Data Model - Task ----

  Used for storing the data for each task.

*/

class Task
{
  // Variables.
  late int id;
  late String taskName;
  bool isCompleted = false;

  // Constructor.
  Task
  ({
    required this.id,
    required this.taskName,
    this.isCompleted = false,
  });

  // Convert from map.
  Task.fromMap(Map<String, dynamic> map)
  {
    id = map["id"] ?? -1;
    taskName = map["taskName"];
    isCompleted = (map["isCompleted"] == 1);
  }

  // Convert to map.
  Map<String, dynamic> toMap()
  {
    return {"id": id, "taskName": taskName, "isCompleted": isCompleted? 1 : 0};
  }
}
