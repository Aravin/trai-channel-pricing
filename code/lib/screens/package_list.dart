import 'dart:async';

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
  const PackageListScreen({Key key, this.screen}) : super(key: key);

  @override
  _PackageListScreenState createState() => _PackageListScreenState();

  final String screen;
}

class _PackageListScreenState extends State<PackageListScreen> {
  StreamController<List<Package>> _packageStream =
      StreamController<List<Package>>();
  List<Map<String, dynamic>> packData = List.from(discovery['packages']);
  String packNetwork = discovery['broadcaster'];
  List<Package> _packageList = [];
  int _totalPackage = 0;

  void getPackages() async {
    switch (widget.screen) {
      case 'discovery':
        packData = List.from(discovery['packages']);
        packNetwork = discovery['broadcaster'];
        break;
      case 'etv':
        packData = List.from(etv['packages']);
        packNetwork = etv['broadcaster'];
        break;
      case 'mavis':
        packData = List.from(mavis['packages']);
        packNetwork = mavis['broadcaster'];
        break;
      case 'ndtv':
        packData = List.from(ndtv['packages']);
        packNetwork = ndtv['broadcaster'];
        break;
      case 'odisha':
        packData = List.from(odisha['packages']);
        packNetwork = odisha['broadcaster'];
        break;
      case 'raj':
        packData = List.from(raj['packages']);
        packNetwork = raj['broadcaster'];
        break;
      case 'silverstar':
        packData = List.from(silverstar['packages']);
        packNetwork = silverstar['broadcaster'];
        break;
      case 'sony':
        packData = List.from(sony['packages']);
        packNetwork = sony['broadcaster'];
        break;
      case 'times':
        packData = List.from(times['packages']);
        packNetwork = times['broadcaster'];
        break;
      case 'turner':
        packData = List.from(turner['packages']);
        packNetwork = turner['broadcaster'];
        break;
      case 'tvtoday':
        packData = List.from(tvtoday['packages']);
        packNetwork = tvtoday['broadcaster'];
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
    _totalPackage = _packageList?.length;
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
              if (snapshot.hasData && snapshot.data.length == 0) {
                return 'No Packages Found'.text.xl2.makeCentered();
              } else if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: GestureDetector(
                        child: Container(
                          padding: kContentPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              '${snapshot.data[i].name}'
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
                                  '${snapshot.data[i].channels.length} Channels'
                                      .text
                                      .lg
                                      .bold
                                      .gray600
                                      .softWrap(false)
                                      .ellipsis
                                      .maxLines(1)
                                      .make(),
                                  '₹ ${snapshot.data[i].price}'
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
                                      packageName: snapshot.data[i].name,
                                      packPrice: snapshot.data[i].price,
                                      channelList: snapshot.data[i].channels,
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
