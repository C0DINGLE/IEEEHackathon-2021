import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:donation_app/main.dart';
import '../../shared/loading.dart';
import '../../services/auth.dart';
import './login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;
  
  // Text Controller for inputs
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _password = TextEditingController();

  int groupValue = -1;
  List role = ['Donor', 'Volunteer'];

  void handleRadioValueChanged(int value) {
    setState(() {
      this.groupValue = value;
    });
  }

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
        title: Text('Create your account', style: TextStyle(color: Colors.grey, fontSize: 16),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 50, width: 40, child: SvgPicture.asset('assets/images/logoOnly.svg')),
                Text('Be a part of it with us', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor), textAlign: TextAlign.center,),
              ],
            ),
            
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Column(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Divider(color: Colors.black54, thickness: 1.2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'As:',
                            style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Radio(
                            value: 0,
                            groupValue: groupValue,
                            onChanged: handleRadioValueChanged),
                          Text(
                            "Donor",
                            style: new TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Radio(
                            value: 1,
                            groupValue: groupValue,
                            onChanged: handleRadioValueChanged),
                          Text(
                            "Volunteer",
                            style: new TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black54, thickness: 1.2,),
                    ]),
                    SizedBox(height:13),
                    
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter a username' : null,
                      style: TextStyle(letterSpacing: 0.7, fontSize: 17),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        contentPadding: EdgeInsets.symmetric(horizontal:8, vertical: 14),
                        prefixIcon: Icon(Icons.person, size: 20,),
                      ),
                      controller: _username,                      
                    ),
                    SizedBox(height:13),
                    
                    TextFormField(
                      validator: (val) => val.length < 10 ? 'Enter a correct number' : null,
                      style: TextStyle(letterSpacing: 0.7, fontSize: 17),
                      decoration: InputDecoration( 
                        hintText: 'Contact Number',
                        contentPadding: EdgeInsets.symmetric(horizontal:8, vertical: 14),
                        prefixIcon: Icon(Icons.phone_android, size: 20,),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _number,
                    ),
                    SizedBox(height:13),
                    
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
                    SizedBox(height:13),
                    
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
                      'Create Account',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        setState(() => loading = true );
                        
                        dynamic result = await _auth.signUp(
                          email: _email.text,
                          number: _number.text,
                          password: _password.text,
                          role: role[groupValue],
                          username: _username.text,
                        );

                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email';
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


                Text('Already have an account?', style: TextStyle(fontSize:14,), textAlign: TextAlign.center,),
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Sign in', 
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