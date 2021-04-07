import 'package:flutter/material.dart';

class DonationReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Your received donations will appear here, with review/feedback button.", style: TextStyle(color: Colors.black87, fontSize: 18), textAlign: TextAlign.center,),
      ),
    );
  }
}