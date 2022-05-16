import 'package:flutter/material.dart';
import 'package:tinder/tinder.dart';
import 'package:tinder/ui/screens/main_screen.dart';

class TinderApp extends StatefulWidget {
  @override
  State<TinderApp> createState() => _TinderAppState();
}

class _TinderAppState extends State<TinderApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}
