import 'dart:async';

import 'package:channel_pricing/models/channels.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:channel_pricing/shared/text_ellipsis.dart';
import 'package:channel_pricing/data/channels.dart';
import 'package:channel_pricing/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:smart_select/smart_select.dart';

class FreeChannelScreen extends StatefulWidget {
  @override
  _FreeChannelScreenState createState() => _FreeChannelScreenState();
}

class _FreeChannelScreenState extends State<FreeChannelScreen> {
  TextEditingController _controller = TextEditingController();
  StreamController<List<Channel>> _channelStream =
      StreamController<List<Channel>>();
  String langValue = 'All';
  String channelValue = '';
  int totalChannel = 0;
  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'All', title: 'All'),
    S2Choice<String>(value: 'Assamese', title: 'Assamese'),
    S2Choice<String>(value: 'Bangla', title: 'Bangla'),
    S2Choice<String>(value: 'Bhojpuri', title: 'Bhojpuri'),
    S2Choice<String>(value: 'English', title: 'English'),
    S2Choice<String>(value: 'Gujarati', title: 'Gujarati'),
    S2Choice<String>(value: 'Hindi', title: 'Hindi'),
    S2Choice<String>(value: 'Japanese', title: 'Japanese'),
    S2Choice<String>(value: 'Kannada', title: 'Kannada'),
    S2Choice<String>(value: 'Malayalam', title: 'Malayalam'),
    S2Choice<String>(value: 'Marathi', title: 'Marathi'),
    S2Choice<String>(value: 'Odia', title: 'Odia'),
    S2Choice<String>(value: 'Oriya', title: 'Oriya'),
    S2Choice<String>(value: 'Punjabi', title: 'Punjabi'),
    S2Choice<String>(value: 'Tamil', title: 'Tamil'),
    S2Choice<String>(value: 'Telugu', title: 'Telugu'),
    S2Choice<String>(value: 'Urdu', title: 'Urdu'),
  ];

  void getChannels(String channelName, String langFilter) async {
    List<Channel> channelList = [];
    List<Map<String, dynamic>> channelData = channels;

    for (var item in channelData) {
      if (double.parse(item['cost'].toString()) != 0.0) {
        continue;
      }
      if ((channelName != null &&
              item['channelName']
                      .toString()
                      .toLowerCase()
                      .indexOf(channelName.toLowerCase()) ==
                  -1) ||
          ((langFilter != null && langFilter != 'All Language') &&
              item['lang']
                      .toString()
                      .toLowerCase()
                      .indexOf(langFilter.toLowerCase()) ==
                  -1)) {
        continue;
      }

      Channel channel = Channel(
        id: item['sno'],
        name: item['channelName'],
        broadcaster: item['broadcaster'],
        lang: item['lang'],
        cost: double.parse(item['cost'].toString()),
        genre: item['genre'],
        streamType: item['streamType'],
        airtel: item['airtelChannelNum'],
        dishTv: item['dishTVChannelNum'],
        sunDirect: item['sunDirectChannelNum'],
        tataSky: item['tataSkyChannelNum'],
        d2h: item['d2hChannelNum'],
      );
      channelList.add(channel);
    }

    _channelStream.add(channelList);
    totalChannel = channelList?.length;
  }

  void initState() {
    super.initState();
    _controller = TextEditingController();
    getChannels(null, null);
  }

  void dispose() {
    _controller.dispose();
    _channelStream.close();
    _channelStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Free Channels ($totalChannel)'.text.extraBold.make(),
      ),
      drawer: CustomAppDrawer(),
      body: Padding(
        padding: kAppPadding,
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: StreamBuilder<List<Channel>>(
                stream: _channelStream.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Channel>> snapshot) {
                  if (snapshot.hasData && snapshot.data.length == 0) {
                    return 'No Channels Found'.text.xl2.makeCentered();
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          margin: kBoxMargin,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: kSecondaryDarkColor,
                          ),
                          padding: kContentPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  '${truncateWithEllipsis(15, snapshot.data[i].name)}'
                                      .text
                                      .xl
                                      .bold
                                      .white
                                      .softWrap(false)
                                      .ellipsis
                                      .maxLines(1)
                                      .make(),
                                  '${truncateWithEllipsis(15, snapshot.data[i].lang)}'
                                      .text
                                      .xl
                                      .bold
                                      .white
                                      .softWrap(false)
                                      .ellipsis
                                      .maxLines(1)
                                      .make(),
                                ],
                              ),
                              HeightBox(5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  'Genre: ${snapshot.data[i].genre == '' ? 'NA' : snapshot.data[i].genre}'
                                      .text
                                      .lg
                                      .bold
                                      .white
                                      .softWrap(false)
                                      .ellipsis
                                      .maxLines(1)
                                      .make(),
                                  'Cost: Rs.${snapshot.data[i].cost}'
                                      .text
                                      .lg
                                      .bold
                                      .white
                                      .softWrap(false)
                                      .ellipsis
                                      .maxLines(1)
                                      .make(),
                                ],
                              ),
                              HeightBox(5.0),
                              '${truncateWithEllipsis(40, snapshot.data[i].broadcaster)}'
                                  .text
                                  .white
                                  .softWrap(false)
                                  .ellipsis
                                  .maxLines(1)
                                  .make(),
                            ],
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
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search Channel',
                        suffixIcon: Icon(Icons.search_outlined),
                      ),
                      onChanged: (String value) async {
                        setState(() {
                          channelValue = value;
                        });
                        getChannels(value, langValue);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: SmartSelect<String>.single(
                      title: '',
                      value: langValue,
                      choiceItems: options,
                      onChange: (state) => setState(() {
                        langValue = state.value;
                        getChannels(channelValue, langValue);
                      }),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
