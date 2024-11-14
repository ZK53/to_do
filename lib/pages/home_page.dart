import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/day_date.dart';
import 'package:to_do_app/utilities/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade300,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DayDate(),
            const Text(
              "ToDo",
              style: TextStyle(fontSize: 40),
            ),
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () => setState(() {
                toDoList.clear();
              }),
              iconSize: 35,
            )
          ]),
        ),
        body: SizedBox(
          height: 630,
          child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (BuildContext context, int index) {
                return TodoList(
                    index: index,
                    taskName: toDoList[index][0],
                    taskCheck: toDoList[index][1],
                    onChanged: (val) {
                      setState(() {
                        toDoList[index][1] = val;
                      });
                    },
                    deleteTask: (context) {
                      setState(() {
                        toDoList.removeAt(index);
                      });
                    },
                    editTask: (index) => editTask(context, index));
              }),
        ),
        floatingActionButton: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 20,
              ),
              child: TextField(
                style: const TextStyle(fontSize: 20),
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'New Task',
                    filled: true,
                    fillColor: Colors.deepPurple.shade200,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15))),
              ),
            )),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_controller.text.isNotEmpty) {
                    toDoList.add([_controller.text, false]);
                    _controller.clear();
                  }
                });
              },
              child: const Icon(Icons.add),
            )
          ],
        ));
  }

  editTask(BuildContext context, int index) {
    TextEditingController editingController =
        TextEditingController(text: toDoList[index][0]);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Editing ToDo",
              style: TextStyle(fontSize: 24),
            ),
            content: TextField(
              style: const TextStyle(fontSize: 20),
              controller: editingController,
              decoration: InputDecoration(
                  hintText: 'Edit Task',
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(15))),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      toDoList[index][0] = editingController.text;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }
}
