import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teaching_firebase/notes/provider/note_provider.dart';

import '../../common/utils.dart';
import '../../models/note_model.dart';

class NoteService {
  void addNotes({
    required String note,
    required String noteId,
    required String userID,
    required BuildContext context,
  }) async {
    try {
      final noteDetails = NoteModel(
        noteId: noteId,
        userId: userID,
        note: note,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('notes')
          .doc(noteId)
          .set(noteDetails.toJson());
      if (!context.mounted) return;
      await getNotesForUser(userID: userID, context: context);
      if (!context.mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  //get Notes
  Future<void> getNotesForUser({
    required String userID,
    required BuildContext context,
  }) async {
    List<NoteModel> notes = [];
    try {
      final notesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('notes');
      final notesQuery = await notesCollection.get();
      if (notesQuery.docs.isNotEmpty) {
        for (final doc in notesQuery.docs) {
          final data = doc.data();
          final id = doc.id;
          final userId = data['userId'];
          final note = data['note'];
          notes.add(NoteModel(noteId: id, userId: userId, note: note));
        }
      }
      if (!context.mounted) return;
      Provider.of<NoteProvider>(context, listen: false).setNoteFromModel(notes);
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }



  //updateNotes
  Future<void> updateNote({
    required String userID,
    required String noteId,
    required String updatedNote,
    required BuildContext context,
  }) async {
    try {
      final noteReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('notes')
          .doc(noteId);
      final noteSnapshot = await noteReference.get();
      if (noteSnapshot.exists) {
        await noteReference.update({
          'note': updatedNote,
        });
        if (!context.mounted) return;
        Navigator.pop(context);
        if (!context.mounted) return;
        await getNotesForUser(userID: userID, context: context);
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  //delete notes
  Future<void> deleteNote({
    required String userID,
    required String noteId,
    required BuildContext context,
  }) async {
    try {
      final noteReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('notes')
          .doc(noteId);
      final noteSnapshot = await noteReference.get();
      if (noteSnapshot.exists) {
        await noteReference.delete();
        if (!context.mounted) return;
        await getNotesForUser(userID: userID, context: context);
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }
}


//   Future<List<NoteModel>> getNotesForUser({
//   required String userID,
//   required BuildContext context,
// }) async {
//   List<NoteModel> notes = [];
//   try {
//     final notesCollection = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userID)
//         .collection('notes');
//     final notesQuery = await notesCollection.get();
//     if (notesQuery.docs.isNotEmpty) {
//       for (final doc in notesQuery.docs) {
//         final data = doc.data();
//         final id = doc.id;
//         final userId = data['userId'];
//         final note = data['note'];
//         notes.add(NoteModel(noteId: id, userId: userId, note: note));
//       }
//     }
//     Provider.of<NoteProvider>(context, listen: false).setNoteFromModel(notes);
//   } catch (e) {
//     if (!context.mounted) return [];
//     showSnackBar(context, e.toString());
//   }
//   return notes;
// }
