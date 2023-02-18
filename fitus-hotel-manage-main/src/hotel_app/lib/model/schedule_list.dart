// To parse this JSON data, do
//
//     final scheduleProfile = scheduleProfileFromJson(jsonString);

import 'dart:convert';

List<ScheduleProfile> scheduleProfileFromJson(String str) => List<ScheduleProfile>.from(json.decode(str).map((x) => ScheduleProfile.fromJson(x)));

String scheduleProfileToJson(List<ScheduleProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleProfile {
    ScheduleProfile({
        required this.date,
        required this.timeStart,
        required this.timeEnd,
    });

    String date;
    String timeStart;
    String timeEnd;

    factory ScheduleProfile.fromJson(Map<String, dynamic> json) => ScheduleProfile(
        date: json["Date"],
        timeStart: json["TimeStart"],
        timeEnd: json["TimeEnd"],
    );

    Map<String, dynamic> toJson() => {
        "Date": date,
        "TimeStart": timeStart,
        "TimeEnd": timeEnd,
    };
}
