import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  //user data
  int id = 0;
  // imagie profile
  final AssetImage ico = AssetImage(
    'assets/images/pic.png',
  );
  String name = 'Иван Иванов';
  String position = 'бухгалтер';
  String number = '8(916)-205-35-80';
  String email = 'NeoMatrix@mos.ru';
  Profile();
  Center cenText(String text, TextStyle textStyle) {
    return Center(
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: ico,
                radius: 70,
              ),
            ),
            ListTile(
              title: cenText(
                  name, TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
              subtitle: cenText(
                  position, TextStyle(color: Colors.grey[500], fontSize: 20)),
            ),
            ListTile(
              title: Text('8-(916)-205-35-80',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.green[500],
              ),
            ),
            ListTile(
              title: Text('WakeUpNeo@mos.ru'),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.green[500],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Написать...'),
              onTap: () {
                // changeoage(2);
              },
              leading: Icon(
                Icons.message,
                color: Colors.green[500],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Текущие задания'),
              onTap: () {
                // changeoage(2);
              },
              leading: Icon(
                Icons.description,
                color: Colors.green[500],
              ),
            ),
            ListTile(
              title: Text('Выполненные задания'),
              onTap: () {
                // changeoage(2);
              },
              leading: Icon(
                Icons.done,
                color: Colors.green[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
