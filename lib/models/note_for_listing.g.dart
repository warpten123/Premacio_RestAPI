// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_for_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesForListing _$NotesForListingFromJson(Map<String, dynamic> json) =>
    NotesForListing(
      noteID: json['noteID'] as String?,
      noteTitle: json['noteTitle'] as String,
      createDateTime: DateTime.parse(json['createDateTime'] as String),
      lastEditTime: json['lastEditTime'] == null
          ? null
          : DateTime.parse(json['lastEditTime'] as String),
    );

Map<String, dynamic> _$NotesForListingToJson(NotesForListing instance) =>
    <String, dynamic>{
      'noteID': instance.noteID,
      'noteTitle': instance.noteTitle,
      'createDateTime': instance.createDateTime.toIso8601String(),
      'lastEditTime': instance.lastEditTime?.toIso8601String(),
    };
