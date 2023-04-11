

import '../../views/home_screen/page/home_screen.dart';
import 'package:flutter/cupertino.dart';
import '../views/mood_page.dart';
import 'appRoutes.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().homePage: (context) => HomePage(mood: "Angry"),
  AppRoutes().moodPage: (context) => const MoodPage(),

};
