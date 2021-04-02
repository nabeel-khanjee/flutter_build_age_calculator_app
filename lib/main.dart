import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primaryColor: Colors.brown),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double age = 0.0;
  var selectedYear;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = animationController;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  void _showPicker() {
    showDatePicker(
            context: context,
            initialDate: new DateTime(2021),
            firstDate: new DateTime(1900),
            lastDate: new DateTime.now())
        .then((DateTime dt) {
      setState(() {
        selectedYear = dt.year;
        calculateAge();
      });
    });
  }

  void calculateAge() {
    setState(() {
      age = (2021 - selectedYear).toDouble();
      animation = new Tween<double>(begin: animation.value, end: age).animate(
        new CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn),
      );
      animation.addListener(() {
        setState(() {});
      });
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Age Calculator"),
      ),
      body: new Container(
          padding: const EdgeInsets.all(20),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new OutlineButton(
                    child: new Text(selectedYear != null
                        ? selectedYear.toString()
                        : "Select your year of birth"),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    color: Colors.white,
                    onPressed: () => _showPicker()),
                new Padding(padding: const EdgeInsets.only(top: 20)),
                new Text(
                  "Your age is ${animation.value.toStringAsFixed(0)}",
                  style: new TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          )),
    );
  }
}
