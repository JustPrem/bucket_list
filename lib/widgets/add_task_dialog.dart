// ---- Imports ----

// Base.
import 'package:flutter/material.dart';

// Provider.
import 'package:bucket_list/providers/task_provider.dart';

// Data Models.
import 'package:bucket_list/data_models/task.dart';

// External.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ---- Widget - Add Task Dialog ----
class AddTaskDialog extends ConsumerStatefulWidget
{
  // Constructor.
  const AddTaskDialog({super.key});

  // Variables.
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> 
{
  // Data.
  final TextEditingController _taskNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for managing form data.
  
  String? _taskName;

  // Build Method.
  @override
  Widget build(BuildContext context)
  {
    // Get all tasks.

    return AlertDialog
    (
      title: Text("Create Task"),
      content: SingleChildScrollView
      (
        child: Form
        (
          key: _formKey,
          child: Column
          (
            mainAxisSize: MainAxisSize.min,
            children:
            [
              TextFormField
              (
                controller: _taskNameController,
                decoration: const InputDecoration(labelText: "Task Name"),
                validator: (value)
                {
                  if (value == null || value.isEmpty)
                  {
                    return "Please enter a task name";
                  }
                  return null;
                },
              ),
            ]
          ),
        )
      ),
      actions:
      [
        // Submit button.
        TextButton
        (
          onPressed: ()
          {
            // Check if the content is valid.
            if (_formKey.currentState!.validate())
            {
              // Create the task
              ref.read(taskListProvider.notifier).addTask(Task(id: ref.read(taskListProvider.notifier).getNextID(), taskName: _taskNameController.text));

              // Close this dialog.
              Navigator.of(context).pop();
            }
          },
          child: Text("Submit"),
        ),
        // Cancel button.
        TextButton
        (
          onPressed: () { Navigator.of(context).pop(); },
          child: Text("Cancel"),
        )
      ]
    );
  }
}

