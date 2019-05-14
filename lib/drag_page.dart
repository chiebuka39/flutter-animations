import 'package:animations/app_bottom_bar.dart';
import 'package:flutter/material.dart';

class DragPage extends StatefulWidget {
  @override
  _DragPageState createState() => _DragPageState();
}

class _DragPageState extends State<DragPage> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.90;
  double expandedHeightFactor = 0.75;
  bool _isAnimationCompleted = false;
  double screenHeight = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500))..addListener((){
//      print( _controller.value );
    });
    _heightFactorAnimation = Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onBottomTapPart(){
    setState(() {
      if(_isAnimationCompleted){
        _controller.reverse();
      }else{
        _controller.forward();
      }
      _isAnimationCompleted = !_isAnimationCompleted;
    });
  }

  Widget getWidget(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: _heightFactorAnimation.value,
          child: Image.asset('assets/messi.jpg', fit: BoxFit.cover,colorBlendMode: BlendMode.hue,color: Colors.black,),
        ),
        GestureDetector(
          onTap: onBottomTapPart,
          onVerticalDragUpdate: _handleVerticalUpdate,
          onVerticalDragEnd: _handleVerticalEnd,
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 1.05 - _heightFactorAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      bottomNavigationBar: AppBottomBar(),
      body: AnimatedBuilder(animation: _controller, builder: (context, widget){
        return getWidget();
      }),
    );
  }

  void _handleVerticalEnd(DragEndDetails details) {

  }

  void _handleVerticalUpdate(DragUpdateDetails details) {
    double fractionDragged = details.primaryDelta / screenHeight;

    _controller.value = _controller.value -  5 * fractionDragged;


  }
}
