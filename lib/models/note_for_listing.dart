import 'package:json_annotation/json_annotation.dart';

part 'note_for_listing.g.dart';

@JsonSerializable()
class NotesForListing {
  String? noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime? lastEditTime;

  NotesForListing({
    required this.noteID,
    required this.noteTitle,
    required this.createDateTime,
    required this.lastEditTime,
  });

  factory NotesForListing.fromJson(Map<String, dynamic> item) =>
      _$NotesForListingFromJson(item);
}
