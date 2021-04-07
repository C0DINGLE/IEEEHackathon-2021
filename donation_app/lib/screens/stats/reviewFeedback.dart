import 'package:flutter/material.dart';
import './topReviews.dart';
import './donationReview.dart';

class ReviewFeedback extends StatefulWidget {
  @override
  _ReviewFeedbackState createState() => _ReviewFeedbackState();
}

class _ReviewFeedbackState extends State<ReviewFeedback> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child:AppBar(
        bottom: TabBar(
            unselectedLabelColor: Colors.grey[400],
            labelColor: Colors.white,
            labelPadding: EdgeInsets.all(0),
            
            indicatorColor: Colors.white,
            tabs: [
            new Tab(
              icon: new Icon(Icons.feedback),
              text: "Top Reviews",
            ),
            new Tab(
              icon: new Icon(Icons.rate_review),
              text: "Your Donations",
            ),
          ],
          controller: _tabController,
          ),
        ),
      ),
      
      body: TabBarView(

        children: [
          TopReviews(),

          DonationReview(),
      ],
      controller: _tabController,
      ),
    );
  }
}