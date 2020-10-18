import 'package:flutter/material.dart';
import 'package:digital_hack/Models/db.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tree_view/tree_view.dart';

class Profile extends StatelessWidget {
  //User information
  int id = 0;
  //User image
  final AssetImage ico = AssetImage(
    'assets/images/pic.png',
  );
  String name = 'Иван Иванов';
  String position = 'бухгалтерия';
  String number = '8(916)-205-35-80';
  String email = 'NeoMatrix@mos.ru';
  bool isMyProfile;
  Profile(this.id, this.position, this.isMyProfile);

  //Get data fron json file
  Future<List<Deparament>> _getJson() async {
    var tstData = await http.get("https://files.rtuitlab.ru/dbdigital.json");
    var jsn = json.decode(utf8.decode(tstData.bodyBytes));
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

  @override //Profile Widget
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getJson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              color: Colors.white,
            );
          } else {
            for (var i in snapshot.data) {
              if (i.name == position) {
                return _buildcard(
                    i.profiles[id].name,
                    i.profiles[id].position,
                    i.profiles[id].phone,
                    i.profiles[id].email,
                    i.profiles[id].img);
              }
            }
          }
        });
  }

  Center cenText(String text, TextStyle textStyle) {
    return Center(
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

// card of profile
// ██████╗ ██████╗  ██████╗ ███████╗██╗██╗     ███████╗
// ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║██║     ██╔════╝
// ██████╔╝██████╔╝██║   ██║█████╗  ██║██║     █████╗
// ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║██║     ██╔══╝
// ██║     ██║  ██║╚██████╔╝██║     ██║███████╗███████╗
// ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝

  Card _buildcard(String name, String position, String phoneNumber,
      String email, String urlico) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(urlico),
              radius: 70,
            ),
          ),
          ListTile(
            title: cenText(
                name, TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
            subtitle: cenText(
                position, TextStyle(color: Colors.grey[500], fontSize: 20)),
          ),
          ListTile(
            title: Text(phoneNumber,
                style: TextStyle(fontWeight: FontWeight.w500)),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.green[500],
            ),
          ),
          ListTile(
            title: Text(email),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.green[500],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Написать...'),
            onTap: () {
              // changeoage(2);
            },
            leading: Icon(
              Icons.message,
              color: Colors.green[500],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Текущие задания'),
            onTap: () {
              // changeoage(2);
            },
            leading: Icon(
              Icons.description,
              color: Colors.green[500],
            ),
          ),
          ListTile(
            title: Text('Выполненные задания'),
            onTap: () {
              // changeoage(2);
            },
            leading: Icon(
              Icons.done,
              color: Colors.green[500],
            ),
          ),
          importApi(isMyProfile)
        ],
      ),
    );
  }
}

//Import from Trello function
ListTile importApi(bool isMyProfile) {
  if (isMyProfile) {
    return ListTile(
      title: Text('Импортировать из Trello'),
      onTap: () {
        // changeoage(2);
      },
      leading: Icon(
        Icons.link,
        color: Colors.green[500],
      ),
    );
  } else
    return ListTile();
}
