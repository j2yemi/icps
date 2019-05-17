// To parse this JSON data, do
//
//     final galaNight = galaNightFromJson(jsonString);

import 'dart:convert';
import 'package:icps/UsersInfo.dart';

List<GalaNight> galaNightFromJson(String str) => new List<GalaNight>.from(json.decode(str).map((x) => GalaNight.fromJson(x)));

String galaNightToJson(List<GalaNight> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class GalaNight {
  String attendingYn;
  String datetimejoined;
  String gnCode;
  int id;
  int userinfoid;
  UsersInfo usersInfo;

  GalaNight({
    this.attendingYn,
    this.datetimejoined,
    this.gnCode,
    this.id,
    this.userinfoid,
    this.usersInfo,
  });

  factory GalaNight.fromJson(Map<String, dynamic> json) => new GalaNight(
    attendingYn: json["attending_yn"],
    datetimejoined: json["datetimejoined"],
    gnCode: json["gn_code"],
    id: json["id"],
    userinfoid: json["userinfoid"],
    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "attending_yn": attendingYn,
    "datetimejoined": datetimejoined,
    "gn_code": gnCode,
    "id": id,
    "userinfoid": userinfoid,
    "usersInfo": usersInfo.toJson(),
  };
}