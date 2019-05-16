import 'package:animations/models/bar_item.dart';
import 'package:flutter/material.dart';

class AnimatedBottomBarExample extends StatefulWidget {

  final List<BarItem> items = [
    BarItem(text: "Home", color: Colors.indigo, icon: Icons.home),
    BarItem(text: "Likes", color: Colors.pinkAccent, icon: Icons.favorite_border),
    BarItem(text: "Search", color: Colors.yellow.shade900, icon: Icons.search),
    BarItem(text: "Profile", color: Colors.teal, icon: Icons.person_outline),

  ];

  @override
  _AnimatedBottomBarExampleState createState() => _AnimatedBottomBarExampleState();
}

class _AnimatedBottomBarExampleState extends State<AnimatedBottomBarExample> {

  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(color: widget.items[selectedBarIndex].color, duration: Duration(milliseconds: 500) ,),
      bottomNavigationBar: AnimatedBottomBar(duration: const Duration(milliseconds: 500),
      barItems: widget.items, onSelected: (int selected){
        setState(() {
          selectedBarIndex = selected;
        });
        },),
    );
  }
}
