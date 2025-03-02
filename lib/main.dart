import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Manager', home: TaskListScreen());
  }
}

class Task {
  String name;
  bool completed;
  String priority;

  Task({required this.name, this.completed = false, this.priority = 'Low'});
}

class TaskListScreen extends StatefulWidget {
  TaskListScreen({Key? key}) : super(key: key);

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
                addTask(value, 'Low'); // Default priority to 'Low'
              },
              decoration: InputDecoration(
                labelText: 'Enter task name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // This should be updated to handle the button press for adding tasks
                    // Currently does nothing on button press
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
                    spacing: 12,
                    children: <Widget>[
                      Checkbox(
                        value: tasks[index].completed,
                        onChanged: (_) {
                          toggleComplete(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removeTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
