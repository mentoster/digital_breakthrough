import 'package:digital_hack/Models/db.dart';
import 'package:digital_hack/profile.dart';
import 'package:digital_hack/main_screen.dart' as globals;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tree_view/tree_view.dart';

// map of
class MapVkld extends StatefulWidget {
  PageController _controller;
  @override
  _MapVkldState createState() => _MapVkldState();
}

class _MapVkldState extends State<MapVkld> {
  // get json with data
  Future<List<Deparament>> _getJson() async {
    var tstData = await http.get("https://files.rtuitlab.ru/dbdigital.json");
    // print(tstData);
    var jsn = json.decode(utf8.decode(tstData.bodyBytes));
    // print(jsonData);
    List<Deparament> deparaments = [];
    var jsonData = jsn["departments"];
    for (var dpr in jsonData[0]["company"]) {
      List<Profiles> profiles = [];
      for (var profile in jsonData[0]["company"][dpr["id"]]["profiles"]) {
        List<Tasks> tasks = [];
        if (profile["tasks"] != null)
          for (var tsk in profile["tasks"]) {
            Tasks tsknew = Tasks(tsk["id"], tsk["deadline"], tsk["title"],
                tsk["tags"], tsk["color"], tsk["body"]);
            tasks.add(tsknew);
          }
        Profiles prf = Profiles(profile["id"], profile["name"], profile["img"],
            profile["position"], profile["phone"], profile["email"], tasks);
        profiles.add(prf);
      }
      Deparament deparament =
          Deparament(dpr["id"], dpr["name"], dpr["url"], profiles);
      deparaments.add(deparament);
    }
    return deparaments;
  }
//    ████████╗██████╗ ███████╗███████╗
//    ╚══██╔══╝██╔══██╗██╔════╝██╔════╝
//       ██║   ██████╔╝█████╗  █████╗
//       ██║   ██╔══██╗██╔══╝  ██╔══╝
//       ██║   ██║  ██║███████╗███████╗
//       ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝

  PageController _controller;
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
              return tree(snapshot.data);
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Image.asset(
                        'assets/images/graf.png',
                        fit: BoxFit.cover,
                      )));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.map),
      ),
    );
  }

  TreeView tree(List<Deparament> snapshot) {
    return TreeView(
      parentList: [
        Parent(
            parent: _buildCard("ООО <<МОЯ ОБОРОНА>>", 0, false, 0, "0"),
            childList: ChildList(
              children: <Widget>[
                for (var i in snapshot) _treePrint(i.name, i.profiles),
              ],
            )),
      ],
    );
  }

  Parent _treePrint(String parent, List<dynamic> childs) {
    return Parent(
      parent: _buildCard(parent, 40, false, 0, "0"),
      childList: ChildList(
        children: List.generate(childs.length, (index) {
          // print(childs[index].name);
          return Parent(
              parent: _buildCard(
                  childs[index].name, 80, true, childs[index].id, parent),
              childList: ChildList(
                children: <Widget>[
                  for (var i in childs[index].tasks)
                    _buildCard(i.title, 120, false, 0, "0"),
                ],
              ));
        }),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildCard(String name, double leftMargin, bool profile, int id,
          String position) =>
      SizedBox(
        child: Card(
          margin: EdgeInsets.fromLTRB(leftMargin, 1, 0, 1),
          child: Column(
            children: [
              ListTile(
                title:
                    Text(name, style: TextStyle(fontWeight: FontWeight.w500)),
                trailing: IconButton(
                  onPressed: () {
                    if (profile) {
                      // print(id, position);
                      print(id);
                      print(position);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(id, position, false),
                        ),
                      );
                    }
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
