import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder/bases/base_state.dart';
import 'package:tinder/data/api/models/user.dart';
import 'package:tinder/data/services/navigation_service.dart';
import 'package:tinder/res/images.dart';
import 'package:tinder/res/routes.dart';
import 'package:tinder/tinder.dart';
import 'package:tinder/ui/screens/cards/cards_model.dart';
import 'package:tinder/ui/screens/view_list/view_list_screen.dart';
import 'package:tinder/ui/widgets/buttons.dart';
import 'package:tinder/ui/widgets/items.dart';
import 'package:tinder/util/enums.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends BaseViewState<CardsModel, CardsScreen> {
  MatchEngine? _matchEngine;
  List<SwipeItem> _swipeItems = <SwipeItem>[];

  _buildAppBar() {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(TDImages.tinder, width: 24, height: 24),
          const SizedBox(width: 8),
          Text(
            context.localizations.tinder,
            style: TextStyle(color: Colors.pink),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? FittedBox(
            child: Container(
              width: 0.5625 * MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height,
              child: super.build(context),
            ),
          )
        : super.build(context);
  }

  @override
  Widget buildLoadingView(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildEmptyView(),
    );
  }

  @override
  Widget buildErrorView(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: super.buildErrorView(context),
    );
  }

  @override
  Widget buildLoadedView(BuildContext context, CardsModel model) {
    _swipeItems.addAll(model.users.map((user) => _createSwipeItem(user)));
    _matchEngine = MatchEngine(swipeItems: _swipeItems);

    if (model.users.isEmpty) return _buildEmptyView();

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SwipeCards(
                  upSwipeAllowed: true,
                  matchEngine: _matchEngine!,
                  itemBuilder: (context, index) {
                    final item = _swipeItems[index].content;
                    return UserItemCard(item: item);
                  },
                  itemChanged: (item, index) {
                    model.getDetail(index, item.content.id);
                  },
                  onStackFinished: () async {
                    _swipeItems.clear();
                    model.clearUsers();

                    model.page++;
                    model.loadData();
                  },
                ),
              ),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 64,
          child: Row(
            children: [
              Expanded(
                child: TDTextButton(
                  textColor: Colors.red,
                  icon: Icon(Icons.close, color: Colors.red),
                  label: context.localizations.secondLook,
                  onPressed: () => routeService.pushNamed(Routes.viewList,
                      arguments: ViewListArgs(
                          users: model.passed, type: ListType.secondLook)),
                ),
              ),
              Expanded(
                child: TDTextButton(
                  textColor: Colors.pink,
                  icon: Icon(Icons.favorite, color: Colors.pink),
                  label: context.localizations.likedList,
                  onPressed: () => routeService.pushNamed(Routes.viewList,
                      arguments: ViewListArgs(
                          users: model.liked, type: ListType.likedList)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            elevation: 0.0,
            heroTag: "btnPass",
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(side: BorderSide(color: Colors.red, width: 4)),
            child: Icon(Icons.close, size: 36, color: Colors.red),
            onPressed: () {
              _matchEngine!.currentItem!.nope();
            },
          ),
          FloatingActionButton(
            elevation: 0.0,
            heroTag: "btnSuperLike",
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
                side: BorderSide(color: Colors.blueAccent, width: 4)),
            child: Icon(Icons.star, size: 36, color: Colors.blueAccent),
            onPressed: () {
              _matchEngine!.currentItem!.superLike();
            },
          ),
          FloatingActionButton(
            elevation: 0.0,
            heroTag: "btnLike",
            backgroundColor: Colors.transparent,
            shape:
                StadiumBorder(side: BorderSide(color: Colors.pink, width: 4)),
            child: Icon(Icons.favorite, size: 35, color: Colors.pink),
            onPressed: () {
              _matchEngine!.currentItem!.like();
            },
          ),
        ],
      ),
    );
  }

  _createSwipeItem(User user) {
    return SwipeItem(
      content: user,
      nopeAction: () => model.addPassed(user),
      superlikeAction: () => _onLiked(user, isSuperLike: true),
      likeAction: () => _onLiked(user, isSuperLike: false),
    );
  }

  _onLiked(User user, {bool isSuperLike = false}) {
    model.addLiked(user, isSuperLike: isSuperLike);
  }

  Widget _buildEmptyView() {
    return RippleAnimation(
      repeat: true,
      color: Colors.pink,
      minRadius: 90,
      ripplesCount: 6,
      child: Center(
        child: Image.asset(TDImages.tinder, width: 128, height: 128),
      ),
    );
  }
}
