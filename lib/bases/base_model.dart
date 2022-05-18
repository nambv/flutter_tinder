import 'package:flutter/material.dart';
import 'package:tinder/util/commons.dart';
import 'package:tinder/util/enums.dart';

abstract class BaseModel extends ChangeNotifier {
  late ViewState viewState;
  String? errorMsg;

  ViewState get initState => ViewState.initial;

  BaseModel() {
    viewState = initState;
  }

  setState(ViewState newState,
      {forceUpdate = false, dynamic error, StackTrace? stackTrace}) {
    if (!forceUpdate && viewState == newState) return;
    viewState = newState;
    errorMsg =
        viewState == ViewState.error ? getErrorMessage(error, stackTrace) : '';
    notifyListeners();
  }

  loadData() {}
}
