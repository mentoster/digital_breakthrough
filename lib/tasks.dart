import 'package:flutter/material.dart';

class FruitList extends StatelessWidget {
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
  /*void add_task(string name, string info, string date,string more){
    this.name.add(name);
    this.info.add(info);
    this.date.add(date);
    this.moreinfo.add(moreinfo);
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView.builder(
              itemBuilder: _buildFruitItem,
              itemCount: name.length,
            )));
  }

  Widget _buildFruitItem(BuildContext context, int index) {
    return Center(
      child: Card(
        color: Colors.green[100],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.work),
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
          child: Text(
        moreinfo[index],
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
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
