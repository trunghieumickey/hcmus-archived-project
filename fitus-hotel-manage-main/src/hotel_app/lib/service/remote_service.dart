import 'package:hotel_app/model/hotel_list.dart';
import 'package:hotel_app/model/schedule_list.dart';
import 'package:hotel_app/model/user_list.dart';
import 'package:hotel_app/model/ones_user_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemotesService {
  Future<List<HotelList>?> getHotelList() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8000/hotels_info');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return hotelListFromJson(json);
    }
  }

  Future<List<UserProfile>?> getUserProfile() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8000/users_info');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userProfileFromJson(json);
    }
  }

  Future<OneUserProfile> getOneUserProfile(String username) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8000/user/$username');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return oneUserProfileFromJson(json);
    } else {
      return getOneUserProfile("admin");
    }
  }

  Future<List<ScheduleProfile>?> getScheduleProfile(String username) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8000/schedule/$username');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return scheduleProfileFromJson(json);
    }
  }

  Future<dynamic> bookRoom(String api, dynamic object) async {
    var client = http.Client();
    var url = Uri.parse('http://localhost:8000/book/' + api);
    var payload = json.encode(object);

    var response = await client.post(url, body: payload);
  }

  Future<dynamic> updateRoom(String api, dynamic object) async {
    var client = http.Client();
    var url = Uri.parse('http://localhost:8000/status/' + api);
    var payload = json.encode(object);

    var response = await client.post(url, body: payload);
  }
}
