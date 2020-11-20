import 'package:flutter/material.dart';
import 'package:DeepLounge/auth/UserService.dart';
import 'package:DeepLounge/screens/Home.dart';

class User extends StatefulWidget {
  User();

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  bool logedIn = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool login(String email, String password) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print(logedIn);
    return logedIn == false
        ? Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Builder(
              builder: (context) => Container(
                // margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.30),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 80),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Icon(
                          Icons.account_box,
                          size: 80,
                          color: Colors.green[400],
                        )),
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(primaryColor: Colors.green[400]),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.email,
                                  ),
                                  labelStyle:
                                      TextStyle(color: Colors.green[400]),
                                  hintText: "Email"),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(primaryColor: Colors.green[400]),
                            child: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.remove_red_eye_sharp,
                                  ),
                                  labelStyle:
                                      TextStyle(color: Colors.green[400]),
                                  hintText: "Password"),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FloatingActionButton.extended(
                        backgroundColor: Colors.green[400],
                        splashColor: Colors.green[200],
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () async {
                          AuthService(
                                  email: _emailController.text,
                                  password: _passwordController.text)
                              .login();

                          login(_emailController.text,
                                      _passwordController.text) ==
                                  true
                              ? setState(() {
                                  logedIn = true;
                                })
                              : Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green[200],
                                  content: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("User Dosent Existe"),
                                        ),
                                      ],
                                    ),
                                  )));
                        },
                        label: Text("Login"))
                  ],
                ),
              ),
            ))
        : Home();
  }
}
