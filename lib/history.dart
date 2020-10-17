import 'package:flutter/material.dart';
class SearchList extends StatefulWidget{
  _SearchListState createState() => new _SearchListState();
  
}

class _SearchListState extends State<SearchList> {
  
  Widget appBarTitle = new Text("Search", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  final List<String> name = [ "Cовещание 1", "Совещание 2", "Совещание 3", "Совещание 4", "Совещание 5", "Совещание 6" ];
  final List<String> date = [ "24.05.2021", "03.04.2021", "18.03.2021", "13.02.2021", "02.01.2021", "30.12.20"];
  final List<String> moreinfo = [ "Раз два три четыре пять шесть семь восемь девять десять",
                                  "Одинадцать двенадцать тринадцать четырнадцать пятнадцать шестнадцать", 
                                  "Семнадцать восемнадцать девятнадцать двадцать двадцать один", 
                                  "Двадцать один двадцать два двадцать три двадцать четыре двадцать пять", 
                                  "Двадцать шесть двадцать семь двадцать восемь двадцать девять",
                                  "Тридцать тридцать один тридцать два тридцать три тридцать четыре тридцать пять" ];
  final List<String> hash=["#Math", "#Rus", "#Prog", "#Tag", "#Flutter", "#Web"];
  bool _isSearching;
  String _searchText = "";
  List <int> indexpage = [];
  _SearchListState() {
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
  @override



  Widget build(BuildContext context){
    return new Scaffold(
      key: key,
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add)),
      appBar: buildBar(context),
        body: Container(
          
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: new ListView.builder(
            itemBuilder: _buildNotesItem,
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

  Widget blu(BuildContext context, int index){
  return Scaffold(
    body: Center(
      child: Container(
        width: 400.0,
        height: 400.0,
        color: Colors.blue[100],
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
      child:  Icon(Icons.arrow_back),
    ),
  );
} 

  Widget _buildNotesItem(BuildContext context, int index) {
    return Center(
      child: Card(
        color: Colors.blue[200],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(name[index]),
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
                Text(date[index]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(hash[index]),
              ],
            ),
          ],
        ),
      ),
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
      new Text("Search", style: new TextStyle(color: Colors.white),);
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}

