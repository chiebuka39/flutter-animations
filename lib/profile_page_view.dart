import 'package:animations/models/profile.dart';
import 'package:flutter/material.dart';

class ProfilePageView extends StatefulWidget {

  final PageController _pageController = PageController(initialPage: 0);

  final double opacity = 0.5;

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> with SingleTickerProviderStateMixin{

  AnimationController _controller;

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
    return PageView.builder(
      itemCount: profiles.length,
        controller: widget._pageController,
        pageSnapping: true,
        onPageChanged: null,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){

      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(profiles[index].imagePath, fit: BoxFit.cover, colorBlendMode: BlendMode.hue,color: Colors.black,),
          DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black.withOpacity(widget.opacity), Colors.white.withOpacity(widget.opacity)],
            begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          ),
          )
          )],
      );
    });
  }
}
