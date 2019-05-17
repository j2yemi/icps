// To parse this JSON data, do
//
//     final exhibition = exhibitionFromJson(jsonString);

import 'dart:convert';
import 'package:icps/UsersInfo.dart';

List<Exhibition> exhibitionFromJson(String str) => new List<Exhibition>.from(json.decode(str).map((x) => Exhibition.fromJson(x)));

String exhibitionToJson(List<Exhibition> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Exhibition {
  String createdDate;
  String description;
  String email;
  int id;
  String picId;
  String title;
  int userinfoid;
  UsersInfo usersInfo;
  String website;

  Exhibition({
    this.createdDate,
    this.description,
    this.email,
    this.id,
    this.picId,
    this.title,
    this.userinfoid,
    this.usersInfo,
    this.website,
  });

  factory Exhibition.fromJson(Map<String, dynamic> json) => new Exhibition(
    createdDate: json["created_date"],
    description: json["description"],
    email: json["email"],
    id: json["id"],
    picId: json["pic_id"],
    title: json["title"],
    userinfoid: json["userinfoid"],
    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "created_date": createdDate,
    "description": description,
    "email": email,
    "id": id,
    "pic_id": picId,
    "title": title,
    "userinfoid": userinfoid,
    "usersInfo": usersInfo.toJson(),
    "website": website,
  };
}