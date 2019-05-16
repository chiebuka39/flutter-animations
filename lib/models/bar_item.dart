import 'package:flutter/material.dart';

class BarItem {
  String text;
  IconData icon;
  Color color;

  BarItem({@required this.text, @required this.color, @required this.icon});
}

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration duration;
  final Function onSelected;

  AnimatedBottomBar({@required this.barItems, @required this.duration, @required this.onSelected});

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  AnimationController _controller;
  int selectedBarIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 8, 34),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = List();


    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = i == selectedBarIndex;
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: (){
          setState(() {
            selectedBarIndex = i;
            widget.onSelected(i);
          });
        },
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? item.color.withOpacity(0.2) : Colors.transparent,
            borderRadius:  BorderRadius.all(Radius.circular(30))
          ),
          
          child: Row(
            children: <Widget>[
              Icon(
                item.icon,
                color: isSelected ? item.color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              AnimatedSize(
                child: isSelected ? Text(
                  item.text,
                  style: TextStyle(
                      color: item.color, fontWeight: FontWeight.w600, fontSize: 18),
                ): Text(""), vsync: this,
                duration: widget.duration,
              )
            ],
          ), duration: Duration(milliseconds: 200),
        ),
      ));
    }
    return _barItems;
  }
}
