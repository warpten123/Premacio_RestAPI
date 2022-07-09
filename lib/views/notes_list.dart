import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:premaco_restapi/models/note_for_listing.dart';
import 'package:premaco_restapi/services/notes_service.dart';
import 'package:premaco_restapi/views/note_delete.dart';
import 'package:premaco_restapi/views/note_modify.dart';

// ignore: use_key_in_widget_constructors
class NoteList extends StatefulWidget {
  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.instance<NotesService>();
  List<NotesForListing> notes = [];
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    notes = service.getNoteList();
    super.initState();
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
