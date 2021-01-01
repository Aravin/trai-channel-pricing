import 'package:channel_pricing/screens/channels.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';

void main() {
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
        accentColor: kSecondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Nunito Sans',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          headline4: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 18.0),
          bodyText2: TextStyle(fontSize: 16.0),
          subtitle1: TextStyle(fontSize: 18.0),
          subtitle2: TextStyle(fontSize: 16.0),
          button: TextStyle(fontSize: 16.0),
          overline: TextStyle(fontSize: 16.0),
          caption: TextStyle(fontSize: 14.0),
        ),
      ),
      home: ChannelsScreen(),
    );
  }
}
