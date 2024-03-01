import 'dart:convert';

List<NoteModel> noteModelFromJson(String str) => List<NoteModel>.from(json.decode(str).map((x) => NoteModel.fromJson(x)));

String noteModelToJson(List<NoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteModel {
  final String noteId;
  final String note;
  final String userId;

  NoteModel({
    required this.noteId,
    required this.note,
    required this.userId,
  });

  NoteModel copyWith({
    String? noteId,
    String? note,
    String? userId,
  }) =>
      NoteModel(
        noteId: noteId ?? this.noteId,
        note: note ?? this.note,
        userId: userId ?? this.userId,
      );

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    noteId: json["noteId"],
    note: json["note"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "noteId": noteId,
    "note": note,
    "userId": userId,
  };
}
