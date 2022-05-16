import 'package:flutter/material.dart';
import 'package:tinder/res/routes.dart';
import 'package:tinder/tinder.dart';
import 'package:tinder/ui/screens/main_screen.dart';

import 'data/services/navigation_service.dart';

class TinderApp extends StatefulWidget {
  @override
  State<TinderApp> createState() => _TinderAppState();
}

class _TinderAppState extends State<TinderApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routes.root,
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          settings: RouteSettings(name: Routes.root),
          builder: (_) => MainScreen(),
        );

      default:
        throw Exception("Route ${settings.name} is not defined");
    }
  }
}
