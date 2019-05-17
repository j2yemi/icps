// To parse this JSON data, do
//
//     final conferenceAgenda = conferenceAgendaFromJson(jsonString);

import 'dart:convert';
import 'package:icps/UsersInfo.dart';

List<ConferenceAgenda> conferenceAgendaFromJson(String str) => new List<ConferenceAgenda>.from(json.decode(str).map((x) => ConferenceAgenda.fromJson(x)));

String conferenceAgendaToJson(List<ConferenceAgenda> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ConferenceAgenda {
  int anchor;
  String conferenceDate;
  String description;
  String dresscode;
  int id;
  String moderator;
  String paneldiscussants;
  String subtitle;
  String timeEnd;
  String timeStart;
  String title;
  UsersInfo usersInfo;

  ConferenceAgenda({
    this.anchor,
    this.conferenceDate,
    this.description,
    this.dresscode,
    this.id,
    this.moderator,
    this.paneldiscussants,
    this.subtitle,
    this.timeEnd,
    this.timeStart,
    this.title,
    this.usersInfo,
  });

  factory ConferenceAgenda.fromJson(Map<String, dynamic> json) => new ConferenceAgenda(
    anchor: json["anchor"],
    conferenceDate: json["conferenceDate"],
    description: json["description"],
    dresscode: json["dresscode"],
    id: json["id"],
    moderator: json["moderator"],
    paneldiscussants: json["paneldiscussants"],
    subtitle: json["subtitle"],
    timeEnd: json["timeEnd"],
    timeStart: json["timeStart"],
    title: json["title"],
    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "anchor": anchor,
    "conferenceDate": conferenceDate,
    "description": description,
    "dresscode": dresscode,
    "id": id,
    "moderator": moderator,
    "paneldiscussants": paneldiscussants,
    "subtitle": subtitle,
    "timeEnd": timeEnd,
    "timeStart": timeStart,
    "title": title,
    "usersInfo": usersInfo.toJson(),
  };
}