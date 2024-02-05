// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

Temperatures temperaturesFromJson(String str) => Temperatures.fromJson(json.decode(str));

String temperaturesToJson(Temperatures data) => json.encode(data.toJson());

class Temperatures {
  int? status;
  List<Datum>? data;
  String? message;

  Temperatures({
    this.status,
    this.data,
    this.message,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  String? id;
  String? std;
  List<Subject>? subject;
  int? stdid;
  int? v;

  Datum({
    this.id,
    this.std,
    this.subject,
    this.stdid,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    std: json["std"],
    subject: json["subject"] == null ? [] : List<Subject>.from(json["subject"]!.map((x) => Subject.fromJson(x))),
    stdid: json["stdid"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "std": std,
    "subject": subject == null ? [] : List<dynamic>.from(subject!.map((x) => x.toJson())),
    "stdid": stdid,
    "__v": v,
  };
}

class Subject {
  String? subjectName;
  String? img;
  int? subid;
  String? id;

  Subject({
    this.subjectName,
    this.img,
    this.subid,
    this.id,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectName: json["subjectName"],
    img: json["img"],
    subid: json["subid"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "subjectName": subjectName,
    "img": img,
    "subid": subid,
    "_id": id,
  };
}
