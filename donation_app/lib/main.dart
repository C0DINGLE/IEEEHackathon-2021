import 'package:flutter/material.dart';

import 'package:splashscreen/splashscreen.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './services/auth.dart';

import './providers/requests.dart';
import './screens/add/wrapper.dart';
import './screens/authentication/wrapper.dart';
import './screens/home/home.dart';
import './screens/categories/categories.dart';
import './screens/stats/reviewFeedback.dart';

import './widgets/badge.dart';
import './screens/add/donation_product_detail.dart';
import './providers/products.dart';
import './screens/add/box_screen.dart';
import './providers/orders.dart';
import './screens/add/donations_screen.dart';
import 'providers/cart.dart';
import './services/calls_and_messages_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => print("CONNECTED to FIREBASE"));
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Requests(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Box(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iAid',
        theme: ThemeData(
        primaryColor: Color.fromARGB(255, 22, 149, 138),
        accentColor: Color.fromARGB(255, 27, 164, 215),
        fontFamily: 'Montserrat',
        ),            
        home: LaunchScreen(),
        routes: {
          ProductDetail.routeName: (ctx) => ProductDetail(),
          BoxScreen.routeName: (ctx) => BoxScreen(),
          DonationsScreen.routeName: (ctx) => DonationsScreen(),
          //EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new MyHomePage(),
      title: Text('iAid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,), textScaleFactor: 3.5,),
      gradientBackground: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color.fromARGB(200, 27, 250, 220), Color.fromARGB(255, 41, 190, 168),Color.fromARGB(255, 41, 150, 178) ],
      ),
      image: Image.asset('assets/images/launchLogo.png'),
      useLoader: false,
      loadingText: Text('Smiles Around the Corner', textScaleFactor: 1.2 , style: TextStyle(letterSpacing: 0.6, color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
      photoSize: 65.0,
      loaderColor: Colors.white,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      
      // At index 0
      HomeScreen(),

      // Top feedbacks / reviews
      ReviewFeedback(),

      // ADD Donation Screen
      StreamProvider<User>.value(
        value: AuthService().user,
        child: WrapperAdd(),
      ),

      // Categories Section
      Categories(),

      // At index 4: ACCOUNT SECTION
      StreamProvider<User>.value(
        value: AuthService().user,
        child: WrapperAccount(),
      ),

    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Image.asset('assets/images/logoText.png', fit: BoxFit.cover, height: 28,),
        actions: [
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

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[300],
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Color.fromARGB(255, 22, 149, 138),
        selectedFontSize: 10,
        unselectedFontSize: 9.5,
        // showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: "STATS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 45,),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "CATEGORY",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "ACCOUNT",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
