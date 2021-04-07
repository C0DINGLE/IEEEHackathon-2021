import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/requests.dart';
import '../../shared/loading.dart';
import './detailsRequest.dart';

class HelpRequests extends StatefulWidget {
  @override
  _HelpRequestsState createState() => _HelpRequestsState();
}

class _HelpRequestsState extends State<HelpRequests> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Requests>(context).fetchData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshReqs(BuildContext context) async {
    await Provider.of<Requests>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final requestsData = Provider.of<Requests>(context);
    final _allRequests = requestsData.allRequests;
    
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
              "HELP REQUESTS",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshReqs(context),
        child: Container(
          margin: EdgeInsets.all(20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 80,
          child: _allRequests.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No Requests Added !!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: 220,
                        height: 250,
                        child: SvgPicture.asset(
                          'assets/images/noData.svg',
                          fit: BoxFit.scaleDown,
                        )),
                  ],
                )
              : _isLoading
                  ? Loading()
                  : ListView.builder(
                      // itemBuilder runs for every item in list
                      itemBuilder: (cntxt, index) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 15),
                          elevation: 6,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: Image.network(
                                      _allRequests[index].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        _allRequests[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).accentColor,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        'Qty: ${_allRequests[index].quantity}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.19,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  _allRequests[index].location,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                IconButton(
                                  color: Colors.black87,
                                  icon: FittedBox(
                                      child: Icon(Icons.chevron_right)),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DetailsRequest(
                                            _allRequests[index].title,
                                            _allRequests[index].description,
                                            _allRequests[index].location,
                                            _allRequests[index].volunteerId,
                                          );
                                        });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _allRequests.length,
                    ),
        ),
      ),
    );
  }
}
