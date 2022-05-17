import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder/res/routes.dart';
import 'package:tinder/tinder.dart';
import 'package:tinder/ui/screens/cards/cards_screen.dart';
import 'package:tinder/ui/screens/view_list/view_list_screen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ),
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.pink)),
        textTheme: GoogleFonts.montserratAlternatesTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: Routes.root,
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => CardsScreen(),
        );

      case Routes.viewList:
        final args = settings.arguments as ViewListArgs;
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => ViewListScreen(args: args),
        );

      default:
        throw Exception("Route ${settings.name} is not defined");
    }
  }
}
