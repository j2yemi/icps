// To parse this JSON data, do
//
//     final joinAttendeeList = joinAttendeeListFromJson(jsonString);

import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:icps/UsersInfo.dart';

Future<dynamic> JoinAttendees(int userinfoid) async{
  final String url = 'http://localhost:7101/icps/icps/19/jad';

  Response response;
  Dio dio = new Dio();
  response = await dio.post(url, queryParameters: {"userinfoid": userinfoid},
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: 'application/json',"accept": "application/json"},)
  );



  print('Got response here as $response.statusCode');
  return response;

}


List<JoinAttendeeList> joinAttendeeListFromJson(String str) => new List<JoinAttendeeList>.from(json.decode(str).map((x) => JoinAttendeeList.fromJson(x)));

String joinAttendeeListToJson(List<JoinAttendeeList> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class JoinAttendeeList {
  String datetimejoined;
  int id;
  int userinfoid;
  UsersInfo usersInfo;

  JoinAttendeeList({
    this.datetimejoined,
    this.id,
    this.userinfoid,
    this.usersInfo,
  });

//  factory JoinAttendeeList.fromUsersInfo(UsersInfo info)
//  {
//    return JoinAttendeeList (
//      usersInfo: UsersInfo(
//          companysector: info.companysector,
//          conferenceId: info.conferenceId,
//          country: info.country,
//          email: info.email,
//          facebookId: info.facebookId,
//          firstname: info.firstname,
//          instagramId: info.instagramId,
//          loginstatus: info.loginstatus,
//          moderatorYn: info.moderatorYn,
//          organisation: info.organisation,
//          participantType: info.participantType,
//          password: info.password,
//          shortProfile: info.shortProfile,
//          speakerYn: info.speakerYn,
//          surname: info.surname,
//          title: info.title,
//          twitterId: info.twitterId,
//          userinfoid: info.userinfoid,
//          username: info.username,
//          website: info.website,
//          workPosition: info.workPosition
//      )
//    );
//  }

  factory JoinAttendeeList.fromJson(Map<String, dynamic> json) => new JoinAttendeeList(
    datetimejoined: json["datetimejoined"],
    id: json["id"],
    userinfoid: json["userinfoid"],
    usersInfo: UsersInfo.fromJson(json["usersInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "datetimejoined": datetimejoined,
    "id": id,
    "userinfoid": userinfoid,
    "usersInfo": usersInfo.toJson(),
  };
}
