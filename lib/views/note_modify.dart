import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:premaco_restapi/services/notes_service.dart';

import '../models/note.dart';

class NoteModify extends StatefulWidget {
  final String? noteID;
  NoteModify({this.noteID});

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;
  bool _isLoading = false;
  NotesService get notesService => GetIt.instance<NotesService>();
  String? errorMessage;
  Note? note;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  @override
  void initState() {
    print("From last ${widget.noteID}");
    super.initState();
    setState(() {
      _isLoading = true;
    });
    notesService.getNote(widget.noteID!).then((response) {
      print("Note: ${response.data}");
      setState(() {
        _isLoading = false;
      });
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occured';
      }
      note = response.data;

      _titleController.text = note!.noteTitle;
      _contentController.text = note!.noteContent ?? 'No Content';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Note' : 'Create Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      // ignore: unnecessary_const
                      decoration: InputDecoration(hintText: 'Note Title'),
                    ),
                    Container(
                      height: 8,
                    ),
                    TextField(
                      controller: _contentController,
                      // ignore: unnecessary_const
                      decoration: InputDecoration(hintText: 'Note Content'),
                    ),
                    Container(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
