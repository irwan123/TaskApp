import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'upload.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// 2f2d93
class _LoginScreenState extends State<LoginScreen> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login or Regist',
            style: TextStyle(
                fontFamily: 'monserrat',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 15,
            ),
            child: Text(
              'TaskApp!',
              style: TextStyle(
                  fontFamily: 'monserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Email', border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Password', border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(10),
                child: OutlineButton(
                  borderSide: const BorderSide(
                      color: Colors.blueAccent, style: BorderStyle.solid),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Theme.of(context).accentColor,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () async {
                    if (_password.length < 6) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Icon(Icons.warning,
                                  color: Colors.redAccent),
                              content:
                                  const Text('Email atau Password anda salah'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: const Text('Tutup'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      auth
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const UploadScreen()));
                      });
                    }
                  },
                ),
              ),
              const Text('Tidak punya akun?'),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Theme.of(context).accentColor,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onPressed: () {
                      if (_password.length < 6 || _password == null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Icon(
                                  Icons.warning,
                                  color: Colors.redAccent,
                                ),
                                content: const Text(
                                    'Password harus lebih dari 6 karakter'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text('Tutup'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      } else {
                        auth
                            .createUserWithEmailAndPassword(
                                email: _email, password: _password)
                            .then((_) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                        });
                      }
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
