import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import './requestForm.dart';
import '../../services/database.dart';
import '../../shared/loading.dart';
import './donationCategoryCard.dart';

class AddDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          var userData = snapshot.data;
          return Builder(
            builder: (context) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Header
                        Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.23,
                          color: Theme.of(context).accentColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Hello, ', style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 0.6),),
                                  Text(userData['username'], style: TextStyle(color: Colors.white, fontSize: 17, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, letterSpacing: 0.65),),
                                ],
                              ),
                              SizedBox(height:10),

                              userData['role'] == 'Volunteer' 
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Someone need our help ? ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                                    SizedBox(height: 10,),
                                    Text('Add a request to help them...', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                                  ],
                                ) 
                                : Text('What are you willing to donate today ?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),),
                            ],
                          ),
                        ),

                        // Select Category
                        userData['role'] == 'Volunteer' 
                          ? Container(
                            // margin: EdgeInsets.symmetric(vertical:50),
                            child: Column(
                              children: [
                                Container(width: 220, height: 240, child: SvgPicture.asset('assets/images/request.svg')),
                                FlatButton.icon(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => RequestsForm()));
                                  }, 
                                  icon: Icon(Icons.add_alert, color: Colors.white), 
                                  label: Text('REQUEST', style: TextStyle(fontSize: 20, color: Colors.white),),
                                ),
                              ]
                            ),
                          )

                          : Container(
                                margin: EdgeInsets.symmetric(vertical:20),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AddCategoryCard(categoryName: 'BOOKS', categoryIcon: 'assets/images/books.png',),
                                      AddCategoryCard(categoryName: 'TOYS', categoryIcon: 'assets/images/toys.png',),
                                      AddCategoryCard(categoryName: 'CLOTHES', categoryIcon: 'assets/images/clothes.png',),
                                    ],
                                  ),
                                  
                                  SizedBox(height: 25,),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AddCategoryCard(categoryName: 'FOOD', categoryIcon: 'assets/images/food.png',),
                                      AddCategoryCard(categoryName: 'FURNITURE', categoryIcon: 'assets/images/furniture.png',),
                                      AddCategoryCard(categoryName: 'OTHER', categoryIcon: 'assets/images/other.png',),
                                    ],
                                  ),
                                  
                                  SizedBox(height: 20,),
                                ],),
                              ),
                        ],
                      ),
                ),
              );
            }
          ); 
        }
        else {
            return Loading();
        }
      });
  }
}