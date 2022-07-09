// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      noteID: json['noteID'] as String?,
      noteTitle: json['noteTitle'] as String,
      noteContent: json['noteContent'] as String?,
      createDateTime: DateTime.parse(json['createDateTime'] as String),
      lastEditTime: json['lastEditTime'] == null
          ? null
          : DateTime.parse(json['lastEditTime'] as String),
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'noteID': instance.noteID,
      'noteTitle': instance.noteTitle,
      'noteContent': instance.noteContent,
      'createDateTime': instance.createDateTime.toIso8601String(),
      'lastEditTime': instance.lastEditTime?.toIso8601String(),
    };
