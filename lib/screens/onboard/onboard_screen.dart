import 'dart:io';

import 'package:event_planner/classes/OnBoard.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/auth/login_screen.dart';
import 'package:event_planner/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreen extends StatefulWidget {
  static const String id = 'onboard_screen';
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  List<OnBoard> slides = new List<OnBoard>();
  int currentIndex = 0;
  PageController pageController = new PageController();
  @override
  void initState() {
    super.initState();
    slides = getOnBoardItems();
  }

  Widget pageIndicator(bool currentIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 6,
      width: currentIndex ? 18 : 6,
      decoration: BoxDecoration(
        color: currentIndex ? Colors.grey : Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (page) {
                    setState(() {
                      currentIndex = page;
                    });
                  },
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return SliderTile(
                      image: slides[index].image,
                      title: slides[index].title,
                      message: slides[index].details,
                    );
                  }),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    EdgeInsets.only(left: 100, right: 100, top: 15, bottom: 15),
                margin: EdgeInsets.only(bottom: 70),
                child: button(
                  title: currentIndex == slides.length - 1
                      ? "Get Started"
                      : "Next",
                  onPress: currentIndex == slides.length - 1
                      ? () {
                          Navigator.pushReplacementNamed(
                              context, WelcomeScreen.id);
                        }
                      : () {
                          pageController.animateToPage(currentIndex + 1,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.fastOutSlowIn);
                        },
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: Platform.isIOS ? 70 : 60,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                pageController.animateToPage(currentIndex - 1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn);
              },
              child: Text("back"),
            ),
            Row(
              children: [
                for (int i = 0; i < slides.length; i++)
                  currentIndex == i ? pageIndicator(true) : pageIndicator(false)
              ],
            ),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(slides.length - 1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn);
              },
              child: Text("skip"),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderTile extends StatelessWidget {
  final String image, title, message;

  const SliderTile({Key key, this.image, this.title, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(image),
          SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: kTitleTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: kLabelTextStyle.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
