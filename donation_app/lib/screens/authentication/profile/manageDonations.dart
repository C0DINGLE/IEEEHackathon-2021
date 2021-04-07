import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../providers/products.dart';
import '../../../widgets/user_product_item.dart';

class ManageDonations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Manage Donations', style: TextStyle(color: Colors.grey, fontSize: 16),),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        padding: EdgeInsets.fromLTRB(8, 15, 8, 10),
        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Currently Active', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Divider(color: Theme.of(context).primaryColor, indent: 8, thickness: 1.3),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              child: ListView.builder(
                // itemCount: productsData.items.length,
                itemCount: 2,
                itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      productsData.items[i].id,
                      productsData.items[i].title,
                      productsData.items[i].imageUrl,
                      productsData.items[i].userId,
                      productsData.items[i].category,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            Row(
              children: [
                Text(
                  'Delivered / Completed', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Divider(color: Theme.of(context).primaryColor, indent: 8, thickness: 1.3,),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      productsData.items[i].id,
                      productsData.items[i].title,
                      productsData.items[i].imageUrl,
                      productsData.items[i].userId,
                      productsData.items[i].category,

                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}