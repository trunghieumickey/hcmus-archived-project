import 'package:flutter/material.dart';
import 'package:hotel_app/model/hotel_list.dart';
import 'package:hotel_app/model/ones_user_list.dart';
import 'package:hotel_app/model/schedule_list.dart';
import 'package:hotel_app/model/bookRoom.dart';
import 'package:hotel_app/service/remote_service.dart';
import './loginScreen.dart';
import 'dart:async';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);
  static const String routeName = '/ClientScreen';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: routeName,
      home: ClientHomePage(),
    );
  }
}

class ClientHomePage extends StatelessWidget {
  ClientHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Home"),
                Tab(text: "History"),
                Tab(text: "Profile"),
              ],
            ),
            title: const Text('Hotel App User Screen'),
          ),
          body: const TabBarView(
            children: [homeScreen(), historyScreen(), profileScreen()],
          ),
        ));
  }
}

// HOME Screen
class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreen();
}

class _homeScreen extends State<homeScreen> {
  List<HotelList>? hotels;
  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    hotels = await RemotesService().getHotelList();
    if (hotels != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  void search(String inputSearch) {
    List<HotelList>? querry = [];
    if (inputSearch.isEmpty) {
      querry = hotels;
    } else {
      for (var i = 0; i < hotels!.length; i++) {
        if (hotels![i]
                .hotelName
                .toLowerCase()
                .contains(inputSearch.toLowerCase()) |
            hotels![i]
                .hotelAddress
                .toLowerCase()
                .contains(inputSearch.toLowerCase())) {
          querry.add(hotels![i]);
        }
      }
    }

    setState(() {
      hotels = querry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => search(value),
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < hotels!.length; i++)
            Container(
              height: 200,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Image"),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(hotels![i].hotelName),
                            Text(hotels![i].hotelAddress),
                            ElevatedButton(
                                onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => roomListScreen(
                                        allRooms: hotels![i].rooms),
                                  ));
                                }),
                                child: Text("Detail")),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class roomListScreen extends StatefulWidget {
  final List<Room>? allRooms;

  const roomListScreen({Key? key, this.allRooms}) : super(key: key);
  @override
  State<roomListScreen> createState() => _roomListScreen();
}

class _roomListScreen extends State<roomListScreen> {
  List<Room>? rooms = [];
  @override
  void initState() {
    rooms = widget.allRooms;
    super.initState();
  }

  void search(String inputSearch) {
    List<Room>? querry = [];
    if (inputSearch.isEmpty) {
      querry = widget.allRooms;
    } else {
      for (var i = 0; i < widget.allRooms!.length; i++) {
        if (widget.allRooms![i].roomId
                .toLowerCase()
                .contains(inputSearch.toLowerCase()) |
            widget.allRooms![i].price
                .toLowerCase()
                .contains(inputSearch.toLowerCase())) {
          querry.add(widget.allRooms![i]);
        }
      }
    }

    setState(() {
      rooms = querry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => search(value),
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rooms!.length; i++)
            Container(
              height: 200,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Image"),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(rooms![i].roomId),
                            Text(rooms![i].price),
                            ElevatedButton(
                                onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => bookRoomScreen(
                                      bookRoom: rooms![i],
                                    ),
                                  ));
                                }),
                                child: Text("Book")),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class bookRoomScreen extends StatefulWidget {
  final Room bookRoom;

  const bookRoomScreen({Key? key, required this.bookRoom}) : super(key: key);
  @override
  State<bookRoomScreen> createState() => _bookRoomScreen();
}

class _bookRoomScreen extends State<bookRoomScreen> {
  DateTime stdate = DateTime(2023, 1, 1);
  DateTime eddate = DateTime(2023, 1, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.bookRoom.roomId),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Container(
                height: 150.0,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: new Center(
                      child: new Text(
                        "Room image",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
              Container(
                child:
                    Text("Price: " + widget.bookRoom.price + r" $ Per Night"),
              ),
              Container(
                child: Text("Bed number: " + widget.bookRoom.bedNums),
              ),
              Container(
                child: Text("Room's feature: "),
              ),
              for (int i = 0; i < widget.bookRoom.furnitures.length; i++)
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(widget.bookRoom.furnitures[i])),
              const Divider(
                height: 100,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                        child: Text(
                          'Start\n' +
                              '${stdate.day}/${stdate.month}/${stdate.year}',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? newstDate = await showDatePicker(
                              context: context,
                              initialDate: stdate,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2100),
                            );
                            if (newstDate == null) return;
                            setState(() {
                              stdate = newstDate;
                            });
                          },
                          child: Text('Select date')),
                    ]),
                    Column(children: <Widget>[
                      Container(
                        child: Text(
                          'End\n' +
                              '${eddate.day}/${eddate.month}/${eddate.year}',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? newedDate = await showDatePicker(
                              context: context,
                              initialDate: eddate,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2100),
                            );
                            if (newedDate == null) return;
                            setState(() {
                              eddate = newedDate;
                            });
                          },
                          child: Text('Select date')),
                    ]),
                  ],
                ),
              ),
              const Divider(
                height: 50,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    var book = BookRoom(
                      usename: 'admin',
                      startDate: stdate.toString(),
                      endDate: eddate.toString(),
                      price: widget.bookRoom.price,
                    );
                    var response = await RemotesService()
                        .bookRoom(widget.bookRoom.roomId, book);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => homeScreen(),
                    ));
                  },
                  child: const Text('Book'),
                ),
              ),
            ])),
      ),
    );
  }
}

//PROFILE Screen
class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreen();
}

class _profileScreen extends State<profileScreen> {
  late OneUserProfile person;
  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    person = await RemotesService().getOneUserProfile("admin");
    setState(() {
      isloaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 50,
              ),
            ),
            const Divider(
              height: 60,
              color: Colors.grey,
            ),
            const Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              person.userInfo.elementAt(0).name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Actor',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              'Admin',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Email',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              person.userInfo.elementAt(0).email,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Phone',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              person.userInfo.elementAt(0).phone,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const updateProfileScreen())),
                  child: const Text("Edit Profile")),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text("Logout")),
            ),
          ],
        ),
      ),
    ));
  }
}

//HISTORY Screen
class historyScreen extends StatefulWidget {
  const historyScreen({Key? key}) : super(key: key);

  @override
  State<historyScreen> createState() => _historyScreen();
}

class _historyScreen extends State<historyScreen> {
  List<ScheduleProfile>? schedules;
  var isloaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    schedules = await RemotesService().getScheduleProfile("admin");
    if (schedules != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isloaded) {
      return Scaffold(
          body: ListView.builder(
        itemCount: schedules!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text(schedules![index].date),
                Text(schedules![index].timeStart),
                Text(schedules![index].timeEnd),
              ],
            ),
          );
        },
      ));
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

class updateProfileScreen extends StatefulWidget {
  const updateProfileScreen({Key? key}) : super(key: key);
  @override
  State<updateProfileScreen> createState() => _updateProfileScreen();
}

class _updateProfileScreen extends State<updateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Update Profile"),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              CircleAvatar(
                radius: 60,
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("NAME"),
                        prefixIcon: Icon(Icons.account_circle_outlined)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("EMAIL"),
                        prefixIcon: Icon(Icons.mail_outline_rounded)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("PHONE"),
                        prefixIcon: Icon(Icons.phone_outlined)),
                  ),
                ],
              ))
            ])),
      ),
    );
  }
}
