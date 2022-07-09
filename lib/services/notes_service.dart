import 'dart:convert';

import 'package:premaco_restapi/models/api_response.dart';
import 'package:premaco_restapi/models/note.dart';
import 'package:premaco_restapi/models/noteInsert.dart';
import 'package:premaco_restapi/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'abaf3c8e-72c0-498b-9862-47afad7add14',
    'Content-Type': 'application/json'
  };
  Future<APIResponse<List<NotesForListing>>> getNotesList() {
    return http.get(Uri.parse(API + '/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body); //
        final notes = <NotesForListing>[];
        for (var item in jsonData) {
          notes.add(NotesForListing.fromJson(item));
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

  ////single item
  Future<APIResponse<Note>> getNote(String noteID) {
    return http
        .get(Uri.parse(API + '/notes/' + noteID), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);

        return APIResponse<Note>(
          data: Note.fromJson(jsonData),
        );
      }
      return APIResponse<Note>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<Note>(error: true, errorMessage: "An error occured"));
  }

  //create note
  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(Uri.parse(API + '/notes'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  //update note
  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http
        .put(Uri.parse(API + '/notes/' + noteID),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  ///deleteNote
  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http
        .delete(
      Uri.parse(API + '/notes/' + noteID),
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }
}
