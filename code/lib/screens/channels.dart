import 'package:channel_pricing/screens/all_channels.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:channel_pricing/widgets/app_divider.dart';
import 'package:channel_pricing/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

import "package:velocity_x/velocity_x.dart";

class ChannelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Channel List'.text.bold.make(),
      ),
      drawer: CustomAppDrawer(),
      body: Padding(
        padding: kAppPadding,
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GestureDetector(
              child: Card(
                color: kPrimaryBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'All Channels'.text.xl.bold.makeCentered(),
                    CustomDivider(),
                    '892 Channels'.text.makeCentered()
                  ],
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctxt) => AllChannelScreen(screen: 'All')),
                )
              },
            ),
            GestureDetector(
              child: Card(
                color: kPrimaryBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'Paid Channels'.text.xl.bold.makeCentered(),
                    CustomDivider(),
                    '332 Channels'.text.makeCentered()
                  ],
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctxt) => AllChannelScreen(screen: 'Paid')),
                )
              },
            ),
            GestureDetector(
              child: Card(
                color: kPrimaryBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'Free Channels'.text.xl.bold.makeCentered(),
                    CustomDivider(),
                    '561 Channels'.text.makeCentered()
                  ],
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctxt) => AllChannelScreen(screen: 'Free')),
                )
              },
            ),
            GestureDetector(
              child: Card(
                color: kPrimaryBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'HD Channels'.text.xl.bold.makeCentered(),
                    CustomDivider(),
                    '98 Channels'.text.makeCentered()
                  ],
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctxt) => AllChannelScreen(screen: 'HD')),
                )
              },
            ),
            GestureDetector(
              child: Card(
                color: kPrimaryBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'SD Channels'.text.xl.bold.makeCentered(),
                    CustomDivider(),
                    '794 Channels'.text.makeCentered()
                  ],
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctxt) => AllChannelScreen(screen: 'SD')),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
