import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../providers/cart.dart';
import '../../providers/orders.dart';

import '../../main.dart';

class AnimateBox extends StatefulWidget {
  @override
  _AnimateBoxState createState() => _AnimateBoxState();
}

class _AnimateBoxState extends State<AnimateBox> {
  @override
  Widget build(BuildContext context) {
    final box = Provider.of<Box>(context);
    return Scaffold(
      body: Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Smile Box Packed !!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),),
          SizedBox(height: 10),

          Lottie.asset(
            'assets/images/lottie_file.json',
            repeat: false,
            reverse: true,
            animate: true,
          ),
          
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal:65),
            width: double.infinity,
            height: 50,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).primaryColor,
            ),

            child: OutlineButton(
              child: Text(
                'Back to Home',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                box.clear();
                Provider.of<Orders>(context, listen: false).orders.clear();
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
        ],
      ),
    ),
    );
  }
}