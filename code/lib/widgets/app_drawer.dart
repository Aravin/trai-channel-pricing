import 'package:channel_pricing/screens/channels.dart';
import 'package:channel_pricing/screens/free_channels.dart';
import 'package:channel_pricing/screens/paid_channels.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

class CustomAppDrawer extends StatefulWidget {
  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: 'Menu'.text.xl3.bold.white.make(),
            decoration: BoxDecoration(
              color: kSecondaryDarkColor,
            ),
          ),
          ListTile(
            title: Text('Channels'),
            leading: Icon(Icons.live_tv_sharp),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctxt) => ChannelsScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Packages'),
            leading: Icon(Icons.card_giftcard),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctxt) => ChannelsScreen()),
              );
            },
          ),
          Divider(),
          // ListTile(
          //   title: Text('Free Channels'),
          //   leading: Icon(Icons.tv),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (ctxt) => FreeChannelScreen()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
