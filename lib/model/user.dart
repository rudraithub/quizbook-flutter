// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int status;
  UserData data;
  String message;

  User({
    required this.status,
    required this.data,
    required this.message,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    status: json["status"],
    data: UserData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class UserData {
  String id;
  String firstName;
  String lastName;
  String email;
  String gender;
  DateTime dob;
  String mobileNumber;
  List<Profession> profession;
  int userId;
  int v;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.dob,
    required this.mobileNumber,
    required this.profession,
    required this.userId,
    required this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    gender: json["gender"],
    dob: DateTime.parse(json["DOB"]),
    mobileNumber: json["mobileNumber"],
    profession: List<Profession>.from(json["profession"].map((x) => Profession.fromJson(x))),
    userId: json["user_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "gender": gender,
    "DOB": dob.toIso8601String(),
    "mobileNumber": mobileNumber,
    "profession": List<dynamic>.from(profession.map((x) => x.toJson())),
    "user_id": userId,
    "__v": v,
  };
}

class Profession {
  int id;
  String name;

  Profession({
    required this.id,
    required this.name,
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
