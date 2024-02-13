// // To parse this JSON data, do
// //
// //     final logInModel = logInModelFromJson(jsonString);

// import 'dart:convert';

// LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

// String logInModelToJson(LogInModel data) => json.encode(data.toJson());

// class LogInModel {
//   int? status;
//   Data? data;
//   String? token;
//   String? message;

//   LogInModel({
//     this.status,
//     this.data,
//     this.token,
//     this.message,
//   });

//   factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
//     status: json["status"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     token: json["token"],
//     message: json["message"],
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": data?.toJson(),
//     "token": token,
//     "message": message,
//   };
// }

// class Data {
//   String? id;
//   String? firstName;
//   String? lastName;
//   String? email;
//   List<Gender>? gender;
//   String? dob;
//   String? mobileNumber;
//   List<Profession>? profession;
//   int? userId;

//   Data({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.gender,
//     this.dob,
//     this.mobileNumber,
//     this.profession,
//     this.userId,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["_id"],
//     firstName: json["firstName"],
//     lastName: json["lastName"],
//     email: json["email"],
//     // gender: json["gender"] == null ? [] : List<Gender>.f,
//     gender: json["gender"] == null ? [] : List<Gender>.from(json["gender"]!.map((x) => Gender.fromJson(x))),

//     dob: json["DOB"],
//     mobileNumber: json["mobileNumber"],
//     profession: json["profession"] == null ? [] : List<Profession>.from(json["profession"]!.map((x) => Profession.fromJson(x))),
//     userId: json["user_id"],
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "firstName": firstName,
//     "lastName": lastName,
//     "email": email,
//     // "gender": gender,
//     "gender": gender == null ? [] : List<dynamic>.from(gender!.map((x) => x.toJson())),
//     "DOB": dob,
//     "mobileNumber": mobileNumber,
//     "profession": profession == null ? [] : List<dynamic>.from(profession!.map((x) => x.toJson())),
//     "user_id": userId,
//   };
// }

// class Profession {
//   int? id;
//   String? name;

//   Profession({
//     this.id,
//     this.name,
//   });

//   factory Profession.fromJson(Map<String, dynamic> json) => Profession(
//     id: json["_id"],
//     name: json["name"],
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//   };
// }
// class Gender {
//   int? id;
//   String? name;

//   Gender({
//     this.id,
//     this.name,
//   });

//   factory Gender.fromJson(Map<String, dynamic> json) => Gender(
//     id: json["_id"],
//     name: json["name"],
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//   };
// }
// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
    int status;
    Data data;
    String message;

    LogInModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    int id;
    String firstName;
    String lastName;
    String email;
    List<Gender> gender;
    String dob;
    String mobileNumber;
    List<Gender> profession;
    String userProfile;
    String tokens;

    Data({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.gender,
        required this.dob,
        required this.mobileNumber,
        required this.profession,
        required this.userProfile,
        required this.tokens,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        gender: List<Gender>.from(json["gender"].map((x) => Gender.fromJson(x))),
        dob: json["DOB"],
        mobileNumber: json["mobileNumber"],
        profession: List<Gender>.from(json["profession"].map((x) => Gender.fromJson(x))),
        userProfile: json["userProfile"],
        tokens: json["tokens"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "gender": List<dynamic>.from(gender.map((x) => x.toJson())),
        "DOB": dob,
        "mobileNumber": mobileNumber,
        "profession": List<dynamic>.from(profession.map((x) => x.toJson())),
        "userProfile": userProfile,
        "tokens": tokens,
    };
}

class Gender {
    int id;
    String name;

    Gender({
        required this.id,
        required this.name,
    });

    factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
