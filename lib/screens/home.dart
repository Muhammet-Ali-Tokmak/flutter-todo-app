import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/addnewtask.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    todoService.getUncompletedTodos();
    //List<String> todo = ["Study Lessons", "Run 5k", "Go To Party"];
    //List<String> completed = ["Game Meetup", "Take Out Trash"];

    void addNewTask(Task newTask) {
      setState(() {
        todo.add(newTask);
      });
    }

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight / 3,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  image: DecorationImage(
                      image: AssetImage("lib/assets/images/Header.png"),
                      fit: BoxFit.cover),
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "March 3, 2025",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 42),
                      child: Text(
                        "My Todo List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: todoService.getUncompletedTodos(),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return TodoItem(
                                  task: snapshot.data![index],
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 21),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Completed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                    future: todoService.getCompletedTodos(),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return TodoItem(
                                task: snapshot.data![index],
                              );
                            });
                      }
                    },
                  )),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddnewtaskScreen(
                        addNewTask: (newTask) => addNewTask(newTask),
                      ),
                    ));
                  },
                  child: const Text("Add New Tasks"))
            ],
          ),
        ),
      ),
    );
  }

  List<Task> todo = [
    Task(
      tpye: TaskType.note,
      title: "Study Lessons",
      description: "Study COMP117",
      isCompleted: false,
    ),
    Task(
      tpye: TaskType.calendar,
      title: "Go To Party",
      description: "Attend To Party",
      isCompleted: false,
    ),
    Task(
      tpye: TaskType.contest,
      title: "Run 5K",
      description: "Run 5 Kilometers",
      isCompleted: false,
    ),
  ];

  List<Task> completed = [
    Task(
      tpye: TaskType.calendar,
      title: "Go To Party",
      description: "Attend To Party",
      isCompleted: false,
    ),
    Task(
      tpye: TaskType.contest,
      title: "Run 5K",
      description: "Run 5 Kilometers",
      isCompleted: false,
    ),
  ];
}
