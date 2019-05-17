// To parse this JSON data, do
//
//     final partners = partnersFromJson(jsonString);

import 'dart:convert';
import 'package:icps/UsersInfo.dart';

List<Partners> partnersFromJson(String str) => new List<Partners>.from(json.decode(str).map((x) => Partners.fromJson(x)));

String partnersToJson(List<Partners> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Partners {
  String briefProfile;
  String contact;
  String createdDate;
  String email;
  int id;
  String name;
  String partnercategory;
  bool partnerpaymentstatus;
  String picId;
  int userinfoid;
//  UsersInfo usersInfo;
  String website;
  String text;

  Partners({
    this.briefProfile,
    this.contact,
    this.createdDate,
    this.email,
    this.id,
    this.name,
    this.partnercategory,
    this.partnerpaymentstatus,
    this.picId,
    this.userinfoid,
//    this.usersInfo,
    this.website,
    this.text,
  });

  factory Partners.fromJson(Map<String, dynamic> json) => new Partners(
    briefProfile: json["brief_profile"],
    contact: json["contact"],
    createdDate: json["created_date"],
    email: json["email"],
    id: json["id"],
    name: json["name"],
    partnercategory: json["partnercategory"],
    partnerpaymentstatus: json["partnerpaymentstatus"],
    picId: json["pic_id"],
    userinfoid: json["userinfoid"],
//    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
    website: json["website"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "brief_profile": briefProfile,
    "contact": contact,
    "created_date": createdDate,
    "email": email,
    "id": id,
    "name": name,
    "partnercategory": partnercategory,
    "partnerpaymentstatus": partnerpaymentstatus,
    "pic_id": picId,
    "userinfoid": userinfoid,
//    "usersInfo": usersInfo.toJson(),
    "website": website,
    "text": text,
  };
}