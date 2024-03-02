import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teaching_firebase/common/commn_button.dart';
import 'package:teaching_firebase/common/commom_text_filed.dart';
import 'package:teaching_firebase/common/utils.dart';
import 'package:teaching_firebase/todo/services/todo_service.dart';
import 'package:teaching_firebase/todo/todo_provider/todo_provider.dart';
import 'package:uuid/uuid.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController taskController = TextEditingController();
  final TodoService _todoService = TodoService();

  bool isUpdating = false;
  String oldId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoService.getTodoForUser(
      userID: FirebaseAuth.instance.currentUser!.uid,
      context: context,
    );
  }

  void addTask() {
    if (taskController.text.isEmpty) {
      showSnackBar(context, "Please enter task Name");
    } else {
      _todoService.addTodos(
        taskName: taskController.text,
        taskId: const Uuid().v1(),
        userID: FirebaseAuth.instance.currentUser!.uid,
        context: context,
      );
      taskController.clear();
    }
  }

  void updateTask() {
    if (taskController.text.isEmpty) {
      showSnackBar(context, "Please enter task Name");
    } else {
      _todoService.updateTodo(
        userID: FirebaseAuth.instance.currentUser!.uid,
        todoId: oldId,
        updatedTask: taskController.text,
        context: context,
      );
      taskController.clear();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CommonTextField(
              controller: taskController,
              hintText: "Please enter your task",
              icon: Icons.calendar_month_outlined,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              onTap: () {
                isUpdating ? updateTask() : addTask();
              },
              text: "Add Task",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Available Tasks"),
            const SizedBox(
              height: 20,
            ),
            Consumer<TodoProvider>(builder: (context, value, child) {
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.todoModel.length,
                    itemBuilder: (context, index) {
                      final data = value.todoModel[index];
                      return Card(
                        child: ListTile(
                          title: Text(data.taskName),
                          leading: Text((index + 1).toString()),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        taskController.text = data.taskName;
                                        oldId = data.taskId;
                                        isUpdating = true;
                                      });
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      _todoService.deleteTodo(
                                        userID: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        todoId: data.taskId,
                                        context: context,
                                      );
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
