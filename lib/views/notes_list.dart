import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:premaco_restapi/models/note_for_listing.dart';
import 'package:premaco_restapi/views/note_delete.dart';
import 'package:premaco_restapi/views/note_modify.dart';

// ignore: use_key_in_widget_constructors
class NoteList extends StatelessWidget {
  final notes = [
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
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of notes'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteModify()));
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.separated(
          separatorBuilder: (_, Dart_CObject) =>
              const Divider(height: 1, color: Colors.green),
          itemCount: notes.length,
          itemBuilder: (_, index) {
            return Dismissible(
              key: ValueKey(notes[index]),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (_) => NoteDelete());
                print(result);
                return result;
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16),
                child: Align(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => NoteModify(
                            noteID: notes[index].noteID,
                          )));
                },
                title: Text(
                  notes[index].noteTitle,
                  style: TextStyle(color: Colors.amber),
                ),
                subtitle: Text(
                    'Last Edited: ${formatDateTime(notes[index].lastEditTime)}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
