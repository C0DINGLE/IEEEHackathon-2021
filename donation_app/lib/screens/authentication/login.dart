import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';
import './signup.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Sign in to Your Acount', style: TextStyle(color: Colors.grey, fontSize: 16),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(bottom:8), height: 80, child: SvgPicture.asset('assets/images/logoOnly.svg')),
            Text('iAid', style: TextStyle(fontSize:34, fontWeight: FontWeight.w900,), textAlign: TextAlign.center,),
            Text('Smiles around the corner', style: TextStyle(fontSize:14, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center,),
            
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        validator: (val) {
                          if (val.isEmpty || !val.contains('@')){
                            return 'Please provide a valid email.';
                          }
                          return null;
                        },
                        style: TextStyle(letterSpacing: 0.7, fontSize: 17,),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: EdgeInsets.symmetric(horizontal:8, vertical: 14),
                          prefixIcon: Icon(Icons.alternate_email, size: 20,),
                        ),
                        controller: _email,
                      ),
                      SizedBox(height:15),
                      
                      TextFormField(
                        validator: (val) => val.length < 6 ? 'Enter a 6+ chars password' : null,
                        obscureText: true,
                        style: TextStyle(letterSpacing: 0.7, fontSize: 17),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(horizontal:8, vertical: 14),
                          prefixIcon: Icon(Icons.lock, size: 20,),
                        ),
                        controller: _password,
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height:13),

            Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal:60),
                  width: double.infinity,
                  height: 50,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),  
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 41, 213, 178), Color.fromARGB(255, 27, 164, 215)],
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                    ),
                  ),

                  child: FlatButton(
                    child: Text(
                      'LOG IN',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.signIn(_email.text, _password.text);                        
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Could not sign in with those credentials';
                          });
                        }
                        else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height:15),
                Text('Don\'t have an account?', style: TextStyle(fontSize:14,), textAlign: TextAlign.center,),
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text(
                    'Join now', 
                    style: TextStyle(fontSize:14, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor), 
                    textAlign: TextAlign.center,
                  )
                ),
          ],
        ),
      ),
    );
  }
}