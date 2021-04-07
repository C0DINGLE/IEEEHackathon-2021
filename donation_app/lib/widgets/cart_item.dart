import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class BoxItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double quantity;
  final String imageUrl;

  BoxItem(
    this.id,
    this.productId,
    this.title,
    this.quantity,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      // ignore: missing_return
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove $title from the box?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text('Yes')),
              FlatButton(onPressed: () {
                 Navigator.of(ctx).pop(false);
              }, child: Text('No')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Box>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              // child: FittedBox(
              //   child: Text('Product $id'),
              // ),
            ),
            title: Text(title),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
