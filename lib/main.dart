import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'MyHomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'X Wheel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.acmeTextTheme().copyWith(
            button: GoogleFonts.ubuntuMono(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
      ),
      home: MyHomePage(),
      //       // home: SecondScreen(),
      //home: Test(),
    );
  }
}
