import 'package:flutter/material.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(const App());
}
