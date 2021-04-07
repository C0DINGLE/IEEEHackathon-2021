import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../providers/products.dart';
import '../../widgets/product_item.dart';

class CategoryGrid extends StatelessWidget {
  final bool showWished;
  final String category;

  CategoryGrid(this.showWished, this.category);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showWished ? productsData.donatedItems : productsData.catProds;
    
    return products.length == 0
      ? Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("No Donations in that category!", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                Container(
                  width: 260, 
                  height: 215,
                  child: SvgPicture.asset('assets/images/emptyBox.svg', fit: BoxFit.cover,)
                  ),
              ],
            ),
        )
      
      : GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
        // products[i].id,
        // products[i].title,
        // products[i].imageUrl,
      ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 20.0,
      ),
    );
  }
}