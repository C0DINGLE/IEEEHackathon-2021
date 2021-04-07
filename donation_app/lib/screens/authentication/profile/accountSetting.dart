import 'dart:io';
import 'package:flutter/material.dart';

import '../../../services/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import './editDetails.dart';
import './constantsProfile.dart';

class AccountSettings extends StatefulWidget {
  final currentUser;
  final String uid;

  AccountSettings({this.currentUser, this.uid});

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  PickedFile _image;

  void _pickImage() async {

    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _image = pickedImageFile;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    void _showEditPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: EditDetails(
            widget.uid,
            widget.currentUser,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Your Account', style: TextStyle(color: Colors.grey, fontSize: 16),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          width: double.infinity,
          
          child: Column(
            children: [
              CircleAvatar(
                radius: kSpacingUnit.w * 5,
                backgroundImage: _image != null 
                  ? FileImage(File(_image.path))
                  : AssetImage('assets/images/user11.png'),
              ),
              SizedBox(height: kSpacingUnit.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton.icon(
                    label: Text('upload image'),
                    icon: Icon(Icons.image), 
                    onPressed: () {
                      _pickImage();
                      print("edit profile picture icon");
                    }
                  ),
                  SizedBox(width: kSpacingUnit.w),
                  FlatButton.icon(
                    textColor: Theme.of(context).primaryColor,
                    label: Text('save image'),
                    icon: Icon(Icons.save), 
                    onPressed: () async {
                      await DatabaseService(uid: widget.uid).saveImage(_image);
                      print('image saved to Firebase');
                    }
                  ),
                ],
              ),
              SizedBox(height: kSpacingUnit.w),

              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                            child: Divider(color: Colors.black, endIndent: 8,), 
                        ),
                        Text(
                          'Your Details', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Divider(color: Colors.black, indent: 8,),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Icon(Icons.person, color: Theme.of(context).primaryColor,),
                        Text(' Username', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 9.0),
                    Row(
                      children: [
                        SizedBox(width: 24),
                        Text(widget.currentUser['username'], style: TextStyle(fontSize: 18.0, letterSpacing: 0.8)),
                      ],
                    ),

                    SizedBox(height: 25.0),

                    Row(
                      children: [
                        Icon(Icons.email, color: Theme.of(context).primaryColor,),
                        Text(' Email', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 9.0),
                    Row(
                      children: [
                        SizedBox(width: 24),
                        Text(widget.currentUser['email'], style: TextStyle(fontSize: 18.0, letterSpacing: 0.8)),
                      ],
                    ),
                    
                    SizedBox(height: 25.0),

                    Row(
                      children: [
                        Icon(Icons.phone_android, color: Theme.of(context).primaryColor,),
                        Text(' Contact Number', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 9.0),
                    Row(
                      children: [
                        SizedBox(width: 24),
                        Text(widget.currentUser['number'], style: TextStyle(fontSize: 18.0, letterSpacing: 0.8)),
                      ],
                    ),

                    SizedBox(height: 25.0),

                    Row(
                      children: [
                        Icon(Icons.lock, color: Theme.of(context).primaryColor,),
                        Text(' Password', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 9.0),
                    Row(
                      children: [
                        SizedBox(width: 24),
                        Text(widget.currentUser['password'], style: TextStyle(fontSize: 18.0, letterSpacing: 0.8)),
                      ],
                    ),

                    SizedBox(height: 25.0),

                    Row(
                      children: [
                        Icon(Icons.supervised_user_circle, color: Theme.of(context).primaryColor,),
                        Text(' Role', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 9.0),
                    Row(
                      children: [
                        SizedBox(width: 24),
                        Text(widget.currentUser['role'].toUpperCase(), style: TextStyle(fontSize: 18.0, letterSpacing: 0.8)),
                      ],
                    ),

                    SizedBox(height: 35.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'EDIT',
                            style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 0.8),
                          ),
                          onPressed: (){
                            _showEditPanel();
                          }
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}