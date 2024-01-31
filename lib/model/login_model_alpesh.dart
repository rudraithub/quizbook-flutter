// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  int? status;
  Data? data;
  String? token;
  String? message;

  LogInModel({
    this.status,
    this.data,
    this.token,
    this.message,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "token": token,
    "message": message,
  };
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? dob;
  String? mobileNumber;
  List<Profession>? profession;
  int? userId;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.dob,
    this.mobileNumber,
    this.profession,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    gender: json["gender"],
    dob: json["DOB"],
    mobileNumber: json["mobileNumber"],
    profession: json["profession"] == null ? [] : List<Profession>.from(json["profession"]!.map((x) => Profession.fromJson(x))),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "gender": gender,
    "DOB": dob,
    "mobileNumber": mobileNumber,
    "profession": profession == null ? [] : List<dynamic>.from(profession!.map((x) => x.toJson())),
    "user_id": userId,
  };
}

class Profession {
  int? id;
  String? name;

  Profession({
    this.id,
    this.name,
  });

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
