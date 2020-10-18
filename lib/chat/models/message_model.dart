import 'package:digital_hack/chat/models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}

final User currentUser =
    User(id: 0, name: 'Current User', imageUrl: 'assets/images/greg.jpg');

// USERS
final User greg =
    User(id: 1, name: 'Александр', imageUrl: 'assets/images/greg.jpg');
final User james =
    User(id: 2, name: 'Максим', imageUrl: 'assets/images/james.jpg');
final User john = User(id: 3, name: 'Влад', imageUrl: 'assets/images/john.jpg');
final User olivia =
    User(id: 4, name: 'Лиза', imageUrl: 'assets/images/olivia.jpg');
final User sam = User(id: 5, name: 'Света', imageUrl: 'assets/images/sam.jpg');
final User sophia =
    User(id: 6, name: 'Вика', imageUrl: 'assets/images/sophia.jpg');
final User steven =
    User(id: 7, name: 'Глеб', imageUrl: 'assets/images/steven.jpg');

// FAVORITE CONTACTS
List<User> favorites = [sam, steven, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    time: '9:00',
    text: 'Привет, на счет проекта ...',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '11:30',
    text: 'Завтра собрание в 9',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '14:00',
    text: 'Спасибо',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '15:00',
    text: 'Можешь подойти?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: '15:30',
    text: 'Скоро проверка',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: '16:00',
    text: 'Не смогу выполнить задание',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: greg,
    time: '17:00',
    text: 'До встречи',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: james,
    time: '8:00',
    text: 'Привет',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '8:30',
    text: 'Здравствуйте',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '8:31',
    text: 'Нужно поучавствовать в организации конкурса',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '8:40',
    text: 'Займет все выходные',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '8:45',
    text: 'Хорошо',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '9:00',
    text: 'Тогда жду',
    isLiked: false,
    unread: true,
  ),
];
