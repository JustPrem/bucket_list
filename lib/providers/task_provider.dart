// ---- Imports -----

// Built-in
import 'package:path/path.dart';

// Custom
import 'package:bucket_list/data_models/task.dart';

// External
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

// Add the generated file.
part 'task_provider.g.dart';

/// TaskList provider.
@riverpod
class TaskList extends _$TaskList
{
  // ------------ Variables ------------

  Database? _database;

  // ------------ Provider build - like a constructor for providers.
  @override
  List<Task> build() { _initialiseDatabase(); return const []; }
  
  // ------------ Private Methods ------------

  // Initialise the sql database.
  Future<void> _initialiseDatabase() async
  {
    _database = await openDatabase
    (
      join(await getDatabasesPath(), 'tasks.db'),
      version: 1,
      onCreate: (db, version)
      {
        return db.execute
        (
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, taskName TEXT, isCompleted INTEGER)",
        );
      }
    );

    // Load the database.
    await _loadTasks();
  }

  // Load the database.
  Future<void> _loadTasks() async
  {
    // Query the database.
    final List<Map<String, dynamic>> maps = await _database!.query('tasks');
    
    // Set the state.
    state = maps.map((map) => Task.fromMap(map)).toList();
  }

  // ------------ Public Methods ------------

  /// Add a new task.
  Future<void> addTask(Task task) async
  {
    // Add the task to the database.
    await _database!.insert('tasks', task.toMap());

    // Rebuild the state by adding the new task onto the end of the list.
    state = [...state, task];
  }

  /// Remove a task.
  Future<void> removeTask(Task task) async
  {
    // Remove a task from the database.
    await _database!.delete('tasks', where: 'id = ?', whereArgs: [task.id]);

    // Rebuild the state by excluding the to-be removed task.
    state = state.where((t) => t.id != task.id).toList();
  }

  /// Reset all the tasks.
  Future<void> resetTasks() async
  {
    // Clear the database.
    await _database!.delete('tasks');

    // Clear the list.
    state = const [];
  }

  /// Complete a specific task.
  Future<void> completeTask(Task task) async
  {
    // Get a list of tasks.
    List<Task> tasks = state;
      
    // Toggle the correct task.
    for (Task t in tasks)
    {
      if (t.id == task.id)
      {
        // Update the list.
        t.isCompleted = !task.isCompleted;

        // Update the database.
        await _database!.update
        (
          'tasks',
          {'isCompleted': t.isCompleted? 1 : 0},
          where: 'id = ?',
          whereArgs: [t.id],
        );
        break;
      }
    }

    // Set the state.
    state = tasks;   
  }

  /// Get the next valid ID.
  int getNextID()
  {
    // Get the list of tasks.
    List<Task> tasks = state;

    // Create a variable to store the ID.
    int id = 0;

    // look for the next valid ID.
    while(tasks.any((task) => task.id == id))
    {
      id++;
    }
    
    // Get the next valid id.
    return id;
  }
}

