import 'package:flutter/material.dart';
import 'package:tinder/tinder.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
