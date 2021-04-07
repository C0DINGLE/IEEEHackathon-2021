import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class DonationsGrid extends StatelessWidget {
  final bool showWished;

  DonationsGrid(this.showWished);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showWished ? productsData.donatedItems : productsData.items;
    return GridView.builder(
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
