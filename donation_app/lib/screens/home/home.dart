import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../screens/categories/categoryDonationsScreen.dart';
import '../add/donation_products_screen.dart';
import './exploreDonations.dart';
import './helpRequests.dart';
import '../../providers/products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List categoriesAvailable = ['BOOKS', 'FOOD', 'CLOTHES', 'TOYS', 'FURNITURE', 'OTHERS'];

  final List categoriesIcons = [
    'assets/images/categorySVG/books.svg', 
    'assets/images/categorySVG/food.svg', 
    'assets/images/categorySVG/clothes.svg', 
    'assets/images/categorySVG/toys.svg', 
    'assets/images/categorySVG/furniture.svg', 
    'assets/images/categorySVG/others.svg',
  ];
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context).fetchData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

//====================================================================

                // Search BAR
                Container(
                  height: 35,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 22, 149, 138), width: 2.0),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize:14),
                        prefixIcon: Icon(Icons.search,),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                      )
                  ),
                ),

                SizedBox(height: 20,),

//====================================================================

                // CATEGORIES SECTION
                Text('Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                Container(
                    margin: EdgeInsets.only(top: 13),
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (cntxt, index){
                        return Card(
                          margin: EdgeInsets.only(right: 13),
                          elevation: 2,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => CategoryDonationsScreen(titleText: categoriesAvailable[index],)),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                                  child: SvgPicture.asset(
                                    categoriesIcons[index],
                                    fit: BoxFit.contain,
                                  ),
                                  width: MediaQuery.of(context).size.width*0.21,
                                  height: MediaQuery.of(context).size.width*0.15,
                                ),
                                Text(categoriesAvailable[index], style: TextStyle(fontFamily: 'Roboto', fontSize: 13, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: categoriesAvailable.length,    
                    ),
                  ),

                SizedBox(height: 10,),

//====================================================================

                // URGENT HELP BUTTON
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal:10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),  
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 41, 213, 178), Color.fromARGB(255, 27, 164, 215)],
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                    ),
                  ),

                  child: FlatButton.icon(
                    icon: Icon(Icons.location_on, size: MediaQuery.of(context).size.height * 0.04, color: Colors.white,),
                    label: FittedBox(child: Text('People need Urgent help near you!', style: TextStyle( color: Colors.white))),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => HelpRequests()),
                      );
                    },
                  ),
                ),
                
                SizedBox(height: 10,),

//====================================================================
                
                // SECTION 3: DONATIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Explore Donations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    FlatButton(
                      child: Row(
                        children: [
                          Text('show all ', style: TextStyle(fontSize: 15),),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => DonationProductScreen()),
                        );
                      },
                    ),
                  ],
                ),
                ExploreDonations(),
              ],
            ),
          ),
        );
  }
}