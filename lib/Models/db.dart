class Test {
  final int id;
  final String title;
  Test(this.id, this.title);
}

class Profiles {
  int id;
  String name;
  String img;
  String position;
  String phone;
  String email;
  Profiles(this.id, this.name, this.img, this.position, this.phone, this.email);
}

class Tasks {
  int id;
  String deadline;
  String title;
  String tags;
  String color;
  String body;
  Tasks(this.id, this.deadline, this.title, this.tags, this.color, this.body);
}

class Deparament {
  int id;
  String name;
  String url;
  List<Profiles> profiles;
  List<Tasks> tasks;
  Deparament(this.id, this.name, this.url, this.profiles, this.tasks);
}
