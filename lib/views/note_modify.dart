import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String? noteID;
  bool get isEditing => noteID != null;
  NoteModify({this.noteID});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Note' : 'Create Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const TextField(
                // ignore: unnecessary_const
                decoration: InputDecoration(hintText: 'Note Title'),
              ),
              Container(
                height: 8,
              ),
              const TextField(
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
