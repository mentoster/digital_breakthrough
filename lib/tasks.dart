import 'package:flutter/material.dart';
import 'package:digital_hack/Models/db.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  //Ссылка на базу данных и её парсинг
  Future<List<Deparament>> _getJson() async {
    var tstData = await http.get("https://files.rtuitlab.ru/dbdigital.json");
    var jsn = json.decode(utf8.decode(tstData.bodyBytes));
    List<Deparament> deparaments = [];

    print(jsn["departments"]);
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
    print(deparaments);
    return deparaments;
  }

  Widget appBarTitle = new Text(
    "Search Sample",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();

  List<String> name = [];
  List<String> info = [];
  List<String> date = [];
  List<String> moreinfo = [];
  bool _isSearching;
  String _searchText = "";
  List<int> indexpage = [];
  HomePage() {
    //Конструктор
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  bool alreadyHave = false;
  @override

  //Основной виджет. Содержит объединение базы данных. Содержит основной интерфейс блока "Задачи"
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getJson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Загрузка..."),
              ),
            );
          } else {
            if (!alreadyHave) {
              for (var dep in snapshot.data) {
                for (var profile in dep.profiles) {
                  for (var tsk in profile.tasks) {
                    name.add(tsk.title);
                    info.add(profile.name);
                    moreinfo.add(tsk.body);
                    date.add(tsk.deadline);
                  }
                }
              }
            }
            alreadyHave = true;
            return new Scaffold(
              key: key,
              appBar: buildBar(context),
              body: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: new ListView.builder(
                  itemBuilder: _buildFruitItem,
                  itemCount: _buildSearchList(),
                ),
              ),
            );
          }
        });
  }

  //Метод для строки поиска
  int _buildSearchList() {
    if (_searchText.isEmpty)
      return name.length;
    else
      for (int i = 0; i < name.length; i++)
        if (_searchText == name[i]) return i + 1;
    return 0;
  }

  //Виджет строки поиска
  Widget buildBar(BuildContext context) {
    return new AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  //Метод определения цвета задачи в зависимости от дедлайна
  Color deadline(String datea) {
    var d = DateTime.now().day;
    var p = int.parse(datea[0]);
    p *= 10;
    p += int.parse(datea[1]);
    if (p - d < 5) {
      return (Colors.red[100]);
    }
    if (p - d < 10)
      return (Colors.yellow[100]);
    else
      return (Colors.green[100]);
  }

  //Виджет кейсов задач
  Widget _buildFruitItem(BuildContext context, int index) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: deadline(date[index]),
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_tree_rounded),
              title: Text(name[index]),
              subtitle: Text(info[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => blu(context, index),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text('#хештег')),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text('Выполнить до: ' + date[index],
                        textAlign: TextAlign.right)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Виджет заметок для задач (расширенной информации)
  Widget blu(BuildContext context, int index) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Container(
              padding: new EdgeInsets.only(top: 50.0),
              height: 100.0,
              color: deadline(date[index]),
              child: Text(name[index])),
          Container(
            width: 400.0,
            height: 400.0,
            color: deadline(date[index]),
            padding: new EdgeInsets.only(top: 50.0),
            child: Text(
              moreinfo[index],
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              height: 100.0,
              color: deadline(date[index]),
              padding: new EdgeInsets.only(top: 50.0),
              child: Row(
                children: [
                  Container(child: const Icon(Icons.article_outlined)),
                  Container(child: Text('Document.docx')),
                ],
              )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.backspace),
      ),
    );
  }

  void _handleSearchStart() {
    //метод для поиска
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    //метод для поиска
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}
