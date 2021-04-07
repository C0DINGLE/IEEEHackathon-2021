import 'package:flutter/material.dart';
import '../../../services/database.dart';

class EditDetails extends StatefulWidget {
  final String uid;
  final currentUser;

  EditDetails(this.uid, this.currentUser);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  final _formKey = GlobalKey<FormState>();

  final List<String> roles = ['Donor', 'Volunteer'];
  
  // form values
  String _currentUsername;
  String _currentRole;
  String _currentNumber;

  @override
  Widget build(BuildContext context) {

    return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mode_edit),
                    SizedBox(width: 10.0),
                    Text(
                      'Edit your details',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                
                SizedBox(height: 25.0),
                
                TextFormField(
                  initialValue: widget.currentUser['username'],
                  decoration: InputDecoration(
                    icon: Icon(Icons.person, color: Theme.of(context).accentColor),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter a username' : null,
                  onChanged: (val) => setState(() => _currentUsername = val),
                ),
                SizedBox(height: 13.0),
                
                TextFormField(
                  initialValue: widget.currentUser['number'],
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone_android, color: Theme.of(context).accentColor),
                  ),
                  validator: (val) => val.length < 10 ? 'Enter a correct number' : null,
                  onChanged: (val) => setState(() => _currentNumber = val),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 13.0),
                
                DropdownButtonFormField(
                  value: _currentRole ?? widget.currentUser['role'],
                  decoration: InputDecoration(
                    icon: Icon(Icons.supervised_user_circle, color: Theme.of(context).accentColor),
                  ),
                  items: roles.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text('As a $role'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentRole = val ),
                ),
                SizedBox(height: 35.0),

                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      // print(widget.uid);
                      await DatabaseService(uid: widget.uid).updateUserData(
                        username: _currentUsername ?? widget.currentUser['username'],
                        number: _currentNumber ?? widget.currentUser['number'],
                        role: _currentRole ?? widget.currentUser['role'],
                        email: widget.currentUser['email'],
                        password: widget.currentUser['password'],
                      );
                      var nav = Navigator.of(context);
                      nav.pop();
                      nav.pop();
                      
                    }
                  }
                ),
              ],
            ),
          );
      }
}