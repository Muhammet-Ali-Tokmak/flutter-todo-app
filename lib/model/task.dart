import 'package:todo_app/constants/tasktype.dart';

class Task {
  Task(
      {required this.tpye,
      required this.title,
      required this.description,
      required this.isCompleted});

  final TaskType tpye;
  final String title;
  final String description;
  bool isCompleted;
}
