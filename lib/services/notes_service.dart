import 'dart:convert';

import 'package:premaco_restapi/models/api_response.dart';
import 'package:premaco_restapi/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'abaf3c8e-72c0-498b-9862-47afad7add14',
  };
  Future<APIResponse<List<NotesForListing>>> getNoteList() {
    return http.get(Uri.parse(API + '/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final notes = <NotesForListing>[];
        for (var item in jsonData) {
          final note = NotesForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            lastEditTime: item['latestEditDateTime'] != null
                ? DateTime.parse(item['latestEditDateTime'])
                : null,
          );
          notes.add(note);
        }
        return APIResponse<List<NotesForListing>>(
          data: notes,
        );
      }
      return APIResponse<List<NotesForListing>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<NotesForListing>>(
        error: true, errorMessage: "An error occured"));
  }
}
