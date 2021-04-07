import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../services/database.dart';
import '../../shared/loading.dart';
import './profile/constantsProfile.dart';
import './profile/profileListItem.dart';
import './profile/accountSetting.dart';
import './profile/history.dart';
import './profile/manageDonations.dart';

class Profile extends StatefulWidget {
  
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    User user = Provider.of<User>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          var userData = snapshot.data;
          return Builder(
            builder: (context) {
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: kSpacingUnit.w * 5.5),
                        
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: kSpacingUnit.w * 10,
                                width: kSpacingUnit.w * 10,
                                margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                                child: Stack(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: kSpacingUnit.w * 5,
                                      backgroundImage: userData['image_url'] == "" 
                                        ? AssetImage('assets/images/user11.png')
                                        : NetworkImage(userData['image_url'])
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(height: kSpacingUnit.w * 2),
                              Text(
                                userData['username'],
                                style: kTitleTextStyle.copyWith(
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(height: kSpacingUnit.w * 0.8),
                              Text(
                                userData['email'],
                                style: kCaptionTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: kSpacingUnit.w),
                              Text(
                                userData['role'].toUpperCase(),
                                style: kCaptionTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: kSpacingUnit.w * 2),                             
                            ],
                          ),
                        ),
                        SizedBox(width: kSpacingUnit.w * 5.5),
                      ],
                    ),
 
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          ProfileListItem(
                            onClicked: AccountSettings(
                              currentUser: userData,
                              uid: user.uid,
                            ),
                            icon: LineAwesomeIcons.user_shield,
                            text: 'Account',
                          ),

                          ProfileListItem(
                            onClicked: userData['role'] == 'Donor' ? PastHistory() : ManageDonations(),
                            icon: LineAwesomeIcons.history,
                            text: userData['role'] == 'Donor' ? 'Your Donations' : 'Manage Donations',
                          ),

                          ProfileListItem(
                            onClicked: PastHistory(),
                            icon: LineAwesomeIcons.map_marker,
                            text: 'Location',
                          ),

                          ProfileListItem(
                            onClicked: PastHistory(),
                            icon: LineAwesomeIcons.user_plus,
                            text: 'Invite a Friend',
                          ),
                          
                          ProfileListItem(
                            onClicked: PastHistory(),
                            icon: LineAwesomeIcons.alternate_sign_out,
                            text: 'Logout',
                            hasNavigation: false,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
        else {
          return Loading();
        }
      });
  }
}