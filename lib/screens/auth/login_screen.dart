import 'package:event_planner/components/TextButton.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/auth/forgotpassword_screen.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/auth/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  bool obsecure = true;
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String email;
  String password;
  bool showLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<User> _testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User user = (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = await _auth.currentUser;

    return user;
  }

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
                            "Login",
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
                                email = value;
                              },
                              controller: _controller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email address",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                            child: TextField(
                              obscureText: obsecure,
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obsecure = !obsecure;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color:
                                            obsecure ? Colors.grey : Colors.red,
                                      ),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                      child: button(
                        title: "Login",
                        onPress: () async {
                          setState(() {
                            showLoading = true;
                          });

                          try {
                            if (email != null && password != null) {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);

                              if (user != null) {
                                Navigator.pushNamed(context, HomeScreen.id);
                                _controller.clear();
                              }
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextButton(
                        text: "Forgot password?",
                        onPress: () {
                          Navigator.pushNamed(context, ForgotPasswordScreen.id);
                        },
                      ),
                    ),
                    TextButton(
                      text: "New User? Create account here",
                      onPress: () {
                        Navigator.pushNamed(context, RegistraionScreen.id);
                      },
                      textSize: 17.0,
                      textWeight: FontWeight.bold,
                    ),
                    // with custom text
                    SignInButton(
                      Buttons.GoogleDark,
                      text: "Sign in with Google",
                      onPressed: () async {
                        User user = await _testSignInWithGoogle();
                        if (user != null) {
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
