import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 2000),
      () {
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          color: Colors.black87,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2.743,
              child: FlareActor(
                "assets/animations/Success_Check.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "Untitled",
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
