import 'package:flutter/material.dart';

import '../utils/colours.dart';
import 'home_screen/page/home_screen.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({Key? key}) : super(key: key);

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  List<String> moodList = [
    "Angry",
    "Fear",
    "Pain",
    "Confusion",
    "Boredom",
    "Sadness",
    "Surprise",
    "Horror",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gradient1,
              gradient2,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Select Your Mood",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 600,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: moodList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: SimpleOutlinedButton(
                        textColor: Colors.black,
                        outlineColor: Colors.black.withOpacity(0.7),
                        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                mood: moodList[i],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          moodList[i],
                          style: TextStyle(fontSize: 16),
                        ),
                        borderRadius: 50,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleOutlinedButton extends StatelessWidget {
  const SimpleOutlinedButton(
      {this.child,
      this.textColor,
      this.outlineColor,
      required this.onPressed,
      this.borderRadius = 6,
      this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      Key? key})
      : super(key: key);
  final Widget? child;
  final Function onPressed;
  final double borderRadius;
  final Color? outlineColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        textStyle: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed as void Function()?,
      child: child!,
    );
  }
}
