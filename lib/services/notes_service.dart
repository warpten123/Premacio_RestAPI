import 'package:premaco_restapi/models/note_for_listing.dart';

class NotesService {
  List<NotesForListing> getNoteList() {
    return [
      NotesForListing(
        noteID: "1",
        createDateTime: DateTime.now(),
        lastEditTime: DateTime.now(),
        noteTitle: "Note 1",
      ),
      NotesForListing(
        noteID: "2",
        createDateTime: DateTime.now(),
        lastEditTime: DateTime.now(),
        noteTitle: "Note 2",
      ),
      NotesForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditTime: DateTime.now(),
        noteTitle: "Note 3",
      ),
    ];
  }
}
