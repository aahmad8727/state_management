import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key); // Added key parameter for good practice

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Manager', home: TaskListScreen());
  }
}

class Task {
  String name;
  bool completed;
  String priority; // Optionally, you can use an enum for priority

  // All parameters are required and must not be null
  Task({required this.name, this.completed = false, this.priority = 'Low'});
}

class TaskListScreen extends StatefulWidget {
  TaskListScreen({Key? key}) : super(key: key); // Added key parameter

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void addTask(String taskName, String priority) {
    setState(() {
      tasks.add(Task(name: taskName, priority: priority));
    });
  }

  void toggleComplete(int index) {
    setState(() {
      tasks[index].completed = !tasks[index].completed;
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) {
                addTask(value, 'Low'); // Default priority to 'Low' for now
              },
              decoration: InputDecoration(
                labelText: 'Enter task name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // This can be updated to handle button press for adding tasks
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].name),
                  subtitle: Text('Priority: ${tasks[index].priority}'),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Icon(
                        tasks[index].completed
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: tasks[index].completed ? Colors.green : null,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removeTask(index);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    toggleComplete(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
