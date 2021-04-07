import 'package:flutter/material.dart';
import './edit_products_screen.dart';

class AddCategoryCard extends StatelessWidget {
  final String categoryIcon;
  final String categoryName;

  AddCategoryCard({this.categoryName, this.categoryIcon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductScreen(categoryName)));
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: Image.asset(
                categoryIcon,
                fit: BoxFit.contain,
              ),
              width: 90.0,
              height: 75.0,
            ),
            Container(margin: EdgeInsets.only(bottom:10), child: Text(categoryName, style: TextStyle(fontFamily: 'Montserat', fontSize: 13, fontWeight: FontWeight.bold,))),
          ],
        ),
      ),
    );
  }
}