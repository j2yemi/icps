class UsersInfo {
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
  String picId;
  String shortProfile;
  bool speakerYn;
  String surname;
  String title;
  String twitterId;
  int userinfoid;
  String username;
  String website;
  dynamic workPosition;

  UsersInfo({
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
    this.picId,
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

  factory UsersInfo.fromJson(Map<String, dynamic> json) => new UsersInfo(
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
    picId: json["pic_id"] == null ? null : json["pic_id"],
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
    "pic_id": picId == null ? null : picId,
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