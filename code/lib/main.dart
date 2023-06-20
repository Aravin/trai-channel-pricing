import 'package:admob_flutter/admob_flutter.dart';
import 'package:channel_pricing/screens/channels.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(Main());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRAI - DTH Channel Pricing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: kPrimaryColor,
        // accentColor: kSecondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Nunito Sans',
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          headlineMedium:
              TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18.0),
          bodyMedium: TextStyle(fontSize: 16.0),
          titleMedium: TextStyle(fontSize: 18.0),
          titleSmall: TextStyle(fontSize: 16.0),
          labelLarge: TextStyle(fontSize: 16.0),
          labelSmall: TextStyle(fontSize: 16.0),
          bodySmall: TextStyle(fontSize: 14.0),
        ),
      ),
      home: ChannelsScreen(),
    );
  }
}
