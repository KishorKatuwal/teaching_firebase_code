import 'package:flutter/cupertino.dart';

import '../../models/note_model.dart';

class NoteProvider extends ChangeNotifier{

  List<NoteModel> _noteModel = [];
  List<NoteModel> get noteModel => _noteModel;

  void setNote(String noteModel) {
    _noteModel = noteModelFromJson(noteModel);
    notifyListeners();
  }

  void setNoteFromModel(List<NoteModel> noteModel) {
    _noteModel = noteModel;
    notifyListeners();
  }

}