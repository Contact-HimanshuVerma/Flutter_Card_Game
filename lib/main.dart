import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = "Card Game";

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(child: const Text(appTitle)),
          ),
        ),
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController _nameController = TextEditingController();
  List<String> todos = [];

  void addToDo() {
    setState(() {
      String todoText = _nameController.text.trim();
      if (todoText.isNotEmpty) {
        todos.add(todoText);
        _nameController.clear();
      }
    });
  }

  void shuffleTodos() {
    setState(() {
      todos.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Card option',
                  ),
                  controller: _nameController,
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: addToDo,
                child: Text('+ Add'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: shuffleTodos,
                child: Text('Shuffle'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: FlipCard(
                    front: customCard("Click to Reveal"),
                    back: customCard(todos[index]),
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

Widget customCard(String title) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(20),
    color: Colors.blue,
    child: Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
