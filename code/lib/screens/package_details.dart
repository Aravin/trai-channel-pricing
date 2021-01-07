import 'package:channel_pricing/shared/constants.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

class PackageDetailScreen extends StatelessWidget {
  final String network;
  final String packageName;
  final num packPrice;
  final Map<String, num> channelList;

  const PackageDetailScreen(
      {this.network, this.packageName, this.packPrice, this.channelList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '$packageName'.text.bold.maxLines(2).ellipsis.make(),
      ),
      body: Padding(
        padding: kAppPadding,
        child: Column(
          children: [
            '$network'.text.purple700.xl2.make(),
            HeightBox(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                'Package Cost: ₹ $packPrice'.text.green500.bold.make(),
                'Channels: ${channelList.length}'.text.green500.bold.make(),
              ],
            ),
            HeightBox(20.0),
            Expanded(
              child: ListView.builder(
                itemCount: channelList.length,
                itemBuilder: (_c, j) {
                  return Card(
                    child: ListTile(
                      title: channelList.entries
                          .elementAt(j)
                          .key
                          .toString()
                          .text
                          .xl
                          .make(),
                      trailing:
                          '₹ ${channelList.entries.elementAt(j).value.toString()}'
                              .text
                              .bold
                              .red500
                              .lineThrough
                              .make(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
