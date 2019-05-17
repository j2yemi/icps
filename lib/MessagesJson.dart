// To parse this JSON data, do
//
//     final myMessages = myMessagesFromJson(jsonString);

import 'dart:convert';

import 'package:icps/UsersInfo.dart';

List<MyMessages> myMessagesFromJson(String str) => new List<MyMessages>.from(json.decode(str).map((x) => MyMessages.fromJson(x)));

String myMessagesToJson(List<MyMessages> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class MyMessages {
  int id;
  int mFrom;
  String mMessage;
  int mTo;
  String messagedate;
  bool messageread;
  UsersInfo sentToInfo;
  int userinfoid;
  UsersInfo usersInfo;
  String messageType;

  MyMessages({
    this.id,
    this.mFrom,
    this.mMessage,
    this.mTo,
    this.messagedate,
    this.messageread,
    this.sentToInfo,
    this.userinfoid,
    this.usersInfo,
    this.messageType,
  });

  factory MyMessages.fromJson(Map<String, dynamic> json) => new MyMessages(
    id: json["id"],
    mFrom: json["m_from"],
    mMessage: json["m_message"],
    mTo: json["m_to"],
    messagedate: json["messagedate"],
    messageread: json["messageread"],
    sentToInfo: UsersInfo.fromJson(json["sentToInfo"]),
    userinfoid: json["userinfoid"],
    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "m_from": mFrom,
    "m_message": mMessage,
    "m_to": mTo,
    "messagedate": messagedate,
    "messageread": messageread,
    "sentToInfo": sentToInfo.toJson(),
    "userinfoid": userinfoid,
    "usersInfo": usersInfo.toJson(),
    "messageType": messageType,
  };
}