import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'todo.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> _todos = [];
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int? _editingId;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final data = await DBHelper.getTodos();
    setState(() => _todos = data);
  }

  void _saveTodo() async {
    final title = _titleController.text;
    final desc = _descController.text;

    if (_editingId == null) {
      await DBHelper.insert(Todo(title: title, description: desc));
    } else {
      await DBHelper.update(
          Todo(id: _editingId, title: title, description: desc));
      _editingId = null;
    }

    _titleController.clear();
    _descController.clear();
    _loadTodos();
  }

  void _editTodo(Todo todo) {
    _titleController.text = todo.title;
    _descController.text = todo.description;
    setState(() => _editingId = todo.id);
  }

  void _deleteTodo(int id) async {
    await DBHelper.delete(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TodoList")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title')),
            TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description')),
            ElevatedButton(
                onPressed: _saveTodo,
                child: Text(_editingId == null ? "Add" : "Update")),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (ctx, i) {
                  final todo = _todos[i];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editTodo(todo)),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTodo(todo.id!)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
