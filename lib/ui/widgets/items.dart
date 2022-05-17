import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/data/api/models/user.dart';

import 'loading_widget.dart';

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
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0, 1),
                      blurRadius: 18,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserItemGridView extends StatelessWidget {
  final User item;

  const UserItemGridView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: CachedNetworkImage(
                    imageUrl: item.picture, fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                "${item.firstName} ${item.age}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0, 1),
                    blurRadius: 10,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
            ),
          ),
          if (item.isSuperLike)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(2),
                child: Icon(Icons.star, color: Colors.blueAccent, size: 24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent, width: 3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
