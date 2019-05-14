import 'package:flutter/material.dart';

class AppBottomBar extends StatefulWidget {
  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton( icon: Icon(Icons.add), onPressed: () {},),
            IconButton( icon: Icon(Icons.category), onPressed: () {},),
            IconButton( icon: Icon(Icons.forward), onPressed: () {},),
            IconButton( icon: Icon(Icons.account_balance_wallet), onPressed: () {},)
          ],
        ),
      ),
    );
  }
}
