import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 65,
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(color: Colors.black12, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ]),
        )
      ],
    );
  }
}
