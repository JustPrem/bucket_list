// ---- Imports ----

// Base.
import 'package:flutter/material.dart';

// Data Models.
import 'package:bucket_list/data_models/task.dart';
import 'package:bucket_list/data_models/settings.dart';

// Widgets.
import 'package:bucket_list/widgets/task_element.dart';
import 'package:bucket_list/widgets/add_task_dialog.dart';

// Providers.
import 'package:bucket_list/providers/task_provider.dart';
import 'package:bucket_list/providers/settings_provider.dart';

// External.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ---- Route - Home ----
class RouteHome extends ConsumerWidget
{
  // Constructor.
  const RouteHome({super.key});

  // Build Method.
  @override Widget build(BuildContext context, WidgetRef ref)
  {
    final List<Task> allTasks = ref.watch(taskListProvider);
    final Settings settings = ref.watch(settingsStateProvider);

    return Scaffold
    (
      appBar: AppBar
      (
        title: Row
        (
          children:
          [
            // Left-side buttons.
            IconButton(icon: Icon(settings.darkMode? Icons.nights_stay : Icons.wb_sunny), onPressed: () { ref.read(settingsStateProvider.notifier).toggleDarkMode(); }),
            // Title.
            Expanded(child: Center(child: Text("Bucket List", style: Theme.of(context).textTheme.titleLarge))), 
            // Right-side buttons.
            IconButton(icon: Icon(Icons.add), onPressed: ()
            {
              // Open a dialog to add a new task.
              showDialog
              (
                context: context,
                builder: (context) => AddTaskDialog(id: allTasks.length + 1),
              );
            }),
          ]
        )
      ),
      body: SafeArea
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            // List of Tasks.
            Flexible
            (
              flex: 85,
              child: (allTasks.isNotEmpty)? 
              
              // If there are tasks.
              ListView.builder
              (
                itemCount: allTasks.length,
                itemBuilder: (context, index)
                {
                  return TaskElement(task: allTasks[index]);
                },
              )

              :
              
              // There are no tasks to do.
              Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Expanded(child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Text("There are no tasks")
                    ]
                  )),
                ]
              )
            ),
          ]
        )
      )
    );
  }
}
