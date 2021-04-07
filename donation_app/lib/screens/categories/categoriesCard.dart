import 'package:flutter/material.dart';
import './categoryDonationsScreen.dart';

class CategoryCard extends StatelessWidget {
  final String categoryIcon;
  final String category;
  
  CategoryCard(this.category, this.categoryIcon);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => CategoryDonationsScreen(titleText: category,)),
          );
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: Image.asset(
                categoryIcon,
                fit: BoxFit.contain,
              ),
              width: 120.0,
              height: 105.0,
            ),
            Container(margin: EdgeInsets.only(bottom:10), child: Text(category, style: TextStyle(fontFamily: 'Montserat', fontSize: 13, fontWeight: FontWeight.bold,))),
          ],
        ),
      ),
    );
  }
}