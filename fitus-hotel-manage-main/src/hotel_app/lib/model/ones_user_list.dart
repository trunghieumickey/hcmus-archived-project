// To parse this JSON data, do
//
//     final oneUserProfile = oneUserProfileFromJson(jsonString);

import 'dart:convert';

OneUserProfile oneUserProfileFromJson(String str) => OneUserProfile.fromJson(json.decode(str));

String oneUserProfileToJson(OneUserProfile data) => json.encode(data.toJson());

class OneUserProfile {
    OneUserProfile({
        required this.userInfo,
        required this.permissions,
    });

    List<UserInfo> userInfo;
    List<String> permissions;

    factory OneUserProfile.fromJson(Map<String, dynamic> json) => OneUserProfile(
        userInfo: List<UserInfo>.from(json["user_info"].map((x) => UserInfo.fromJson(x))),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user_info": List<dynamic>.from(userInfo.map((x) => x.toJson())),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
    };
}

class UserInfo {
    UserInfo({
        required this.name,
        required this.phone,
        required this.email,
        required this.gender,
        required this.dob,
        required this.address,
    });

    String name;
    String phone;
    String email;
    String gender;
    String dob;
    String address;

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json["Name"],
        phone: json["Phone"],
        email: json["Email"],
        gender: json["Gender"],
        dob: json["DOB"],
        address: json["Address"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Phone": phone,
        "Email": email,
        "Gender": gender,
        "DOB": dob,
        "Address": address,
    };
}
