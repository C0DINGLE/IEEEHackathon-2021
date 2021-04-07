import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopReviews extends StatelessWidget {

  final List _allReviews = [
    {
      'title': 'Now they have books',
      'image': 'assets/images/dummyData/reqBooks.jpg',
      'description': 'Course books for students of primary schools, helping them a lot',
      'donatedBy': 'testUser',
    },
    {
      'title': 'Winter Clothes helped them a lot',
      'image': 'assets/images/dummyData/reqClothes.jpg',
      'description': 'New or Old jackets for kids and some sweaters for old people during winters',
      'donatedBy': 'haaaziq',
    },
    {
      'title': 'Not sleeping hungry',
      'image': 'assets/images/dummyData/reqFood.jpg',
      'description': 'Ration distributed in nearby village helped them a lot during the lockdown',
      'donatedBy': 'ateeb10',
    },    
  ];


  @override
  Widget build(BuildContext context) {
    return _allReviews.isEmpty 
    ? Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom:10),
                width: 250, 
                height: 180,
                child: SvgPicture.asset('assets/images/noReviews.svg')
              ),
              SizedBox(height: 20,),
              Text('No feedbacks added yet!', style: TextStyle(color: Colors.black87, fontSize: 18), textAlign: TextAlign.center,),
            ],
            ),
          ],
        ),
      )
    : ListView.builder(
        // itemBuilder runs for every item in list
        itemBuilder: (cntxt, index){
          return Card(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 10),
            elevation: 6,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.40,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      margin: EdgeInsets.all(3),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Image.asset(_allReviews[index]['image'], fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9,),
                        Text(_allReviews[index]['title'], style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold, fontSize: 16),),
                        SizedBox(height: 9,),
                        Text('${_allReviews[index]['description']}', style: TextStyle(color: Colors.black),),
                        SizedBox(height: 9,),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.person, size: 16, color: Colors.grey),
                              Text(' ${_allReviews[index]['donatedBy']}', style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                ],
              ),
            ),
              );
            },
        itemCount: _allReviews.length,
        );
  }
}