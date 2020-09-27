class OnBoard {
  final String title;
  final String details;
  final String image;

  OnBoard(this.title, this.details, this.image);
}

List<OnBoard> getOnBoardItems() {
  List<OnBoard> slides = new List<OnBoard>();

  OnBoard ob1 = new OnBoard("Organize",
      "Organize and manage your events in easier way", "images/onboard1.png");
  OnBoard ob2 = new OnBoard(
      "Invite",
      "Inviting guests is a headache right? Not anymore, It's simple one button press now!",
      "images/onboard2.png");
  OnBoard ob3 = new OnBoard(
      "Statistics",
      "Keep an eye on your event, handling budget, guests and so many things like never before",
      "images/onboard3.png");

  slides.add(ob1);
  slides.add(ob2);
  slides.add(ob3);

  return slides;
}
