class NotesForListing {
  String? noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime? lastEditTime;

  NotesForListing({
    this.noteID,
    required this.noteTitle,
    required this.createDateTime,
    this.lastEditTime,
  });
}
