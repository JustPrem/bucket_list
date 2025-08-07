// ---- Imports ----

// Base.
import 'package:flutter/material.dart';

// Provider.
import 'package:bucket_list/providers/task_provider.dart';

// Data Models.
import 'package:bucket_list/data_models/task.dart';

// External/
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
      padding: const EdgeInsets.all(10),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Text("ID: ${task.id} - ${task.taskName}", style: Theme.of(context).textTheme.titleLarge),
          IconButton(icon: Icon(task.isCompleted? Icons.check_box : Icons.check_box_outline_blank), onPressed: () { ref.read(taskListProvider.notifier).completeTask(task); }),
        ]
      ),
    );
  }
}
