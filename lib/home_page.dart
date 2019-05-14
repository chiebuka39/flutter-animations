import 'package:flutter/material.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget  {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
enum ScoreWidgetStatus {
  HIDDEN,
  VISIBLE,
  BECOMING_VISIBLE,
  BECOMING_INVISIBLE
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin  {
  int _counter = 0;
  double extraSize;
  final duration = new Duration(milliseconds: 300);
  Timer timer;
  Timer scoreOutETA;

  AnimationController scoreInAnimationController;
  AnimationController scoreOutAnimationController;
  AnimationController scoreSizeAnimationController;
  Animation<double> scoreOutPositionAnimation;
  ScoreWidgetStatus _scoreWidgetStatus;




  @override
  void initState() {
    setUpScoreSizeAnimationController();
    setUpScoreInAnimationController();
    setUpScoreOutAnimation();
    super.initState();
  }

  void setUpScoreSizeAnimationController() {
    scoreSizeAnimationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 150));
    scoreSizeAnimationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener((){
      setState(() {});
    });
  }

  void setUpScoreOutAnimation() {
    scoreOutAnimationController = new AnimationController(vsync: this, duration: duration);
    scoreOutPositionAnimation = new Tween(begin: 100.0, end: 150.0).animate(
        new CurvedAnimation(parent: scoreOutAnimationController, curve: Curves.easeOut)
    );
    scoreOutPositionAnimation.addListener((){
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });
  }

  void setUpScoreInAnimationController() {
    scoreInAnimationController = new AnimationController(duration: new Duration(milliseconds: 150), vsync: this);
    scoreInAnimationController.addListener((){
      setState(() {}); // Calls render function
    });
  }

  void increment(Timer t) {
    scoreSizeAnimationController.forward(from: 0.0);
    setState(() {

      _counter++;
    });
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    if (scoreOutETA != null) scoreOutETA.cancel(); // We do not want the score to vanish!
    if(_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    }else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN) {
      scoreInAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
    }
    increment(null); // Take care of tap
    timer = new Timer.periodic(duration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    // User removed his finger from button.
    scoreOutETA = new Timer(duration, () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });
    timer.cancel();
  }

  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    extraSize = scoreSizeAnimationController.value * 10;
    switch(_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.VISIBLE:
      case ScoreWidgetStatus.BECOMING_VISIBLE :
        scorePosition = scoreInAnimationController.value * 100;
        scoreOpacity = scoreInAnimationController.value;


        break;

      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
    }
    return new Positioned(
        child: new Opacity(opacity: scoreOpacity, child: new Container(
            height: 50.0 + extraSize,
            width: 50.0 + extraSize,
            decoration: new ShapeDecoration(
              shape: new CircleBorder(
                  side: BorderSide.none
              ),
              color: Colors.pink,
            ),
            child: new Center(child:
            new Text("+" + _counter.toString(),
              style: new TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),))
        )),
        bottom: scorePosition
    );
  }

  Widget getClapButton() {
    // Using custom gesture detector because we want to keep increasing the claps
    // when user holds the button.
    return new GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: new Container(
          height: 60.0 ,
          width: 60.0 ,
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.pink, width: 1.0),
              borderRadius: new BorderRadius.circular(50.0),
              color: Colors.white,
              boxShadow: [
                new BoxShadow(color: Colors.pink, blurRadius: 8.0)
              ]
          ),
          child: new Icon(
              Icons.add, color: Colors.pink,
              size: 40.0),
        )
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new Padding(
          padding: new EdgeInsets.only(right: 20.0),
          child: new Stack(
            alignment: FractionalOffset.center,
            overflow: Overflow.visible,
            children: <Widget>[
              getScoreButton(),
              getClapButton(),
            ],
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}