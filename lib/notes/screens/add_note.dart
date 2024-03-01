import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../common/utils.dart';
import '../services/note_service.dart';

class AddNoteScreen extends StatefulWidget {
  static const String routeName = "/add-note-screen";

  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController noteController = TextEditingController();
  final NoteService _noteService = NoteService();
  final noteId = const Uuid().v1();

  void addNote() {
    _noteService.addNotes(
      userID: FirebaseAuth.instance.currentUser!.uid,
      noteId: noteId,
      context: context,
      note: noteController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              maxLines: 8,
              controller: noteController,
              decoration: const InputDecoration(
                hintText: "Write here..",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                if (noteController.text.isNotEmpty) {
                  addNote();
                } else {
                  showSnackBar(context, "Please enter the Note Description");
                }
              },
              height: 50,
              color: Colors.blue,
              minWidth: double.infinity,
              child: const Text(
                "Submit Text",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
