import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.index,
    required this.taskName,
    required this.taskCheck,
    required this.onChanged,
    required this.deleteTask,
    required this.editTask,
  });

  final int index;
  final String taskName;
  final bool taskCheck;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  final Function(int)? editTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete_forever,
            borderRadius: BorderRadius.circular(15),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: taskCheck,
                    onChanged: onChanged,
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                  ),
                  Text(
                    taskName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: taskCheck
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Colors.white,
                        decorationThickness: 2.9),
                  ),
                ],
              ),
              PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      editTask!(index);
                    } else if (value == 'delete') {
                      deleteTask!(context);
                    }
                  },
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "edit",
                          child: Text("edit"),
                        ),
                        const PopupMenuItem(
                          value: "delete",
                          child: Text("delete"),
                        )
                      ])
            ],
          ),
        ),
      ),
    );
  }
}
