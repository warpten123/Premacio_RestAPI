import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:premaco_restapi/models/api_response.dart';
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

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  late APIResponse<List<NotesForListing>> _apiResponse;
  bool _isLoading = false;
  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
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
          body: Builder(builder: (_) {
            if (_isLoading) {
              return CircularProgressIndicator();
            }
            if (_apiResponse.error) {
              return Center(
                child: Text(_apiResponse.errorMessage!),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, Dart_CObject) =>
                  const Divider(height: 1, color: Colors.green),
              itemCount: _apiResponse.data!.length,
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data![index].noteID),
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
                                noteID: _apiResponse.data![index].noteID,
                              )));
                      print(_apiResponse.data![index].noteID);
                    },
                    title: Text(
                      _apiResponse.data![index].noteTitle,
                      style: TextStyle(color: Colors.amber),
                    ),
                    subtitle: Text(
                        'Last Edited: ${formatDateTime(_apiResponse.data![index].lastEditTime ?? _apiResponse.data![index].createDateTime)}'),
                  ),
                );
              },
            );
          })),
    );
  }
}
