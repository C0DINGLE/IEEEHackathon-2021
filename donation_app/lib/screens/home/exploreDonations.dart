import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products.dart';
import '../../shared/loading.dart';
import '../../screens/add/donation_product_detail.dart';

class ExploreDonations extends StatefulWidget {

  @override
  _ExploreDonationsState createState() => _ExploreDonationsState();
}

class _ExploreDonationsState extends State<ExploreDonations> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
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
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    final int listCount =  products.length <= 4 ? products.length : 4;

    return _isLoading 
      ? Loading() 
      : Container(
      margin: EdgeInsets.symmetric(vertical: 13),
      height: MediaQuery.of(context).size.height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (cntxt, index){
          return Card(
            margin: EdgeInsets.only(right: 15),
            elevation: 3,
            child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: (){
                  Navigator.of(context).pushNamed(
                  ProductDetail.routeName,
                  arguments: products[index].id,
                );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.5,
                          color: Colors.white,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.38,
                      height: MediaQuery.of(context).size.height * 0.18,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Image.network(
                        products[index].imageUrl,
                        fit: BoxFit.fitHeight,
                      ),
                      // height: 100.0,
                      // child: Text(categoriesAvailable[index]),
                    ),
                    Text('view', style: TextStyle(fontFamily: 'Roboto', fontSize: 13.5)),
                  ],
                ),
              )
          );
        },
        itemCount: listCount,    
      ),
      );
  }
}