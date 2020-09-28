import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  static const String id = "contact_us";
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool emailValidation = false;
  bool noteValidation = false;
  @override
  Widget build(BuildContext context) {
    double keyboardH = MediaQuery.of(context).viewInsets.bottom;
    print('keyboardH');
    print(keyboardH);
    FocusNode focusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Contact us",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              AnimatedContainer(
                alignment: Alignment.center,
                height: keyboardH > 0 ? 0 : 200,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  color: kMainColor,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "GET IN TOUCH",
                        style: kHeaderTextStyle,
                      ),
                      Text(
                        "Always within your reach",
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          onTap: () {},
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              labelText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          onTap: () {},
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              labelText: "Email address",
                              errorText:
                                  emailValidation ? "Add Valid Email" : null,
                              errorBorder: OutlineInputBorder().copyWith(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          onTap: () {},
                          maxLines: 5,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.note),
                              border: OutlineInputBorder(),
                              labelText: "Note",
                              errorText: noteValidation
                                  ? "Please enter a message"
                                  : null,
                              errorBorder: OutlineInputBorder().copyWith(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: button(
                          title: "SEND",
                          onPress: () {
                            print("SEND EMAIL");
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
