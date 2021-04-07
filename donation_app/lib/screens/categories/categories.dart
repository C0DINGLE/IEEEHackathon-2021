import 'package:flutter/material.dart';

import './categoriesCard.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 27, 164, 215), Color.fromARGB(255, 41, 213, 178),],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          )
        ),
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose', style: TextStyle(fontSize: 25, color: Colors.white)),
                Text('Category', style: TextStyle(fontSize: 25, color: Colors.white)),
                
                Container(
                  margin: EdgeInsets.symmetric(vertical:30),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CategoryCard('BOOKS', 'assets/images/books.png'),
                        SizedBox(width: 15,), 
                        CategoryCard('TOYS', 'assets/images/toys.png'),
                      ],
                    ),
                    
                    SizedBox(height: 10,),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CategoryCard('CLOTHES', 'assets/images/clothes.png'),
                        SizedBox(width: 15,),
                        CategoryCard('FOOD', 'assets/images/food.png'),
                      ],
                    ),
                    
                    SizedBox(height: 10,),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CategoryCard('FURNITURE', 'assets/images/furniture.png'),
                        SizedBox(width: 15,),
                        CategoryCard('OTHERS', 'assets/images/other.png'),
                      ],
                    ),
                    
                  ],),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}