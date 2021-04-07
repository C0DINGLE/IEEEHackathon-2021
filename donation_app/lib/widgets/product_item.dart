import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add/donation_product_detail.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final box = Provider.of<Box>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).primaryColorLight,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isDonated ? Icons.flag_rounded : Icons.flag_outlined,
              ),
              color: Theme.of(context).primaryColorDark,
              onPressed: () {
                product.toggleWishedStatus();
              },
            ),
          ),
          title: Text(
            product.title,
            style: TextStyle(color: Colors.black, fontSize: 16, letterSpacing: 0.8),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add_box_outlined,
            ),
            onPressed: () {
              box.addItem(product.id, product.title, product.quantity,
                  product.imageUrl);
              //product.quantity -= 1;
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  content: Text(
                    'Added item to box!',
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Colors.grey[100],
                    onPressed: () {
                      box.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );
  }
}
