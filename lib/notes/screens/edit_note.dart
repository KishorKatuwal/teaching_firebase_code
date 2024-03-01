import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../services/note_service.dart';

class EditNoteScreen extends StatefulWidget {
  static const String routeName = "/edit-note-screen";
  final String noteDescription;
  final String noteId;

  const EditNoteScreen({
    super.key,
    required this.noteDescription,
    required this.noteId,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController noteController = TextEditingController();
  final NoteService _noteService = NoteService();

  @override
  void initState() {
    super.initState();
    noteController.text = widget.noteDescription;
  }

  void updateNote() {
    _noteService.updateNote(
        userID: FirebaseAuth.instance.currentUser!.uid,
        context: context,
        updatedNote: noteController.text,
        noteId: widget.noteId);
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
        title: const Text("Update Note Screen"),
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
                  updateNote();
                } else {
                  showSnackBar(context, "Please enter the description");
                }
              },
              height: 50,
              color: Colors.blue,
              minWidth: double.infinity,
              child: const Text(
                "Update Text",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
