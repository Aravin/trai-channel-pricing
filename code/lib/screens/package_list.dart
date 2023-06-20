import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:channel_pricing/models/package.dart';
import 'package:channel_pricing/screens/package_details.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

// data
import 'package:channel_pricing/data/packages/discovery.dart';
import 'package:channel_pricing/data/packages/etv.dart';
import 'package:channel_pricing/data/packages/mavis.dart';
import 'package:channel_pricing/data/packages/ndtv.dart';
import 'package:channel_pricing/data/packages/odisha.dart';
import 'package:channel_pricing/data/packages/raj.dart';
import 'package:channel_pricing/data/packages/silverstar.dart';
import 'package:channel_pricing/data/packages/sony.dart';
import 'package:channel_pricing/data/packages/times.dart';
import 'package:channel_pricing/data/packages/turner.dart';
import 'package:channel_pricing/data/packages/tvtoday.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({Key? key, required this.screen}) : super(key: key);

  @override
  _PackageListScreenState createState() => _PackageListScreenState();

  final String screen;
}

class _PackageListScreenState extends State<PackageListScreen> {
  StreamController<List<Package>> _packageStream =
      StreamController<List<Package>>();
  List<Map<String, dynamic>> packData =
      List.from(discovery['packages'] as Iterable<String>);
  String packNetwork = discovery['broadcaster'] as String;
  List<Package> _packageList = [];
  int _totalPackage = 0;

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2191548178499350/3728607813';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2191548178499350/3728607813';
    }
    return null;
  }

  void getPackages() async {
    switch (widget.screen) {
      case 'discovery':
        packData = List.from(discovery['packages'] as Iterable<String>);
        packNetwork = discovery['broadcaster'] as String;
        break;
      case 'etv':
        packData = List.from(etv['packages'] as Iterable<String>);
        packNetwork = etv['broadcaster'] as String;
        break;
      case 'mavis':
        packData = List.from(mavis['packages'] as Iterable<String>);
        packNetwork = mavis['broadcaster'] as String;
        break;
      case 'ndtv':
        packData = List.from(ndtv['packages'] as Iterable<String>);
        packNetwork = ndtv['broadcaster'] as String;
        break;
      case 'odisha':
        packData = List.from(odisha['packages'] as Iterable<String>);
        packNetwork = odisha['broadcaster'] as String;
        break;
      case 'raj':
        packData = List.from(raj['packages'] as Iterable<String>);
        packNetwork = raj['broadcaster'] as String;
        break;
      case 'silverstar':
        packData = List.from(silverstar['packages'] as Iterable<String>);
        packNetwork = silverstar['broadcaster'] as String;
        break;
      case 'sony':
        packData = List.from(sony['packages'] as Iterable<String>);
        packNetwork = sony['broadcaster'] as String;
        break;
      case 'times':
        packData = List.from(times['packages'] as Iterable<String>);
        packNetwork = times['broadcaster'] as String;
        break;
      case 'turner':
        packData = List.from(turner['packages'] as Iterable<String>);
        packNetwork = turner['broadcaster'] as String;
        break;
      case 'tvtoday':
        packData = List.from(tvtoday['packages'] as Iterable<String>);
        packNetwork = tvtoday['broadcaster'] as String;
        break;
    }
    for (var i in packData) {
      Package pkg = Package(
          name: i['name'],
          price: double.parse(i['price'].toString()),
          channels: i['channels']);
      _packageList.add(pkg);
    }

    _packageStream.add(_packageList);
    _totalPackage = _packageList.length;
  }

  void initState() {
    super.initState();
    print(widget.screen);
    getPackages();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '$packNetwork ($_totalPackage Package)'.text.bold.center.make(),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: kContentPadding,
        child: Container(
          child: StreamBuilder<List<Package>>(
            stream: _packageStream.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Package>> snapshot) {
              if (snapshot.hasData && snapshot.data!.length == 0) {
                return 'No Packages Found'.text.xl2.makeCentered();
              } else if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (i != 0 && i % 10 == 0 || i == 1) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: AdmobBanner(
                            adUnitId: getBannerAdUnitId()!,
                            adSize: AdmobBannerSize.FULL_BANNER,
                            listener: (AdmobAdEvent event,
                                Map<String, dynamic>? args) {
                              // print([event, args, 'Banner']);
                            },
                            onBannerCreated:
                                (AdmobBannerController controller) {
                              // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                              // Normally you don't need to worry about disposing this yourself, it's handled.
                              // If you need direct access to dispose, this is your guy!
                              // controller.dispose();
                            },
                          ),
                        ),
                      );
                    }
                    return Card(
                      child: GestureDetector(
                        child: Container(
                          padding: kContentPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              '${snapshot.data![i].name}'
                                  .text
                                  .lg
                                  .bold
                                  .gray700
                                  .ellipsis
                                  .make(),
                              HeightBox(5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  '${snapshot.data![i].channels.length} Channels'
                                      .text
                                      .lg
                                      .bold
                                      .gray600
                                      .softWrap(false)
                                      .ellipsis
                                      .maxLines(1)
                                      .make(),
                                  '₹ ${snapshot.data![i].price}'
                                      .text
                                      .lg
                                      .bold
                                      .gray600
                                      .softWrap(false)
                                      .ellipsis
                                      .maxLines(1)
                                      .make(),
                                ],
                              ),
                              HeightBox(5.0),
                              '$packNetwork'
                                  .text
                                  .gray500
                                  .softWrap(false)
                                  .ellipsis
                                  .maxLines(1)
                                  .make(),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctxt) => PackageDetailScreen(
                                      network: this.packNetwork,
                                      packageName: snapshot.data![i].name,
                                      packPrice: snapshot.data![i].price,
                                      channelList: snapshot.data![i].channels,
                                    )),
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return snapshot.error.toString().text.makeCentered();
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
