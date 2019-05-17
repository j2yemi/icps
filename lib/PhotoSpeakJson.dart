// To parse this JSON data, do
//
//     final photoSpeak = photoSpeakFromJson(jsonString);

import 'dart:convert';
import 'package:icps/UsersInfo.dart';

List<PhotoSpeakk> photoSpeakFromJson(String str) => new List<PhotoSpeakk>.from(json.decode(str).map((x) => PhotoSpeakk.fromJson(x)));

String photoSpeakToJson(List<PhotoSpeakk> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class PhotoSpeakk {
  String createdDate;
  String createdDateTime;
  int id;
  String mediaFileId;
  String text;
  int userinfoid;
  UsersInfo usersInfo;

  PhotoSpeakk({
    this.createdDate,
    this.createdDateTime,
    this.id,
    this.mediaFileId,
    this.text,
    this.userinfoid,
    this.usersInfo,
  });

  factory PhotoSpeakk.fromJson(Map<String, dynamic> json) => new PhotoSpeakk(
    createdDate: json["created_date"],
    createdDateTime: json["created_date_time"],
    id: json["id"],
    mediaFileId: json["media_file_id"],
    text: json["text"],
    userinfoid: json["userinfoid"],
    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "created_date": createdDate,
    "created_date_time": createdDateTime,
    "id": id,
    "media_file_id": mediaFileId,
    "text": text,
    "userinfoid": userinfoid,
    "usersInfo": usersInfo.toJson(),
  };
}
