import 'package:digital_hack/Models/db.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tree_view/tree_view.dart';

class MapVkld extends StatefulWidget {
  @override
  _MapVkldState createState() => _MapVkldState();
}

class _MapVkldState extends State<MapVkld> {
  Future<List<Deparament>> _getJson() async {
    var tstData = await http.get(
        "https://my-json-server.typicode.com/mentoster/digital_breakthrough/departments");
    var jsonData = json.decode(tstData.body);
    //     "19. map -> jsonData: " + jsonData[0]["company"][0]["name"].toString());
    List<Deparament> deparaments = [];
    for (var dpr in jsonData[0]["company"]) {
      List<Profiles> profiles = [];
      for (var profile in jsonData["profiles"][0]) {
        print("test");
        profiles.add(profile);
      }
      List<Tasks> tasks = [];
      for (var tsk in dpr["tasks"][0]) {
        tasks.add(tsk);
      }
      Deparament deparament =
          Deparament(0, dpr["name"], dpr["url"], profiles, tasks);
      deparaments.add(deparament);
    }
    return deparaments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Задачи"),
      ),
      body: FutureBuilder(
          future: _getJson(),
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
                      title: Text(snapshot.data[index].name),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
                      onTap: () {
                        // do something
                      },
                      onLongPress: () {});
                },
              );
              // print("what");
              // print("41. map -> snapshot.data: " + snapshot.data.toString());
              // return tree(snapshot.data);
            }
          }),
    );
  }

  TreeView tree(AsyncSnapshot snapshot) {
    print(snapshot.data);
    // return TreeView(
    //             parentList: [
    //               Parent(
    //                 parent: _buildCard("ООО <<МОЯ ОБОРОНА>>", 0),
    //                 childList: ChildList(
    //                   children: <Widget>[
    //                     Parent(
    //                       parent: _buildCard('documents', 20),
    //                       childList: ChildList(
    //                         children: <Widget>[
    //                           _buildCard('Resume.docx', 40),
    //                           _buildCard('Billing-Info.docx', 40),
    //                         ],
    //                       ),
    //                     ),
    //                     _buildCard('MeetingReport.xls', 20),
    //                     _buildCard('MeetingReport.pdf', 20),
    //                     _buildCard('Demo.zip', 20),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           );
    return null;
  }

  // ignore: unused_element
  Widget _buildCard(String name, double leftMargin) => SizedBox(
        child: Card(
          margin: EdgeInsets.fromLTRB(leftMargin, 1, 0, 1),
          child: Column(
            children: [
              ListTile(
                title:
                    Text(name, style: TextStyle(fontWeight: FontWeight.w500)),
                trailing: IconButton(
                  onPressed: () {
                    // Interactivity or events codes here
                  },
                  splashRadius: 25,
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
