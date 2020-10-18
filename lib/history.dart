import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  _SearchListState createState() => new _SearchListState();
}

//Основной класс поисковой строки со списком
class _SearchListState extends State<SearchList> {
  Widget appBarTitle = new Text(
    "Search",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  //Списки с информацией заметок
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  final List<String> name = [
    "Создание документации",
    "Обучние",
    "Про курсы",
    "О координации",
    "Про данные"
  ];
  final List<String> info = [
    "Разработка технической и сопроводительной документации к разрабатываемому программному обеспечению",
    "Обучение для работы с новыми программными средствами и комплексам",
    "О прохождение курсов повышения квалификации",
    "Координация процессов разработки с другими сотрудниками",
    "Анализ входящих данных;"
  ];
  final List<String> date = [
    "Fri Mar 26 2021",
    "Thu Nov 05 2020",
    "Sun Feb 21 2021",
    "Fri Jan 22 2021",
    "Thu Jul 29 2021"
  ];
  final List<String> moreinfo = [
    "Техническая документация на программный продукт (программу) разрабатывается в соответствии с требованиями ГОСТ ЕСПД и её можно разделить на следующие категории: Программная документация – документация, содержащая сведения, необходимые для разработки, изготовления, эксплуатации и сопровождения программы (программного изделия). Эксплуатационная документация – документация, необходимая для обеспечения функционирования и эксплуатации программного изделия.",
    "Обучение — важнейший этап любого проектаю Современный рынок предъявляет к разработчикам и проектировщикам очень жесткие требования. Только тот, кто сможет в самые сжатые сроки предложить интересную и нужную продукцию, получит признание потребителя, а значит и возможность развивать свой бизнес. Поэтому сейчас уже крайне трудно представить ситуацию из недавнего прошлого, когда системы автоматизации проектирования приобретались для галочки или престижа, а коробки с программами вскоре после покупки отправлялись пылиться на дальние полки КБ или становились любимой игрушкой немногих энтузиастов.",
    "Повышение квалификации – это один из видов профессионального обучения работников предприятия, которое проводится с целью повышения уровня теоретических знаний, совершенствования практических навыков и умений сотрудников организации в связи с постоянно повышающимися требованиями к их квалификации. Повышение квалификации работников может проводиться по мере необходимости.",
    "Однако координация действий по реализации этих операций - намного более вариативная и неопределенная деятельность. Собственно, координация и является повседневной базовой функцией управленца. Одно дело определить, кто за какой участок отвечает, другое дело - добиться слаженных действий и достижения некоего общего результата.",
    "Анализ данных — это всего лишь последовательность шагов, каждый из которых играет ключевую роль для последующих. Этот процесс похож на цепь последовательных, связанных между собой этапов: Определение проблемы ... Определение проблемы. Процесс анализа данных начинается задолго до сбора сырых данных. "
  ];
  final List<String> hash = [
    "#Math",
    "#Rus",
    "#Prog",
    "#Tag",
    "#Flutter",
    "#Web"
  ];
  bool _isSearching;
  String _searchText = "";
  List<int> indexpage = [];
  _SearchListState() {
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
    //функция определения нажатия поиска
    super.initState();
    _isSearching = false;
  }

//Основной виджет. Содержит основной интерфейс блока "Совещаний"
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
      ),
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

  //Функция поиска
  int _buildSearchList() {
    if (_searchText.isEmpty)
      return name.length;
    else
      for (int i = 0; i < name.length; i++)
        if (_searchText == name[i]) return i + 1;
    return 0;
  }

  //Построение поисковой строки, ее дизайн
  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        backgroundColor: Colors.green,
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

  //Виджет создания заметок внутри совещаний
  Widget blu(BuildContext context, int index) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 400.0,
            height: 400.0,
            color: Colors.green,
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
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.green,
      ),
    );
  }

  //Виджет построения карточек с заметками
  Widget _buildNotesItem(BuildContext context, int index) {
    return Center(
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.green[100],
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
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
                  child: Text(hash[index])),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Text(date[index], textAlign: TextAlign.right)),
            ],
          ),
        ],
      ),
    ));
  }

  //функция состояния поиска
  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}
