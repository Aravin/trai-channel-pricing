import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:channel_pricing/models/channels.dart';
import 'package:channel_pricing/shared/constants.dart';
import 'package:channel_pricing/shared/text_ellipsis.dart';
import 'package:channel_pricing/data/channels.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:awesome_select/awesome_select.dart';

class ChannelListScreen extends StatefulWidget {
  const ChannelListScreen({Key? key, required this.screen}) : super(key: key);

  @override
  _ChannelListScreenState createState() => _ChannelListScreenState();

  //final
  final String screen;
}

class _ChannelListScreenState extends State<ChannelListScreen> {
  // constants
  TextEditingController _controller = TextEditingController();
  StreamController<List<Channel>> _channelStream =
      StreamController<List<Channel>>();
  List<String> _langValue = [];
  List<String> _genreValue = [];
  String _channelValue = '';
  int _totalChannel = 0;
  String _streamType = '';
  String _sortBy = 'sortAZ';

  List<S2Choice<String>> langoptions = [
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
  List<S2Choice<String>> genreOptions = [
    S2Choice<String>(value: 'Devotional', title: 'Devotional'),
    S2Choice<String>(value: 'GEC', title: 'GEC'),
    S2Choice<String>(value: 'Infotainment', title: 'Infotainment'),
    S2Choice<String>(value: 'Kids', title: 'Kids'),
    S2Choice<String>(value: 'Miscellaneous', title: 'Miscellaneous'),
    S2Choice<String>(value: 'Movies', title: 'Movies'),
    S2Choice<String>(value: 'Music', title: 'Music'),
    S2Choice<String>(value: 'News', title: 'News'),
    S2Choice<String>(value: 'Sports', title: 'Sports'),
  ];
  Icon searchIcon = Icon(Icons.search);
  Widget searchWidget = 'All Channels'.text.extraBold.make();
  bool showBackButton = true;

  List<Map<String, dynamic>> channelData = List.from(channels);

  void getChannels() async {
    List<Channel> channelList = [];

    // sort by
    if (_sortBy == 'sortAZ') {
      channelData
          .sort((a, b) => (a['channelName']).compareTo((b['channelName'])));
    } else if (_sortBy == 'sortZA') {
      channelData
          .sort((a, b) => (b['channelName']).compareTo((a['channelName'])));
    } else if (_sortBy == 'sortLow') {
      channelData.sort((a, b) => (a['cost']).compareTo((b['cost'])));
    } else if (_sortBy == 'sortHigh') {
      channelData.sort((a, b) => (b['cost']).compareTo((a['cost'])));
    }

    for (var item in channelData) {
      // free screen
      if (widget.screen == 'Free' &&
          double.parse(item['cost'].toString()) != 0.0) {
        continue;
      }

      // paid screen
      if (widget.screen == 'Paid' &&
          double.parse(item['cost'].toString()) == 0.0) {
        continue;
      }

      // HD screen
      if (widget.screen == 'HD' && item['streamType'].toString() != 'HD') {
        continue;
      }

      // SD screen
      if (widget.screen == 'SD' &&
          item['streamType'] != '' &&
          item['streamType'].toString() != 'SD') {
        continue;
      }

      // channel name filter
      if ((_channelValue == '' ||
              item['channelName']
                      .toLowerCase()
                      .indexOf(_channelValue.toLowerCase()) !=
                  -1) &&
          (_langValue.isEmpty ||
              _langValue.any((String s) => item['lang']
                  .split(',')
                  .any((String s2) => s.toLowerCase() == s2.toLowerCase()))) &&
          (_genreValue.isEmpty || _genreValue.contains(item['genre'])) &&
          (_streamType == '' || _streamType == item['streamType'])) {
        // push data to view
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
    }

    _channelStream.add(channelList);
    _totalChannel = channelList.length;
  }

  updateTitle() {
    this.searchWidget = '${widget.screen} Channels (${this._totalChannel})'
        .text
        .extraBold
        .make();
  }

  void initState() {
    super.initState();
    _controller = TextEditingController();
    getChannels();
    updateTitle();
  }

  void dispose() {
    _controller.dispose();
    _channelStream.close();
    // _channelStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchWidget,
        automaticallyImplyLeading: showBackButton,
        actions: [
          IconButton(
            icon: this.searchIcon,
            tooltip: 'Search',
            onPressed: () => setState(() {
              if (this.searchIcon.icon == Icons.search) {
                this.showBackButton = false;
                this.searchIcon = Icon(Icons.cancel_outlined);
                this.searchWidget = TextField(
                  cursorColor: kPrimaryBackgroundColor,
                  autofocus: true,
                  textInputAction: TextInputAction.go,
                  style: TextStyle(
                    color: kPrimaryBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Channels',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _channelValue = value;
                    });

                    getChannels();
                    updateTitle();
                  },
                );
              } else {
                this.showBackButton = true;
                this.searchIcon = Icon(Icons.search);

                setState(() {
                  _channelValue = '';
                });

                getChannels();
                updateTitle();
              }
            }),
          ),
          PopupMenuButton(
            icon: Icon(Icons.sort),
            tooltip: 'Sort',
            elevation: 25.0,
            offset: Offset(25, 50),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'sortAZ',
                child: this._sortBy == 'sortAZ'
                    ? Row(
                        children: [
                          Text('Sort by (A-Z)'),
                          WidthBox(10.0),
                          Icon(Icons.check_box_sharp, color: kSecondaryColor),
                        ],
                      )
                    : Text('Sort by (A-Z)'),
              ),
              PopupMenuItem<String>(
                value: 'sortZA',
                child: this._sortBy == 'sortZA'
                    ? Row(
                        children: [
                          Text('Sort by (Z-A)'),
                          WidthBox(10.0),
                          Icon(Icons.check_box_sharp, color: kSecondaryColor),
                        ],
                      )
                    : Text('Sort by (Z-A)'),
              ),
              PopupMenuItem<String>(
                value: 'sortLow',
                child: this._sortBy == 'sortLow'
                    ? Row(
                        children: [
                          Text('Sort by ₹ (Low-High)'),
                          WidthBox(10.0),
                          Icon(Icons.check_box_sharp, color: kSecondaryColor),
                        ],
                      )
                    : Text('Sort by ₹ (Low-High)'),
              ),
              PopupMenuItem<String>(
                value: 'sortHigh',
                child: this._sortBy == 'sortHigh'
                    ? Row(
                        children: [
                          Text('Sort by ₹ (High-Low'),
                          WidthBox(10.0),
                          Icon(Icons.check_box_sharp, color: kSecondaryColor),
                        ],
                      )
                    : Text('Sort by ₹ (High-Low)'),
              ),
            ],
            onSelected: (String value) => {
              setState(() {
                this._sortBy = value;
                getChannels();
              })
            },
          )
        ],
      ),
      // drawer: CustomAppDrawer(),
      body: Padding(
        padding: kContentPadding,
        child: Container(
          child: StreamBuilder<List<Channel>>(
            stream: _channelStream.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Channel>> snapshot) {
              if (snapshot.hasData && snapshot.data?.length == 0) {
                return 'No Channels Found'.text.xl2.makeCentered();
              } else if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length,
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
                      child: Container(
                        padding: kContentPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                '${truncateWithEllipsis(15, snapshot.data![i].name)}'
                                    .text
                                    .xl
                                    .bold
                                    .gray700
                                    .softWrap(false)
                                    .ellipsis
                                    .maxLines(1)
                                    .make(),
                                '${truncateWithEllipsis(15, snapshot.data![i].lang)}'
                                    .text
                                    .xl
                                    .bold
                                    .gray600
                                    .softWrap(false)
                                    .ellipsis
                                    .maxLines(1)
                                    .make(),
                              ],
                            ),
                            HeightBox(5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                'Genre: ${snapshot.data![i].genre == '' ? 'NA' : snapshot.data![i].genre}'
                                    .text
                                    .lg
                                    .bold
                                    .gray600
                                    .softWrap(false)
                                    .ellipsis
                                    .maxLines(1)
                                    .make(),
                                '₹ ${snapshot.data![i].cost}'
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
                            '${truncateWithEllipsis(40, snapshot.data![i].broadcaster)}'
                                .text
                                .gray500
                                .softWrap(false)
                                .ellipsis
                                .maxLines(1)
                                .make(),
                          ],
                        ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryDarkColor,
        child: Icon(Icons.filter_list_outlined, color: Colors.white),
        onPressed: () async {
          bool reload = await showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            context: context,
            builder: (BuildContext _context) {
              return StatefulBuilder(
                builder: (BuildContext __context,
                    StateSetter setState /*You can rename this!*/) {
                  return Container(
                    padding: kAppPadding,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          'Apply Filter'.text.xl.bold.makeCentered(),
                          HeightBox(40),
                          Row(
                            children: [
                              'Type:'.text.bold.make(),
                              Radio(
                                value: '',
                                groupValue: _streamType,
                                onChanged: (String? value) {
                                  setState(() {
                                    _streamType = value!;
                                  });
                                },
                              ),
                              'All'.text.make().pOnly(right: 20),
                              Radio(
                                value: 'HD',
                                groupValue: _streamType,
                                onChanged: (String? value) {
                                  setState(() {
                                    _streamType = value!;
                                  });
                                },
                              ),
                              'HD'.text.make().pOnly(right: 20),
                              Radio(
                                value: 'SD',
                                groupValue: _streamType,
                                onChanged: (String? value) {
                                  setState(() {
                                    _streamType = value!;
                                  });
                                },
                              ),
                              'SD'.text.make().pOnly(right: 20),
                            ],
                          ),
                          HeightBox(30),
                          Row(
                            children: [
                              'Language:'.text.bold.make(),
                              Expanded(
                                child: SmartSelect<String>.multiple(
                                  modalType: S2ModalType.popupDialog,
                                  modalHeaderStyle: S2ModalHeaderStyle(
                                    backgroundColor: kSecondaryColor,
                                  ),
                                  modalConfirm: true,
                                  modalFilter: true,
                                  modalHeader: true,
                                  modalTitle: 'Language',
                                  title: '',
                                  selectedValue: _langValue,
                                  choiceItems: langoptions,
                                  onChange: (state) => setState(() {
                                    _langValue = state.value;
                                  }),
                                ),
                              ),
                            ],
                          ),
                          HeightBox(30),
                          Row(
                            children: [
                              'Genre:'.text.bold.make(),
                              Expanded(
                                child: SmartSelect<String>.multiple(
                                  modalType: S2ModalType.popupDialog,
                                  modalHeaderStyle: S2ModalHeaderStyle(
                                    backgroundColor: kSecondaryColor,
                                  ),
                                  modalConfirm: true,
                                  modalFilter: true,
                                  modalHeader: true,
                                  modalTitle: 'Genre',
                                  title: '',
                                  selectedValue: _genreValue,
                                  choiceItems: genreOptions,
                                  onChange: (state) => setState(() {
                                    _genreValue = state.value;
                                  }),
                                ),
                              ),
                            ],
                          ),
                          HeightBox(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: 'APPLY'.text.white.bold.make(),
                                // color: kPrimaryColor,
                                onPressed: () async => {
                                  setState(() {
                                    // getChannels();
                                    // updateTitle();
                                    Navigator.pop(__context, true);
                                  })
                                },
                              ),
                              ElevatedButton(
                                child: 'RESET'.text.white.bold.make(),
                                // color: kSecondaryDarkColor,
                                onPressed: () => {
                                  setState(() {
                                    _streamType = '';
                                    _langValue = [];
                                    _genreValue = [];
                                  }),
                                  Navigator.pop(__context, false),
                                },
                              ),
                              ElevatedButton(
                                child: 'CANCEL'.text.white.bold.make(),
                                // color: kTertiaryColor,
                                onPressed: () => {
                                  Navigator.maybePop(context, false),
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );

          if (reload) {
            setState(() {
              updateTitle();
              getChannels();
            });
          }
        },
      ),
    );
  }

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2191548178499350/3728607813';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2191548178499350/3728607813';
    }
    return null;
  }
}
