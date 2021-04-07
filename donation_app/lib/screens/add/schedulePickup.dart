import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickupDetails extends StatefulWidget {
  @override
  _PickupDetailsState createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
  DateTime _chosenDate;

  // void _submitData(){
  // }

  void _openDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2022),
    ).then((value){
      if(value == null){
        return;
      }
      setState(() {
        _chosenDate = value;        
      });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        SizedBox(height:7),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible(
            //   fit: FlexFit.tight,
              // child: 
              Icon(Icons.location_on, size: 18, color: Theme.of(context).primaryColor,),
            // ),
            Text(" Sir Syed Nagar, Aligarh", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical:20),
          height: 30,
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  _chosenDate == null ? 'No Date Selected': 'Date: ${DateFormat.yMMMd().format(_chosenDate)}', 
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
              ),
              FlatButton(
                onPressed: _openDatePicker, 
                child: Text('Select Date', style: TextStyle(color: Theme.of(context).primaryColor),),
              )
            ],
          ),
        ),
      ],
    );
  }
}