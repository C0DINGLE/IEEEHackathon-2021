import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './box_screen.dart';
import '../../widgets/badge.dart';
import '../../providers/products.dart';
import '../../providers/cart.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  // final double quantity;

  // ProductDetail(this.title, this.quantity);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final box = Provider.of<Box>(context, listen: false);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findId(productId);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87, size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text("Donations", style: TextStyle(fontSize: 18, color: Colors.black),),
        actions: [
          Consumer<Box>(
            builder: (_, box, ch) => Badge(
              child: ch,
              value: box.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.brown[300],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(BoxScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(40.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      left: 20.0,
                      child: Container(
                        width: 200.0,
                        height: 400.0,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Container(
                      width: 300.0,
                      height: 400.0,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                            BoxShadow(
                              blurRadius: 1.0,
                              color: Colors.black45,
                              spreadRadius: 2.0, 
                            ),
                          ],
                        image: DecorationImage(
                          image: NetworkImage('${loadedProduct.imageUrl}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 320.0,
                      left: 15.0,
                      child: Container(
                        width: 270.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1.0,
                              color: Colors.black12,
                              spreadRadius: 2.0, 
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(7.0),
                          child: Center(
                            child: Text(
                            "${loadedProduct.title}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18.5,
                            ),
                        ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Details:', style: TextStyle(
                      fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18,
                    ),),
                    SizedBox(height:8),
                    Text(
                    "${loadedProduct.description}",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.5,
                    ),
                  ),
                  SizedBox(height:8),
                    Text(
                    "Quantity: ${loadedProduct.quantity}",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                    ),
                  ),
                  SizedBox(height:80),
                  ],
                ),
              ),              
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(top:3, bottom:3),
            width: double.infinity,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20),  
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 41, 213, 178), Color.fromARGB(255, 27, 164, 215)],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
              ),
            ),
            child: FlatButton.icon(
              icon: Icon(Icons.shopping_bag, color: Colors.white,),
              onPressed: () {

                box.addItem(loadedProduct.id, loadedProduct.title, loadedProduct.quantity,
                loadedProduct.imageUrl);
                
                Alert(
                   style: AlertStyle(
                     titleTextAlign: TextAlign.center,
                    animationType: AnimationType.fromBottom,
                    isOverlayTapDismiss: true,
                    isCloseButton: false,
                    alertPadding: EdgeInsets.fromLTRB(20, 280, 20, 90),
                    buttonAreaPadding: EdgeInsets.all(10),
                    animationDuration: Duration(milliseconds: 350),
                    alertElevation: 0,
                    overlayColor: Color.fromRGBO(255, 255, 255, 0.0),
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.grey[300],
                      ),
                    ),
                    titleStyle: TextStyle(
                      fontSize: 17,
                      letterSpacing: 0.6,
                      color: Colors.black,
                    ),
                    alertAlignment: Alignment.topCenter,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
                    isButtonVisible: false,
                  ),
                    context: context,
                    title: "Item added to Box!",
                ).show();
              },
              
              label: Text('Add to box', style: TextStyle(fontSize: 18, letterSpacing: 0.6, )),
              textColor: Colors.white,
            ),
          ),
      ),
    ]),
    );
  }
}
