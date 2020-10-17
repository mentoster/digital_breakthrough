class Test {
  final int id;
  final String title;
  Test(this.id, this.title);
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

class Profiles {
  int id;
  String name;
  String img;
  String position;
  String phone;
  String email;
  List<Tasks> tasks;
  Profiles(this.id, this.name, this.img, this.position, this.phone, this.email,
      this.tasks);
}

class Deparament {
  int id;
  String name;
  String url;
  List<Profiles> profiles;
  Deparament(this.id, this.name, this.url, this.profiles);
}
