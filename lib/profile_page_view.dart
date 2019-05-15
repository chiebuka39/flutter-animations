import 'package:flutter/material.dart';

class ProfilePageView extends StatefulWidget {
  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/messi.jpg', fit: BoxFit.cover,colorBlendMode: BlendMode.hue,color: Colors.black,);
  }
}
