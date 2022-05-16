import 'package:flutter/material.dart';
import 'app.dart';
import 'di/locator.dart';

void main() {
  configureDependencies();
  runApp(TinderApp());
}
