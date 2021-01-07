import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:velocity_x/velocity_x.dart";

class DownloadScreen extends StatelessWidget {
  _openFile(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Downloads'.text.bold.make(),
      ),
      body: Padding(
        padding: kAppPadding,
        child: ListView(
          children: [
            Card(
              child: Container(
                padding: kContentPadding,
                child: Column(
                  children: [
                    'Free Channel List'.text.lg.bold.center.make(),
                    HeightBox(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: kTertiaryColor,
                          child: 'PDF'.text.bold.white.make(),
                          onPressed: () {
                            _openFile(
                                'https://drive.google.com/file/d/1IgBvwGCEhunYt0cbscR_bmQsEkO--kV2/view?usp=sharing');
                          },
                        ),
                        RaisedButton(
                          color: kPrimaryColor,
                          child: 'Excel'.text.bold.white.make(),
                          onPressed: () {
                            _openFile(
                                'https://drive.google.com/file/d/1pJsm9igKvpB4D3LXzsciP57qLaWp4E-1/view?usp=sharing');
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: kAppPadding,
                child: Column(
                  children: [
                    'Paid Channel List'.text.lg.bold.center.make(),
                    HeightBox(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: kTertiaryColor,
                          child: 'PDF'.text.bold.white.make(),
                          onPressed: () {
                            _openFile(
                                'https://drive.google.com/file/d/1QJc_nS-ATmq6SnkO85Mdz3L8HXsP7Iu_/view?usp=sharing');
                          },
                        ),
                        RaisedButton(
                          color: kPrimaryColor,
                          child: 'Excel'.text.bold.white.make(),
                          onPressed: () {
                            _openFile(
                                'https://drive.google.com/file/d/1opKeMLFAOsHDYA3dwxaIPZ3jv9c-d6Do/view?usp=sharing');
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: kAppPadding,
                child: Column(
                  children: [
                    'Broadcaster Packages List'.text.lg.bold.center.make(),
                    HeightBox(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: kTertiaryColor,
                          child: 'PDF'.text.bold.white.make(),
                          onPressed: () {
                            _openFile(
                                'https://drive.google.com/file/d/1fSQ-Kw32LHZLfjeYrR4gT7GovjCXVcTr/view?usp=sharing');
                          },
                        ),
                        RaisedButton(
                          color: kPrimaryColor,
                          child: 'Excel'.text.bold.white.make(),
                          onPressed: () {
                            _openFile(
                                'https://drive.google.com/file/d/1O7wrBFSXlq7a89qgTuP8g2zU58VRTezW/view?usp=sharing');
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: kAppPadding,
                child: Column(
                  children: [
                    'TRAI Suggested Packages List'.text.lg.bold.center.make(),
                    HeightBox(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: kTertiaryColor,
                          child: 'PDF'.text.bold.white.make(),
                          onPressed: () {
                            _openFile(
                                'https://drive.google.com/file/d/16AFOXaIk2goi1QbDcvR0_qQgugK8sxcs/view?usp=sharing');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
