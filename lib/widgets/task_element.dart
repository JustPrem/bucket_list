// ---- Imports ----

// Base.
import 'package:flutter/material.dart';

// Provider.
import 'package:bucket_list/providers/task_provider.dart';

// Data Models.
import 'package:bucket_list/data_models/task.dart';

// External
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ---- Widget - Task Element ----
class TaskElement extends ConsumerWidget
{
  // Variables.
  final Task task;

  // Constructor.
  const TaskElement
  ({
    required this.task,
    super.key
  });

  // Build method.
  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    return Container
    (
      // Styling.
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration
      (
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow:
        [
          BoxShadow
          (
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.25),
            offset: Offset(0, 4),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ]
      ),
      // Contents.
      child: Row
      (
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          IconButton(icon: Icon(Icons.delete_forever_rounded), onPressed: () { ref.read(taskListProvider.notifier).removeTask(task); }),
          Expanded
          (
            child: Stack
            (
              alignment: Alignment.center,
              children:
              [
                Text("${task.taskName} (ID: ${task.id})", style: Theme.of(context).textTheme.titleMedium),
                if (task.isCompleted) Container(height: 2, color: Theme.of(context).colorScheme.onSurfaceVariant)
              ]
            )
          ),
          IconButton(icon: Icon(task.isCompleted? Icons.check_box : Icons.check_box_outline_blank), onPressed: () { ref.read(taskListProvider.notifier).completeTask(task); }),
        ]
      ),
    );
  }
}
