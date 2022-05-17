import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder/bases/base_state.dart';
import 'package:tinder/data/api/models/user.dart';
import 'package:tinder/res/images.dart';
import 'package:tinder/tinder.dart';
import 'package:tinder/ui/screens/cards/cards_model.dart';
import 'package:tinder/ui/widgets/loading_widget.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends BaseViewState<CardsModel, CardsPage> {
  MatchEngine? _matchEngine;
  List<SwipeItem> _swipeItems = <SwipeItem>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: super.build(context),
        ),
      ),
    );
  }

  @override
  Widget buildLoadingView(BuildContext context) => _buildEmptyView();

  @override
  Widget buildLoadedView(BuildContext context, CardsModel model) {
    print('buildLoadedView');

    _swipeItems.addAll(model.users.map((user) => _createSwipeItem(user)));
    _matchEngine = MatchEngine(swipeItems: _swipeItems);

    if (model.users.isEmpty) return _buildEmptyView();

    return Column(
      children: [
        Expanded(
          child: SwipeCards(
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
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(side: BorderSide(color: Colors.red, width: 4)),
            child: Icon(Icons.close, size: 36, color: Colors.red),
            onPressed: () {
              _matchEngine!.currentItem!.nope();
            },
          ),
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape:
                StadiumBorder(side: BorderSide(color: Colors.blue, width: 4)),
            child: Icon(Icons.star, size: 36, color: Colors.blue),
            onPressed: () {
              _matchEngine!.currentItem!.superLike();
            },
          ),
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(side: BorderSide(color: Colors.red, width: 4)),
            child: Icon(Icons.favorite, size: 35, color: Colors.red),
            onPressed: () {
              _matchEngine!.currentItem!.like();
            },
          ),
        ],
      ),
    );
  }

  _createSwipeItem(User user) {
    return SwipeItem(content: user);
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

class UserItemCard extends StatelessWidget {
  final User item;

  const UserItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: item,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: item.picture,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SizedBox(
                    width: 32,
                    height: 32,
                    child: LoadingWidget(),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  memCacheHeight: MediaQuery.of(context).size.width.toInt(),
                  memCacheWidth: MediaQuery.of(context).size.height.toInt(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Consumer<User>(
                  builder: (ctx, user, child) => Text(
                    user.dateOfBirth == null
                        ? user.firstName
                        : "${user.firstName} ${user.age}",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
