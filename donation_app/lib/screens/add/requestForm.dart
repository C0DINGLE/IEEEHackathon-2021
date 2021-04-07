import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../../main.dart';
import '../../shared/loading.dart';
import '../../providers/request.dart';
import '../../providers/requests.dart';

class RequestsForm extends StatefulWidget {
  @override
  _RequestsFormState createState() => _RequestsFormState();
}

class _RequestsFormState extends State<RequestsForm> {
  final _form = GlobalKey<FormState>();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _quantityFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();

  var _editedRequest = Request(
    id: null,
    title: '',
    quantity: 0,
    description: '',
    imageUrl: '',
    location: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'quantity': '',
    'location': '',
    'imageUrl': '',
  };

  var _isInit = true;
  var _isLoading = false;
  
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedRequest =
            Provider.of<Requests>(context, listen: false).findId(productId);
        _initValues = {
          'title': _editedRequest.title,
          'description': _editedRequest.description,
          'quantity': _editedRequest.quantity.toString(),
          'location': _editedRequest.location,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedRequest.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _quantityFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
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
    if (_editedRequest.id != null) {
      Provider.of<Requests>(context, listen: false)
          .updateRequest(_editedRequest.id, _editedRequest);
      setState(() {
        _isLoading = false;
      });
    } else {
    await Provider.of<Requests>(context, listen: false)
          .addRequest(_editedRequest)
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
          'Request Details',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveForm,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
      body: 
      _isLoading
          ? Loading(): 
            Padding(
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
                            textInputAction: TextInputAction.next,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              
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
                              _editedRequest = Request(
                                title: _editedRequest.title,
                                quantity: _editedRequest.quantity,
                                location: _editedRequest.location,
                                description: _editedRequest.description,
                                imageUrl: value,
                                id: _editedRequest.id,
                                volunteerId: _editedRequest.volunteerId,
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
                        FocusScope.of(context).requestFocus(_quantityFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a valid title.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequest = Request(
                          title: value,
                          quantity: _editedRequest.quantity,
                          location: _editedRequest.location,
                          description: _editedRequest.description,
                          imageUrl: _editedRequest.imageUrl,
                          id: _editedRequest.id,
                          volunteerId: _editedRequest.volunteerId,
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
                      focusNode: _quantityFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_locationFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a quantity.';
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
                        _editedRequest = Request(
                          title: _editedRequest.title,
                          quantity: int.parse(value),
                          location: _editedRequest.location,
                          description: _editedRequest.description,
                          imageUrl: _editedRequest.imageUrl,
                          volunteerId: _editedRequest.volunteerId,
                          id: _editedRequest.id,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _initValues['location'],
                      decoration: InputDecoration(
                        labelText: 'Location',
                        prefixIcon: Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _locationFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a correct Location';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequest = Request(
                          title: _editedRequest.title,
                          quantity: _editedRequest.quantity,
                          location: (value),
                          description: _editedRequest.description,
                          imageUrl: _editedRequest.imageUrl,
                          id: _editedRequest.id,
                          volunteerId: _editedRequest.volunteerId,
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
                        _editedRequest = Request(
                          title: _editedRequest.title,
                          quantity: _editedRequest.quantity,
                          location: _editedRequest.location,
                          description: value,
                          imageUrl: _editedRequest.imageUrl,
                          id: _editedRequest.id,
                          volunteerId: _editedRequest.volunteerId,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}