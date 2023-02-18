// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
    UserProfile({
        required this.username,
        required this.userInfo,
        required this.permissions,
    });

    String username;
    List<UserInfo> userInfo;
    List<String> permissions;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        username: json["username"],
        userInfo: List<UserInfo>.from(json["user_info"].map((x) => UserInfo.fromJson(x))),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
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
