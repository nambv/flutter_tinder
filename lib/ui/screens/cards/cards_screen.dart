import 'package:flutter/material.dart';
import 'package:tinder/bases/base_state.dart';
import 'package:tinder/ui/screens/cards/cards_model.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends BaseViewState<CardsModel, CardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: super.build(context),
    );
  }

  @override
  Widget buildLoadedView(BuildContext context, CardsModel model) {
    return Container();
  }
}
