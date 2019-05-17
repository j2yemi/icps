// To parse this JSON data, do
//
//     final conferenceSpeaker = conferenceSpeakerFromJson(jsonString);

import 'dart:convert';

List<ConferenceSpeaker> conferenceSpeakerFromJson(String str) => new List<ConferenceSpeaker>.from(json.decode(str).map((x) => ConferenceSpeaker.fromJson(x)));

String conferenceSpeakerToJson(List<ConferenceSpeaker> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ConferenceSpeaker {
  String companysector;
  dynamic conferenceId;
  String country;
  String email;
  String facebookId;
  String firstname;
  dynamic instagramId;
  String loginstatus;
  bool moderatorYn;
  String organisation;
  dynamic participantType;
  String password;
  String phone;
  String pic_id;
  String shortProfile;
  bool speakerYn;
  String surname;
  String title;
  String twitterId;
  int userinfoid;
  String username;
  String website;
  dynamic workPosition;

  ConferenceSpeaker({
    this.companysector,
    this.conferenceId,
    this.country,
    this.email,
    this.facebookId,
    this.firstname,
    this.instagramId,
    this.loginstatus,
    this.moderatorYn,
    this.organisation,
    this.participantType,
    this.password,
    this.phone,
    this.pic_id,
    this.shortProfile,
    this.speakerYn,
    this.surname,
    this.title,
    this.twitterId,
    this.userinfoid,
    this.username,
    this.website,
    this.workPosition,
  });

  factory ConferenceSpeaker.fromJson(Map<String, dynamic> json) => new ConferenceSpeaker(
    companysector: json["companysector"],
    conferenceId: json["conference_id"],
    country: json["country"],
    email: json["email"],
    facebookId: json["facebook_id"],
    firstname: json["firstname"],
    instagramId: json["instagram_id"],
    loginstatus: json["loginstatus"],
    moderatorYn: json["moderator_yn"],
    organisation: json["organisation"],
    participantType: json["participant_type"],
    password: json["password"],
    phone: json["phone"],
    pic_id: json["pic_id"],
    shortProfile: json["short_profile"],
    speakerYn: json["speaker_yn"],
    surname: json["surname"],
    title: json["title"],
    twitterId: json["twitter_id"],
    userinfoid: json["userinfoid"],
    username: json["username"],
    website: json["website"],
    workPosition: json["work_position"],
  );

  Map<String, dynamic> toJson() => {
    "companysector": companysector,
    "conference_id": conferenceId,
    "country": country,
    "email": email,
    "facebook_id": facebookId,
    "firstname": firstname,
    "instagram_id": instagramId,
    "loginstatus": loginstatus,
    "moderator_yn": moderatorYn,
    "organisation": organisation,
    "participant_type": participantType,
    "password": password,
    "phone": phone,
    "pic_id": pic_id,
    "short_profile": shortProfile,
    "speaker_yn": speakerYn,
    "surname": surname,
    "title": title,
    "twitter_id": twitterId,
    "userinfoid": userinfoid,
    "username": username,
    "website": website,
    "work_position": workPosition,
  };
}