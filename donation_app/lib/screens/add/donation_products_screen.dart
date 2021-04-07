import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/product_grid.dart';
import '../../widgets/badge.dart';
import '../../providers/cart.dart';
import '../../screens/add/box_screen.dart';
import '../../providers/products.dart';
import '../../shared/loading.dart';

enum FilterOptions {
  Wished,
  All,
}

class DonationProductScreen extends StatefulWidget {
  @override
  _DonationProductScreenState createState() => _DonationProductScreenState();
}

class _DonationProductScreenState extends State<DonationProductScreen> {
  var _showDonatedOnly = false;
  var _isInit = true;
  var _isLoading = false;

  Future<void> _refreshProds(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //Provider.of<Products>(context).fetchUserData().then((_) {});
      Provider.of<Products>(context).fetchData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 16,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15),
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              height: 28,
            ),
            SizedBox(width: 15),
            Text(
              "DONATIONS",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Wished) {
                  _showDonatedOnly = true;
                } else {
                  _showDonatedOnly = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Wished Donations'),
                value: FilterOptions.Wished,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
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
      body: _isLoading
          ? Center(child: Loading())
          : RefreshIndicator(
            color: Colors.deepPurpleAccent,
              onRefresh: () => _refreshProds(context),
              child: DonationsGrid(_showDonatedOnly)),
    );
  }
}
