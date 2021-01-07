import 'package:channel_pricing/screens/channels.dart';
import 'package:channel_pricing/screens/download.dart';
import 'package:channel_pricing/screens/packages.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:channel_pricing/widgets/app_divider.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppDrawer extends StatefulWidget {
  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  _openPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=io.epix.channel_pricing';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _shareApp() async {
    Share.share(
        'https://play.google.com/store/apps/details?id=io.epix.channel_pricing',
        subject:
            'Share the Application - TRAI Channel and Package Pricing Information');
  }

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
                MaterialPageRoute(builder: (ctxt) => PackagesScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Downloads'),
            leading: Icon(Icons.download_sharp),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctxt) => DownloadScreen()),
              );
            },
          ),
          CustomDivider(),
          ListTile(
            title: Text('Share App'),
            leading: Icon(Icons.share),
            onTap: () {
              Navigator.pop(context);
              _shareApp();
            },
          ),
          // ListTile(
          //   title: Text('Rate Us'),
          //   leading: Icon(Icons.star),
          //   onTap: () {
          //     Navigator.pop(context);
          //     _openPlayStore();
          //   },
          // ),
        ],
      ),
    );
  }
}
