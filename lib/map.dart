import 'package:digital_hack/Models/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapVkld extends StatefulWidget {
  @override
  _MapVkldState createState() => _MapVkldState();
}

class _MapVkldState extends State<MapVkld> {
  Future<List<Test>> _getTest() async {
    var tstData = await http.get(
        "https://my-json-server.typicode.com/mentoster/digital_breakthrough/departments");
    var jsonData = json.decode(tstData.body);
    List<Test> tests = [];
    // print(
    //     "19. map -> jsonData: " + jsonData[0]["company"][0]["name"].toString());
    for (var tst in jsonData[0]["company"]) {
      Test test = Test(0, jsonData[0]["company"][0]["name"]);
      print("23. map -> jsonData: " +
          jsonData[0]["company"][0]["name"].toString());
      tests.add(test);
    }
    return tests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Задачи"),
      ),
      body: Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Container(
          child: FutureBuilder(
              future: _getTest(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Загрузка..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // leading: CircleAvatar(
                        //   backgroundImage: NetworkImage(imageUrl),
                        // ),
                        title: Text(snapshot.data[index].title),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 5.0),
                        onTap: () {
                          // do something
                        },
                      );
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
