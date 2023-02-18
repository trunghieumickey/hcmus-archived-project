// To parse this JSON data, do
//
//     final hotelList = hotelListFromJson(jsonString);

import 'dart:convert';

List<HotelList> hotelListFromJson(String str) =>
    List<HotelList>.from(json.decode(str).map((x) => HotelList.fromJson(x)));

String hotelListToJson(List<HotelList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelList {
  HotelList({
    required this.hotelName,
    required this.hotelAddress,
    required this.rooms,
  });

  String hotelName;
  String hotelAddress;
  List<Room> rooms;

  factory HotelList.fromJson(Map<String, dynamic> json) => HotelList(
        hotelName: json["HotelName"],
        hotelAddress: json["HotelAddress"],
        rooms: List<Room>.from(json["Rooms"].map((x) => Room.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "HotelName": hotelName,
        "HotelAddress": hotelAddress,
        "Rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
      };
}

class Room {
  Room({
    required this.roomId,
    required this.price,
    required this.bedNums,
    required this.furnitures,
    required this.available,
  });

  String roomId;
  String price;
  String bedNums;
  List<String> furnitures;
  bool available;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomId: json["RoomID"],
        price: json["Price"],
        bedNums: json["BedNums"],
        furnitures: List<String>.from(json["Furnitures"].map((x) => x)),
        available: json["Available"],
      );

  Map<String, dynamic> toJson() => {
        "RoomID": roomId,
        "Price": price,
        "BedNums": bedNums,
        "Furnitures": List<dynamic>.from(furnitures.map((x) => x)),
        "Available": available,
      };
}
