import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  final List<String> name = [
    "Программирование",
    "Финансы",
    "Отдел кадров",
    "Кадр отделов",
    "Да"
  ];
  final List<String> info = [
    "Разработать",
    "Посчитать",
    "Нанять",
    "Отнять",
    "Нет"
  ];
  final List<String> date = [
    "01.01.2011",
    "01.01.2011",
    "01.01.2011",
    "01.01.2011",
    "01.01.2011"
  ];
  final List<String> moreinfo = [
    "Первым делом вам нужно выбрать подходящий момент",
    "Лучше всего договориться встретиться в отдельном кабинете",
    "Вы без отвлекающих факторов сможете объяснить задачу",
    "Еще хуже, если вы рискнете поймать и загрузить подчиненного где-нибудь в коридоре",
    "От каких методов лучше отказаться вообще"
  ];
  void add_task(String name, String info, String date, String moreinfo) {
    this.name.add(name);
    this.info.add(info);
    this.date.add(date);
    this.moreinfo.add(moreinfo);
  }

  Widget appBarTitle = new Text("Search");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                );
              } else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("Search");
              }
            });
          },
        ),
      ]),
      body: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemBuilder: _buildFruitItem,
          itemCount: name.length,
        ),
      ),
    );
  }

  Widget _buildFruitItem(BuildContext context, int index) {
    return Center(
      child: Card(
        color: Colors.green[100],
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Выполнить до: '),
                Text(date[index]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('#хештег'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget blu(BuildContext context, int index) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 400.0,
            height: 400.0,
            color: Colors.yellow[100],
            padding: new EdgeInsets.only(top: 50.0),
            child: Text(
              moreinfo[index],
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.backspace),
      ),
      /*body: Container(
        padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(moreinfo[index]),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {Navigator.pop(context);},
                child: Text('Назад'),
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
