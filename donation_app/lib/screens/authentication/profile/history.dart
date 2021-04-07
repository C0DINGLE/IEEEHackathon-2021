import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/loading.dart';
import '../../../providers/products.dart';
import '../../../widgets/user_product_item.dart';

class PastHistory extends StatefulWidget {
  @override
  _PastHistoryState createState() => _PastHistoryState();
}

class _PastHistoryState extends State<PastHistory> {
  var _isInit = true;
  var _isLoading = false;

  Future<void> _refreshProds(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchUserData();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //Provider.of<Products>(context).fetchUserData().then((_) {});
      Provider.of<Products>(context).fetchUserData().then((_) {
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
    final productsData = Provider.of<Products>(context).userProds;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Your Donations', style: TextStyle(color: Colors.grey, fontSize: 16),),
        centerTitle: true,
      ),

      body: RefreshIndicator(
            color: Colors.deepPurpleAccent,
              onRefresh: () => _refreshProds(context),
              child: productsData.isEmpty 
        ? Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("You've not donated anything!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                Container(
                  width: 260, 
                  height: 215,
                  child: SvgPicture.asset('assets/images/emptyBox.svg', fit: BoxFit.cover,)
                  ),
              ],
            ),
        )  
        
        :  _isLoading
          ? Center(child: Loading())
          : Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white70,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: ListView.builder(
                itemCount: productsData.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      productsData[i].id,
                      productsData[i].title,
                      productsData[i].imageUrl,
                      productsData[i].userId,
                      productsData[i].category,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
      )
    );
  }
}