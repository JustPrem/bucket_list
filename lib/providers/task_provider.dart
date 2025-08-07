// ---- Imports -----

// Custom
import 'package:bucket_list/data_models/task.dart';

// External
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Add the generated file.
part 'task_provider.g.dart';

/// TaskList provider.
@riverpod
class TaskList extends _$TaskList
{
  // Provider build - like a constructor for providers.
  @override
  List<Task> build() { return const []; }

  /// Add a new task.
  void addTask(Task task)
  {
    // Rebuild the state by adding the new task onto the end of the list.
    state = [...state, task];
  }

  /// Remove a task.
  void removeTask(Task task)
  {
    // Rebuild the state by excluding the to-be removed task.
    state = state.where((t) => t.id != task.id).toList();
  }

  /// Reset all the tasks.
  void resetTasks()
  {
    state = const [];
  }

  /// Complete a specific task.
  void completeTask(Task task)
  {
    // Get a list of tasks.
    List<Task> tasks = state;
      
    // Toggle the correct task.
    for (Task t in tasks)
    {
      if (t.id == task.id)
      {
        t.isCompleted = !task.isCompleted;
      }
    }

    // Set the state.
    state = tasks;
    
  }
}


