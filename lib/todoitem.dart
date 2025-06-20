import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task});
  final Todo task;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.completed! ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /* firebase
            widget.task.tpye == TaskType.note
                ? Image.asset("lib/assets/images/Category.png")
                : widget.task.tpye == TaskType.contest
                    ? Image.asset("lib/assets/images/Category2.png")
                    : Image.asset("lib/assets/images/Category1.png"),
                    */
            Image.asset("lib/assets/images/Category.png"),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.todo!,
                    style: TextStyle(
                        decoration: widget.task.completed!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 21),
                  ),
                  Text(
                    "User: ${widget.task.userId!}",
                    style: TextStyle(
                        decoration: widget.task.completed!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  )
                ],
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (val) => {
                setState(() {
                  widget.task.completed = !widget.task.completed!;
                  isChecked = val!;
                })
              },
            ),
          ],
        ),
      ),
    );
  }
}
