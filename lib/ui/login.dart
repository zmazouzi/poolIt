import 'dart:ui';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> logoSizeAnimation;
  Animation<double> buttonSizeAnimation;
  Animation<double> loginTitleXTranslationAnimation;
  Animation<double> loginTitleOpacityAnimation;

  Widget _buildLoginButton(BuildContext context) {
    return Transform(
      transform: Matrix4.diagonal3Values(
        buttonSizeAnimation.value,
        buttonSizeAnimation.value,
        1.0,
      ),
      alignment: Alignment.center,
      child: RaisedButton(
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
                "Continuer avec Google",
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
      ),
    );
  }


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

  Widget _buildLoginTitle() {
    return Padding(
      padding: EdgeInsets.only(left: loginTitleXTranslationAnimation.value),
      child: Opacity(
        opacity: loginTitleOpacityAnimation.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Bienvenue sur Yallah !",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 8),
            Text("Covoiture gratuit et sécurisé",
                style: TextStyle(fontSize: 16, color: Colors.white)),

          ],
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
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 150),
            _buildLogo(),
            _buildLoginTitle(),
            SizedBox(height: 50),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: _buildLoginButton(context))
          ],
        )
      ],
    );
  }


  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    logoSizeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.25, curve: Curves.bounceOut)));
    buttonSizeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.75, 1.0, curve: Curves.bounceOut)));

    loginTitleXTranslationAnimation = Tween(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.25,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    loginTitleOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.25,
          0.5,
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
