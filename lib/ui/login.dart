import 'dart:ui';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> logoSizeAnimation;
  Animation<double> loginTitleXTranslationAnimation;
  Animation<double> loginTitleOpacityAnimation;

  Widget _buildLogo() {
    return Transform(
      transform: Matrix4.diagonal3Values(
        logoSizeAnimation.value,
        logoSizeAnimation.value,
        1.0,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white30),
        ),
        margin: const EdgeInsets.only(top: 32.0, left: 16.0),
        padding: const EdgeInsets.all(3.0),
        child: ClipOval(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150),
              _buildLogo(),
              Text("Welcom to Yollo !",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 8),
              Text("Pick friends with ur car",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              SizedBox(height: 50),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: _buildLoginButton(context))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return RaisedButton(
      elevation: 16,
      color: Colors.lightBlue,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
              ),
              child: Image.asset(
                "assets/google.png",
                height: 25,
                width: 25,
              ),
            ),
            SizedBox(
              width: 24.0,
            ),
            Text(
              "Continue with google",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            )
          ],
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    );
  }

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    logoSizeAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    loginTitleXTranslationAnimation = Tween(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.830,
          1.000,
          curve: Curves.ease,
        ),
      ),
    );

    loginTitleOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.830,
          1.000,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(animation: controller, builder: _buildAnimation),
    );
  }
}
