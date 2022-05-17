import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tinder/di/locator.dart';

@singleton
class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get state => navigatorKey.currentState!;

  BuildContext get context => navigatorKey.currentContext!;
}

NavigatorState get routeService => locator<NavigationService>().state;

GlobalKey<NavigatorState> get navigatorKey =>
    locator<NavigationService>().navigatorKey;
