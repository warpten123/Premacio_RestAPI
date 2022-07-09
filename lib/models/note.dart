class Note {
  String? noteID;
  String noteTitle;
  String? noteContent;
  DateTime createDateTime;
  DateTime? lastEditTime;

  Note({
    this.noteID,
    required this.noteTitle,
    this.noteContent,
    required this.createDateTime,
    this.lastEditTime,
  });
  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastEditTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
