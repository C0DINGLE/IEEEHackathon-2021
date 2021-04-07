import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import '../../providers/cart.dart' show Box;
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/cart_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../providers/orders.dart';
import './schedulePickup.dart';
import './animateBox.dart';

class BoxScreen extends StatelessWidget {
  static const routeName = '/box';
  @override
  Widget build(BuildContext context) {
    final box = Provider.of<Box>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Your Box', style: TextStyle(color: Colors.grey, fontSize: 17),),
        centerTitle: true,
      ),
      body: box.itemCount == 0 
        ? Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("No Donations Added to Box!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                Container(
                  width: 260, 
                  height: 215,
                  child: SvgPicture.asset('assets/images/emptyBox.svg', fit: BoxFit.cover,)
                  ),
              ],
            ),
        )  
        
        : Column(
          children: <Widget>[
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => BoxItem(
                    box.items.values.toList()[i].id,
                    box.items.keys.toList()[i],
                    box.items.values.toList()[i].title,
                    box.items.values.toList()[i].quantity,
                    box.items.values.toList()[i].imageUrl,),
                itemCount: box.itemCount,
              ),
            ),

            SizedBox(height: 40),

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

                  icon: Icon(Icons.schedule, color: Colors.white,),
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrder(box.items.values.toList());
                
                    Alert(
                      style: AlertStyle(
                        titleTextAlign: TextAlign.center,
                        animationType: AnimationType.fromBottom,
                        isOverlayTapDismiss: false,
                        isCloseButton: true,
                        alertPadding: EdgeInsets.fromLTRB(20, 230, 20, 90),
                        buttonAreaPadding: EdgeInsets.all(10),
                        animationDuration: Duration(milliseconds: 400),
                        alertElevation: 0,
                        overlayColor: Color.fromRGBO(255, 255, 255, 0.5),
                        alertBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                        titleStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 0.6,
                          color: Colors.black,
                        ),
                        alertAlignment: Alignment.topCenter,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        isButtonVisible: true,
                      ),
                        context: context,
                        title: "Confirm Your Pickup!",
                        content: PickupDetails(),
                        buttons: [
                          DialogButton(     
                            margin: EdgeInsets.symmetric(horizontal: 10),                       
                            color: Theme.of(context).accentColor,
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AnimateBox()));
                            },
                            child: Text(
                              "Confirm Schedule",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ]
                    ).show();
                  
                  },                  
                  
                  label: Text('Schedule Pickup', style: TextStyle(fontSize: 18, letterSpacing: 0.6, )),
                  textColor: Colors.white,
                ),
              ),
          ),
          ],
        ),
    );
  }
}
