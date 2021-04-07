import 'package:flutter/material.dart';
import '../../services/database.dart';
import '../../shared/loading.dart';
import '../../services/calls_and_messages_service.dart';

class DetailsRequest extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String volID;

  DetailsRequest(this.title, this.description, this.location, this.volID);
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: DatabaseService(uid: volID).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          var userData = snapshot.data;
          return Builder(
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(15),
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 17,
                        ),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Divider(color: Theme.of(context).accentColor, thickness: 1,),
                    
                    SizedBox(
                      height: 9,
                    ),

                    Row(
                      children: [
                        Icon(Icons.person, size: 18,),
                        Text(' Posted By: ', style: TextStyle(fontSize: 16, color: Colors.black),),
                        Text(userData['username'], style: TextStyle(fontSize: 16, letterSpacing: 0.6, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),),
                      ],
                    ),

                    // SizedBox(
                    //   height: 9,
                    // ),

                    Row(
                      children: [
                        Icon(Icons.call, size: 18,),
                        Text(' Contact No.: ', style: TextStyle(fontSize: 16, color: Colors.black),),
                        FlatButton(
                          onPressed: () => _service.call(userData['number']),
                          child: Text('+91 ${userData['number']}', style: TextStyle(fontSize: 16, letterSpacing: 0.6, fontWeight: FontWeight.bold, color: Colors.black),)),
                      ],
                    ),

                  ],
                ),
              );
            });
        }
        else {
            return Loading();
        }
      });
  }
}