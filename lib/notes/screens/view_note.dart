import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teaching_firebase/notes/provider/note_provider.dart';

import '../services/note_service.dart';
import 'add_note.dart';
import 'edit_note.dart';

class ViewNotesScreen extends StatefulWidget {
  static const String routeName = "/view-note-screen";

  const ViewNotesScreen({super.key});

  @override
  State<ViewNotesScreen> createState() => _ViewNotesScreenState();
}

class _ViewNotesScreenState extends State<ViewNotesScreen> {
  final NoteService _noteService = NoteService();

  @override
  void initState() {
    super.initState();
    _noteService.getNotesForUser(
      userID: FirebaseAuth.instance.currentUser!.uid,
      context: context,
    );
  }

  void deleteNote({
    required String noteId,
  }) {
    _noteService.deleteNote(
      context: context,
      noteId: noteId,
      userID: FirebaseAuth.instance.currentUser!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteModel = context.watch<NoteProvider>().noteModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: noteModel.isEmpty
            ? const Center(
                child: Text("No Notes are added"),
              )
            : ListView.builder(
                itemCount: noteModel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = noteModel[index];
                  return Card(
                    elevation: 10,
                    child: Container(
                      height: 250,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              height: 140,
                              width: double.infinity,
                              color: Colors.white,
                              child: Text(
                                data.note,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, EditNoteScreen.routeName,
                                        arguments: {
                                          "noteId": data.noteId,
                                          "noteDescription": data.note,
                                        });
                                  },
                                  height: 50,
                                  color: Colors.blue,
                                  minWidth: 100,
                                  elevation: 4,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Edit Text",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    deleteNote(
                                      noteId: data.noteId,
                                    );
                                  },
                                  height: 50,
                                  color: Colors.blue,
                                  minWidth: 100,
                                  elevation: 4,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.redAccent,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Delete Text",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddNoteScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
