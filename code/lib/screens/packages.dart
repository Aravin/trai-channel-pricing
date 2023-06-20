import 'package:channel_pricing/data/networks.dart';
import 'package:channel_pricing/screens/package_list.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:channel_pricing/widgets/app_divider_small.dart';
import 'package:channel_pricing/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

import "package:velocity_x/velocity_x.dart";

class PackagesScreen extends StatelessWidget {
  final List<Map<String, Object>> networkData = networks;

  @override
  Widget build(BuildContext context) {
    print(['ara', networkData.length]);
    return Scaffold(
      appBar: AppBar(
        title: 'Package List'.text.bold.make(),
      ),
      drawer: CustomAppDrawer(),
      body: Padding(
        padding: kAppPadding,
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            networkData.length,
            (i) {
              return GestureDetector(
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 8,
                          child: networkData[i]['logo'] != ''
                              ? Container(
                                  padding: kImagePadding,
                                  child: Image.asset(
                                    'assets/networks/${networkData[i]['logo']}',
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Icon(
                                  Icons.card_giftcard_outlined,
                                  color: kPrimaryColor,
                                  size: 45.0,
                                )),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            '${networkData[i]['networks']}'
                                .text
                                .lg
                                .bold
                                .softWrap(false)
                                .ellipsis
                                .center
                                .make(),
                            CustomDividerSmall(),
                            '${networkData[i]['packages']} Package'
                                .text
                                .makeCentered()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctxt) => PackageListScreen(
                          screen: networkData[i]['id'] as String),
                    ),
                  )
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
