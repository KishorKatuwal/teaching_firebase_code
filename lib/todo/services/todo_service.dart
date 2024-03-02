import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teaching_firebase/todo/models/todo_model.dart';
import 'package:teaching_firebase/todo/todo_provider/todo_provider.dart';

import '../../common/utils.dart';

class TodoService {
  void addTodos({
    required String taskName,
    required String taskId,
    required String userID,
    required BuildContext context,
  }) async {
    try {
      final todoDetails = TodoModel(
        taskId: taskId,
        userId: userID,
        taskName: taskName,
        isCompleted: false,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('todos')
          .doc(taskId)
          .set(todoDetails.toJson());
      if (!context.mounted) return;
      showSnackBar(context, "Task SuccessFully added");
      await getTodoForUser(userID: userID, context: context);
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  //get Notes
  Future<void> getTodoForUser({
    required String userID,
    required BuildContext context,
  }) async {
    List<TodoModel> todos = [];
    try {
      final notesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('todos');
      final notesQuery = await notesCollection.get();
      if (notesQuery.docs.isNotEmpty) {
        for (final doc in notesQuery.docs) {
          final data = doc.data();
          final id = doc.id;
          final taskName = data['taskName'];
          final userId = data['userId'];
          final isCompleted = data['isCompleted'];
          todos.add(
            TodoModel(
              userId: userId,
              taskName: taskName,
              taskId: id,
              isCompleted: isCompleted,
            ),
          );
        }
      }
      if (!context.mounted) return;
      Provider.of<TodoProvider>(context, listen: false).setTodoFromModel(todos);
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }





  //delete notes
  Future<void> deleteTodo({
    required String userID,
    required String todoId,
    required BuildContext context,
  }) async {
    try {
      final todoReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('todos')
          .doc(todoId);
      final todoSnapshot = await todoReference.get();
      if (todoSnapshot.exists) {
        await todoReference.delete();
        if (!context.mounted) return;
        await getTodoForUser(userID: userID, context: context);
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }


  //update Task
  Future<void> updateTodo({
    required String userID,
    required String todoId,
    required String updatedTask,
    required BuildContext context,
  }) async {
    try {
      final noteReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('todos')
          .doc(todoId);
      final noteSnapshot = await noteReference.get();
      if (noteSnapshot.exists) {
        await noteReference.update({
          'taskName': updatedTask,
        });
        if (!context.mounted) return;
        await getTodoForUser(userID: userID, context: context);
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }









}


