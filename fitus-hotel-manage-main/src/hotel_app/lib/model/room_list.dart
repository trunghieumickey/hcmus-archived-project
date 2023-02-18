// To parse this JSON data, do
//
//     final hotelList = hotelListFromJson(jsonString);

import 'dart:convert';

List<RoomList> roomListFromJson(String str) =>
    List<RoomList>.from(json.decode(str).map((x) => RoomList.fromJson(x)));

String roomListToJson(List<RoomList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomList {
  RoomList({
    required this.roomId,
    required this.price,
    required this.bedNums,
    required this.furnitures,
  });

  String roomId;
  String price;
  String bedNums;
  List<String> furnitures;

  factory RoomList.fromJson(Map<String, dynamic> json) => RoomList(
        roomId: json["RoomID"],
        price: json["Price"],
        bedNums: json["BedNums"],
        furnitures: List<String>.from(json["Furnitures"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "RoomID": roomId,
        "Price": price,
        "BedNums": bedNums,
        "Furnitures": List<dynamic>.from(furnitures.map((x) => x)),
      };
}
