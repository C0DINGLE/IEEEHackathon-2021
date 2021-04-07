import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/orders.dart' show Orders;
import '../../widgets/donation_item.dart';

class DonationsScreen extends StatelessWidget {
  static const routeName = '/donations';

  @override
  Widget build(BuildContext context) {
    final donations = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Donations'),
      ),
      body: ListView.builder(
        itemCount: donations.orders.length,
        itemBuilder: (ctx, i) => DonationItem(donations.orders[i]),
      ),
    );
  }
}
