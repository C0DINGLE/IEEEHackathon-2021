import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './login.dart';
import './signup.dart';

class AccountSection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom:10),
                width: 300, 
                height: 210,
                child: SvgPicture.asset('assets/images/accountSection.svg')
              ),
              Text('Join Us, To Spread Smiles around the Corner.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center,),
              // Text('If you already have an account, Sign in'),
            ],
          ),

          Column(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.45,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Color.fromARGB(255, 22, 149, 138),
                  textColor: Colors.white,
                  child: Text('Sign in', style: TextStyle(fontSize: 17),),
                  splashColor: Colors.blue[200], 
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ),
              
              SizedBox(height: 13),

              Container(
                // margin: EdgeInsets.only(top:10),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.45,
                child: OutlineButton(
                  borderSide: BorderSide(color: Color.fromARGB(255, 22, 149, 138)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  textColor: Color.fromARGB(255, 22, 149, 138),
                  child: Text('Sign up', style: TextStyle(fontSize: 17),),
                  splashColor: Colors.green[200], 
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}