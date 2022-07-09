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

  factory NotesForListing.fromJson(Map<String, dynamic> item) {
    return NotesForListing(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastEditTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
