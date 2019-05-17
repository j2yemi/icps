import 'dart:convert';
import 'package:icps/UsersInfo.dart';


List<QuestionVote> questionVoteFromJson(String str) => new List<QuestionVote>.from(json.decode(str).map((x) => QuestionVote.fromJson(x)));

String questionVoteToJson(List<QuestionVote> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionVote {
  dynamic askQuestion;
  int countvote;
  dynamic datetimeasked;
  String firstname;
  dynamic id;
  int qid;
  String qtext;
  String surname;
  dynamic votebyid;

  QuestionVote({
    this.askQuestion,
    this.countvote,
    this.datetimeasked,
    this.firstname,
    this.id,
    this.qid,
    this.qtext,
    this.surname,
    this.votebyid,
  });

  factory QuestionVote.fromJson(Map<String, dynamic> json) => new QuestionVote(
    askQuestion: json["askQuestion"],
    countvote: json["countvote"],
    datetimeasked: json["datetimeasked"],
    firstname: json["firstname"],
    id: json["id"],
    qid: json["qid"],
    qtext: json["qtext"],
    surname: json["surname"],
    votebyid: json["votebyid"],
  );

  Map<String, dynamic> toJson() => {
    "askQuestion": askQuestion,
    "countvote": countvote,
    "datetimeasked": datetimeasked,
    "firstname": firstname,
    "id": id,
    "qid": qid,
    "qtext": qtext,
    "surname": surname,
    "votebyid": votebyid,
  };
}

