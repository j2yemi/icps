// To parse this JSON data, do
//
//     final speakerPresentation = speakerPresentationFromJson(jsonString);

import 'dart:convert';
import 'package:icps/UsersInfo.dart';

List<SpeakerPresentation> speakerPresentationFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<SpeakerPresentation>.from(jsonData.map((x) => SpeakerPresentation.fromJson(x)));
}

String speakerPresentationToJson(List<SpeakerPresentation> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class SpeakerPresentation {
  int id;
  String pDate;
  String pDesc;
  String pFileId;
  String pFileName;
  String pSubtitle;
  String pTitle;
  int userinfoid;
  UsersInfo usersInfo;

  SpeakerPresentation({
    this.id,
    this.pDate,
    this.pDesc,
    this.pFileId,
    this.pFileName,
    this.pSubtitle,
    this.pTitle,
    this.userinfoid,
    this.usersInfo,
  });

  factory SpeakerPresentation.fromJson(Map<String, dynamic> json) => new SpeakerPresentation(
    id: json["id"],
    pDate: json["p_date"],
    pDesc: json["p_desc"],
    pFileId: json["p_file_id"],
    pFileName: json["p_file_name"],
    pSubtitle: json["p_subtitle"],
    pTitle: json["p_title"],
    userinfoid: json["userinfoid"],
    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "p_date": pDate,
    "p_desc": pDesc,
    "p_file_id": pFileId,
    "p_file_name": pFileName,
    "p_subtitle": pSubtitle,
    "p_title": pTitle,
    "userinfoid": userinfoid,
    "usersInfo": usersInfo.toJson(),
  };
}
