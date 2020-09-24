import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/forgotpassword_screen.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistraionScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistraionScreenState createState() => _RegistraionScreenState();
}

class _RegistraionScreenState extends State<RegistraionScreen> {
  bool obsecure = true;
  final _auth = FirebaseAuth.instance;
  String userName;
  String email;
  String password;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double keyboardH = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showLoading,
        child: Container(
          child: Column(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                height: keyboardH > 0 ? 400 - keyboardH : 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/background.png'),
                    fit: keyboardH > 0 ? BoxFit.fitWidth : BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      width: 80,
                      child: AnimatedContainer(
                        height: keyboardH > 0 ? 350 - keyboardH : 200,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('images/light-1.png'),
                        )),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 700),
                        height: keyboardH > 0 ? 330 - keyboardH : 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('images/light-2.png'),
                        )),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 30,
                      child: Hero(
                        tag: 'l',
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 700),
                          height: keyboardH > 0 ? 350 - keyboardH : 200,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('images/clock.png'),
                          )),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: keyboardH > 0 ? 20 : 50),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kMainColor,
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                userName = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email address",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: obsecure,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obsecure = !obsecure;
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color:
                                          obsecure ? Colors.grey : Colors.red,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    button(
                      title: "Register",
                      onPress: () async {
                        setState(() {
                          showLoading = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            final user = _auth.currentUser;
                            user.updateProfile(displayName: userName);

                            Navigator.pushNamed(context, HomeScreen.id);
                          }

                          setState(() {
                            showLoading = false;
                          });
                        } catch (e) {
                          print(e);
                          setState(() {
                            showLoading = false;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Already a member? Sign in here",
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
