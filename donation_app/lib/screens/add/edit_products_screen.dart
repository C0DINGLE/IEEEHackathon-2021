import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:geocoder/geocoder.dart';

import '../../main.dart';
import '../../shared/loading.dart';
import '../../providers/product.dart';
import '../../providers/products.dart';

// import './donation_products_screen.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  final String selectedCategory;

  EditProductScreen(this.selectedCategory);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Position _currentPosition;
  StreamSubscription<Position> _positionStream;
  var _currentAddress;

  String itemPos;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    quantity: 0,
    description: '',
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;
  var checkedVal = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    _positionStream = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      setState(() {
        //print(position);
        _currentPosition = position;
        final coordinates =
            Coordinates(_currentPosition.latitude, _currentPosition.longitude);
        //final coordinates = Coordinates(27.8974,78.0880);
        _getAddressFromLatLng(coordinates)
            .then((value) => _currentAddress = value);
      });
    });
    super.initState();
  }

  // @override
  // void initState() {

  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findId(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'quantity': _editedProduct.quantity.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _getAddressFromLatLng(Coordinates x) async {
    try {
      _currentAddress = await Geocoder.local.findAddressesFromCoordinates(x);
      var first = _currentAddress.first;
      //_getAddressString(first);
      itemPos = first.addressLine;
      //print("${first.featureName} : ${first.addressLine}");
    } catch (error) {
      throw error;
    }
  }
  // _getAddressString() {

  // }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _positionStream.cancel();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
    } else {
      await Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,
        );
      });
    }
  }

  bool newVal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 16,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Donation Details',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.location_pin,
              color: Colors.green,
            ),
            onPressed: () {
              setState(() {
                _editedProduct.location = itemPos;
              });
              print(_editedProduct.location);
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveForm,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: Loading())
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                              prefixIcon: Icon(
                                Icons.image,
                                size: 20,
                              ),
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                quantity: _editedProduct.quantity,
                                description: _editedProduct.description,
                                imageUrl: value,
                                id: _editedProduct.id,
                                userId: _editedProduct.userId,
                                category: widget.selectedCategory,
                                isDonated: _editedProduct.isDonated,
                                updates: _editedProduct.updates,
                                location: _editedProduct.location,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: widget.selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        // labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        prefixIcon: Icon(Icons.category,
                            size: 20, color: Theme.of(context).accentColor),
                      ),
                      enabled: false,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                        prefixIcon: Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value,
                          quantity: _editedProduct.quantity,
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          userId: _editedProduct.userId,
                          category: widget.selectedCategory,
                          isDonated: _editedProduct.isDonated,
                          updates: _editedProduct.updates,
                          location: _editedProduct.location,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _initValues['quantity'],
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        prefixIcon: Icon(
                          Icons.format_list_numbered_rtl,
                          size: 20,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          quantity: int.parse(value),
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          userId: _editedProduct.userId,
                          category: widget.selectedCategory,
                          isDonated: _editedProduct.isDonated,
                          updates: _editedProduct.updates,
                          location: _editedProduct.location,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(
                          Icons.description,
                          size: 20,
                        ),
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          quantity: _editedProduct.quantity,
                          description: value,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          userId: _editedProduct.userId,
                          category: widget.selectedCategory,
                          isDonated: _editedProduct.isDonated,
                          updates: _editedProduct.updates,
                          location: _editedProduct.location,
                        );
                      },
                    ),
                    CheckboxListTile(
                      activeColor: Colors.black12,
                      checkColor: Colors.green,
                      value: checkedVal,
                      onChanged: (newVal) {
                        setState(() {
                          checkedVal = newVal;
                          if (_editedProduct.updates == true) {
                            _editedProduct.updates = false;
                          } else {
                            _editedProduct.updates = true;
                          }
                          newVal = false;
                          //_saveForm();
                        });
                      },
                      title: Text(
                        'Do you wish to recieve updates about this donation?',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(12),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
