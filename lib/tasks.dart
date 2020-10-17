import 'package:flutter/material.dart';
class MainPage extends StatefulWidget{
  HomePage createState()=> HomePage();
}

class HomePage extends State<MainPage>{
  Widget appBarTitle = new Text("Search Sample", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  final List<String> name = [ "Программирование", "Финансы", "Отдел кадров", "Кадр отделов", "Да" ];
  final List<String> info = [ "Разработать", "Посчитать", "Нанять", "Отнять", "Нет" ];
  final List<String> date = [ "01.01.2011", "01.01.2011", "01.01.2011", "01.01.2011", "01.01.2011" ];
  final List<String> moreinfo = [ "Первым делом вам нужно выбрать подходящий момент",
                                  "Лучше всего договориться встретиться в отдельном кабинете", 
                                  "Вы без отвлекающих факторов сможете объяснить задачу", 
                                  "Еще хуже, если вы рискнете поймать и загрузить подчиненного где-нибудь в коридоре", 
                                  "От каких методов лучше отказаться вообще" ];
  bool _isSearching;
  String _searchText = "";
  List <int> indexpage = [];
  HomePage() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      }
      else {
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
  /*void add_task(String name, String info, String date,String moreinfo){
    this.name.add(name);
    this.info.add(info);
    this.date.add(date);
    this.moreinfo.add(moreinfo);
  }*/
  @override
  Widget build(BuildContext context){
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
  int _buildSearchList() {
    if (_searchText.isEmpty) 
      return name.length;
    else 
      for (int i = 0; i < name.length; i++) 
        if (_searchText == name[i]) 
          return i+1;
    return 0;
        
    }
  
  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }
  Widget _buildFruitItem( BuildContext context, int index ){
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
                Navigator.push(context,
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
  
  Widget blu(BuildContext context, int index){
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
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pop(context);},
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
  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }
  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("Search Sample", style: new TextStyle(color: Colors.white),);
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}
