import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/tinder.dart';
import 'package:tinder/ui/widgets/error_widget.dart';
import 'package:tinder/ui/widgets/loading_widget.dart';
import 'package:tinder/util/enums.dart';

import '../di/locator.dart';
import 'base_model.dart';

abstract class BaseViewState<M extends BaseModel, W extends StatefulWidget>
    extends State<W> {
  late M model;

  bool get autoLoadData => true;

  @override
  void initState() {
    super.initState();
    createModel();
    onModelReady();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<M>.value(
      value: model,
      child: Consumer<M>(
          builder: (context, model, child) => buildViewByState(context, model)),
    );
  }

  Widget buildViewByState(BuildContext context, M model) {
    switch (model.viewState) {
      case ViewState.loading:
        return buildLoadingView(context);
      case ViewState.error:
        return buildErrorView(context);
      case ViewState.loaded:
        return buildLoadedView(context, model);
      default:
        return Container();
    }
  }

  void createModel() {
    model = locator<M>();
  }

  Widget buildLoadingView(BuildContext context) => LoadingWidget();

  Widget buildErrorView(BuildContext context) => ErrorViewWidget(
        message: model.errorMsg ?? context.localizations.unknownError,
        onRetry: onRetry,
      );

  Widget buildLoadedView(BuildContext context, M model);

  void onModelReady() {
    if (autoLoadData) {
      model.loadData();
    }
  }

  void onRetry() {
    model.loadData();
  }
}
