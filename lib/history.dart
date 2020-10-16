import 'package:flutter/material.dart';


class SearchBar extends StatelessWidget {
  final void Function(String) onTextChange;

  SearchBar({ this.onTextChange });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(8),
      child: TextField(
        onChanged: onTextChange,
        decoration: InputDecoration(
          fillColor: Colors.black.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(Icons.search),
          hintText: 'Search something ...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero
        )
      )
    );
  }
}
class FruitList extends StatelessWidget{
  
  final List<String> name = [ "Программирование", "Финансы", "Отдел кадров", "Кадр отделов", "Да","erfe", "" ];
  
  final List<String> date = [ "01.01.2011", "01.01.2011", "01.01.2011", "01.01.2011", "01.01.2011", "cxf", "" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:SearchBar(),
    ),
        body: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.green[300],
          ),
          child: ListView.builder(
            itemBuilder: _buildFruitItem,
            itemCount: name.length,
          )
        )
    );
  }



  Widget _buildFruitItem( BuildContext context, int index ){
    return Center(
      child: Card(
        color: Colors.yellow[100],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(name[index]),
            
              onTap: ()=> print("selected the counter!"),
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
                Text('#хештег'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}