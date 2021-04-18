// To parse this JSON data, do
//
//     final personInfoModel = personInfoModelFromJson(jsonString);

import 'dart:convert';

PersonInfoModel personInfoModelFromJson(String str) => PersonInfoModel.fromJson(json.decode(str));

String personInfoModelToJson(PersonInfoModel data) => json.encode(data.toJson());

class PersonInfoModel {
  PersonInfoModel({
    this.personInfo,
  });

  List<PersonInfo> personInfo;

  factory PersonInfoModel.fromJson(Map<String, dynamic> json) => PersonInfoModel(
    personInfo: List<PersonInfo>.from(json["personInfo"].map((x) => PersonInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "personInfo": List<dynamic>.from(personInfo.map((x) => x.toJson())),
  };
}

class PersonInfo {
  PersonInfo({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.address,
  });

  String firstName;
  String lastName;
  String email;
  String mobile;
  String address;

  factory PersonInfo.fromJson(Map<String, dynamic> json) => PersonInfo(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobile": mobile,
    "address": address,
  };
}
