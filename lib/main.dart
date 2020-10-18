import 'package:digital_hack/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ███████╗████████╗ █████╗ ██████╗ ████████╗
// ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝
// ███████╗   ██║   ███████║██████╔╝   ██║
// ╚════██║   ██║   ██╔══██║██╔══██╗   ██║
// ███████║   ██║   ██║  ██║██║  ██║   ██║
// ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝
void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

// registration
class MyApp extends StatelessWidget {
  String _email;
  String _password;
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = new GlobalKey<FormState>();
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new TextFormField(
                      initialValue: "@admin",
                      decoration: new InputDecoration(labelText: "Почта"),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      style: _sizeTextBlack,
                      onSaved: (val) => _email = val,
                      validator: (val) => !val.contains("@")
                          ? 'Не действительная почта.'
                          : null,
                    ),
                    width: 400.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      initialValue: "123456",
                      decoration: new InputDecoration(labelText: "Пароль"),
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) =>
                          val.length < 6 ? 'Короткий пароль.' : null,
                      onSaved: (val) => _password = val,
                      style: _sizeTextBlack,
                    ),
                    width: 400.0,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: submit,
                      color: Colors.green,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Войти",
                        style: _sizeTextWhite,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    hideKeyboard();
    Navigator.push(_context,
        new MaterialPageRoute(builder: (context) => new BottomNavBar()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
