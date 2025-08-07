/* ---- Data Model - Task ----

  Used for storing the data for each task.

*/

class Task
{
  // Variables.
  final int id;
  final String taskName;
  bool isCompleted;

  // Constructor.
  Task
  ({
    required this.id,
    required this.taskName,
    this.isCompleted = false,
  });
}
