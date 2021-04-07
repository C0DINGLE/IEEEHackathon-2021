import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // color: Colors.white70,
      child: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        )
      ),
    );
  }
}