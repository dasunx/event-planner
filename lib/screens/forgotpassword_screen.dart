import 'package:flutter/material.dart';

import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double keyboardH = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              height: keyboardH > 0 ? 400 - keyboardH : 400,
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
                          "Reset Password",
                          style: TextStyle(
                            color: Colors.black,
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
                          color: Color.fromRGBO(143, 148, 251, 1),
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
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email address",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, 0.6)
                        ],
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        print("ji");
                      },
                      child: Center(
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back to login",
                      style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
