import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tinder/data/api/models/user.dart';
import 'package:tinder/tinder.dart';
import 'package:tinder/ui/widgets/items.dart';
import 'package:tinder/util/enums.dart';

class ViewListScreen extends StatelessWidget {
  final ViewListArgs args;

  const ViewListScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          args.type == ListType.likedList
              ? context.localizations.likedList
              : context.localizations.secondLook,
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: _buildContentView(context),
    );

    return kIsWeb
        ? FittedBox(
            child: Container(
              width: 0.5625 * MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height,
              child: content,
            ),
          )
        : content;
  }

  _buildContentView(BuildContext context) {
    if (args.users.isEmpty)
      return Center(
        child: Text(
          args.type == ListType.likedList
              ? context.localizations.likedListEmptyMsg
              : context.localizations.secondLookEmptyMsg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: EdgeInsets.all(16),
      children: args.users.map((user) => UserItemGridView(item: user)).toList(),
    );
  }
}

class ViewListArgs {
  final List<User> users;
  final ListType type;

  ViewListArgs({required this.users, required this.type});
}
