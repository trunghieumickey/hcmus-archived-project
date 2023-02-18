import 'dart:convert';

BookRoom? bookRoomFromJson(String str) => BookRoom.fromJson(json.decode(str));

String bookRoomToJson(BookRoom? data) => json.encode(data!.toJson());

class BookRoom {
  BookRoom({
    required this.usename,
    required this.startDate,
    required this.endDate,
    required this.price,
  });

  String? usename;
  String? startDate;
  String? endDate;
  String? price;

  factory BookRoom.fromJson(Map<String, dynamic> json) => BookRoom(
        usename: json["usename"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "usename": usename,
        "startDate": startDate,
        "endDate": endDate,
        "price": price,
      };
}
