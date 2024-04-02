import 'package:authentication/firebase_options.dart';
import 'package:authentication/model/device_model.dart';
import 'package:authentication/screens/device_list_screen.dart';
import 'package:authentication/screens/home_screen.dart';
import 'package:authentication/screens/login_email_password_screen.dart';
import 'package:authentication/screens/login_screen.dart';
import 'package:authentication/screens/phone_screen.dart';
import 'package:authentication/screens/signup_email_password_screen.dart';
import 'package:authentication/services/data_service.dart';
import 'package:authentication/services/firebase_auth_methods.dart';
import 'package:authentication/viewmodel/device_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: '302880489138808',
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(),
        ),
        ChangeNotifierProvider<DeviceViewModel>(
          create: (_) => DeviceViewModel(),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CompAsia',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWrapper(),
        routes: {
          EmailPasswordLogin.routeName: (context) => EmailPasswordLogin(),
          EmailPasswordSignup.routeName: (context) => EmailPasswordSignup(),
          PhoneScreen.routeName: (context) => PhoneScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          BottomNavBar.routeName: (context) => BottomNavBar(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return BottomNavBar();
    }
    return EmailPasswordLogin();
  }
}

class BottomNavBar extends StatefulWidget {
  static String routeName = '/tabs';
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DeviceListScreen(),
    HomeScreen(), // Placeholder for Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
