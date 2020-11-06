import 'dart:convert';
import 'dart:io';

import 'package:Favorchapel/adverts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:metadata_fetch/metadata_fetch.dart';// import './model/Slide.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

// import './widget/slider.dart';
import 'dart:async';
// import './slidedot.dart';

// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import './Radio.dart';
import './more.dart';
import 'package:http/http.dart' as http;
import './map.dart';
import './detail.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
// import 'package:share/share.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  var playerState = FlutterRadioPlayer.flutter_radio_playing;
  var volume = 0.8;

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentindex = 0;
  int _currentPage = 0;
  var myct;
  var songtt="";

  PageController pageController;
  ValueNotifier<Future> songTitleFuture = ValueNotifier(null);

  // int _currentPage = 0;
  // final PageController _pageController = PageController(
  //   initialPage: 0,
  // );

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _pageController.dispose();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 30), (Timer timer) {
  //     if (_currentPage < 2) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }
  //     _pageController.animateToPage(_currentPage,
  //         duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  //   });
  // }

  // _onPageChnaged(int index) {
  //   setState(() {
  //     _currentPage = index;
  //   });
  // }

  List<String> images = [
    // 'assets/images/1.jpg',
    // 'assets/images/2.jpg',
    // 'assets/images/3.jpg',
    // 'assets/images/4.jpg'
  ];

  // void cc()async{
  //   if(FlutterRadioPlayer.flutter_radio_paused==true){

  //     FlutterRadioPlayer.flutter_radio_playing;

  //   }

  // }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mtt() async {
    
  }

  Future<void> _shareImageFromUrl(mypic, mymess, mytt) async {
    try {
      var request = await HttpClient().getUrl(
          Uri.parse('http://radio.favorchapel.com/upload/$mypic'));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('$mytt', '$mypic', bytes, '*/*', text: mymess);
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareText() async {
    try {
      Share.text('my text title',
          'This is my text to share with other applications.', 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init(
        "Favor Radio",
        "Live",
        "http://stream.zeno.fm/k5mryscq3a0uv",
        "false",
      );
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  void autostart() async {
    await _flutterRadioPlayer.play();
  }

  Future  _future;

   var currentplay="Unknow artist";

   setUpTimedFetch()async {
   new  Timer.periodic(Duration(milliseconds: 30000), (timer) {
     songTitleFuture.value = songtitle();
      // setState(() {
      //   _future = songtitle();
      // });
    });
  }

  @override
  void initState() {
    super.initState();
    initRadioService();
    autostart();
    setUpTimedFetch();
    // songtitle();

    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.6,
    );

    Timer.periodic(Duration(seconds: 7), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  _onPageChnaged(int index) {
    // setState(() {
    _currentPage = index;
    // });
  }

  Future apiCall() async {
    http.Response response =
        await http.get("http://radio.favorchapel.com/api.php");
    return json.decode(response.body);
  }

  
  Future songtitle() async {
    http.Response response =
        await http.get("http://radio.favorchapel.com/stream.php");
        var rtt= json.decode(response.body);
        
    return json.decode(response.body);
  }

  Future verseCall() async {
    http.Response response =
        await http.get("http://radio.favorchapel.com/verse.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                // height: 200,
                child: Card(
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: Image.asset('assets/images/Radio.jpg',
                            fit: BoxFit.fill),
                      ),

                      Container(
                        // height: 10,r
                        // padding: EdgeInsets.only(top:2),
                        child:ValueListenableBuilder<Future>(
                          valueListenable: songTitleFuture,
                          builder: (context, value, child) => FutureBuilder(
                            future: value,
                            // initialData: InitialData,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return Text(currentplay,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12,
                                    ));

                              if (snapshot.connectionState ==
                                  ConnectionState.done) if (snapshot.hasData) {
                                if (snapshot.data == "false") {
                                  print(snapshot.data['data']);
                                  // currentplay = snapshot.data['data'].toString();
                                  return Text(currentplay,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ));
                                } else {
                                  print(snapshot.data['data']);
                                  currentplay =
                                      snapshot.data['data'].toString();
                                  return Text(snapshot.data['data'].toString(),
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ));
                                }
                              }
                              return Text("unknown artist",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ));
                            },
                          ),
                        ),
                        
                      ),
                      SizedBox(height:5),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: StreamBuilder(
                          stream: _flutterRadioPlayer.isPlayingStream,
                          initialData: widget.playerState,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            String returnData = snapshot.data;
                            print("object data: " + returnData);
                            switch (returnData) {
                              case FlutterRadioPlayer.flutter_radio_stopped:
                                return RaisedButton.icon(
                                  textColor: Colors.white,
                                  icon: Icon(Icons.stay_current_landscape),
                                  label: Text("Start Listening"),
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0))),
                                  onPressed: () async {
                                    await initRadioService();
                                  },
                                );
                                break;
                              case FlutterRadioPlayer.flutter_radio_loading:
                                return Text("Loading stream...");
                              case FlutterRadioPlayer.flutter_radio_error:
                                return RaisedButton.icon(
                                  textColor: Colors.white,
                                  icon: Icon(Icons.refresh),
                                  label: Text("Retry Listening"),
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0))),
                                  onPressed: () async {
                                    await initRadioService();
                                  },
                                );
                                break;

                                break;
                              default:
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RaisedButton.icon(
                                        textColor: Colors.black,
                                        icon: snapshot.data ==
                                                FlutterRadioPlayer
                                                    .flutter_radio_playing
                                            ? Icon(Icons.pause)
                                            : Icon(Icons.play_arrow),
                                        label: snapshot.data ==
                                                FlutterRadioPlayer
                                                    .flutter_radio_playing
                                            ? Text("Pause")
                                            : Text("Play"),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0))),
                                        onPressed: () async {
                                          print(songtt);
                                          print("button press data: " +
                                              snapshot.data.toString());
                                          await _flutterRadioPlayer
                                              .playOrPause();
                                          // RRR
                                        },
                                      ),
                                      RaisedButton.icon(
                                        textColor: Colors.black,
                                        icon: Icon(Icons.stop),
                                        label: Text("Stop"),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0))),
                                        onPressed: () async {
                                          print("button press data: " +
                                              snapshot.data.toString());
                                          await _flutterRadioPlayer.stop();
                                        },
                                      ),
                                    ]);
                                break;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(top: 7),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            // flex: 1,
                            height: 200,
                            child: FutureBuilder(
                                future: apiCall(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return Text("lOADING");

                                  if (snapshot.connectionState ==
                                      ConnectionState
                                          .done) if (snapshot.hasData) {
                                    List images = snapshot.data;

                                    return PageView.builder(
                                      controller: pageController,
                                      onPageChanged: _onPageChnaged,
                                      itemCount: images.length,
                                      itemBuilder: (context, position) {
                                        return imageSlider(
                                            position, images[position]);
                                      },
                                    );
                                  }
                                  return Text(
                                      "Something Wrong  or No record in database");
                                }
                                ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Verse of The Day",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            // flex: 1,

                            child: Center(
                                child: FutureBuilder(
                              future: verseCall(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return Text("lOADING");

                                if (snapshot.connectionState ==
                                    ConnectionState
                                        .done) if (snapshot.hasData) {
                                  List images = snapshot.data;

                                  return SizedBox(
                                    // height: Curves.easeInOut.transform(1) * 400,
                                    width: Curves.easeInOut.transform(1) *
                                        double.infinity,
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: Card(
                                        elevation: 15,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 200,
                                              child: Material(
                                                  child: InkWell(
                                                onTap: () async {
                                                  return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          RaisedButton(
                                                            child: Icon(Icons.close,color: Colors.red,),
                                                            color: Colors.transparent,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          Container(
                                                           
                                                            child:
                                                                Image.network(
                                                              "http://radio.favorchapel.com/upload/" +
                                                                  snapshot.data[
                                                                          0]
                                                                      ['vpic'],
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                      // AlertDialog(
                                                      //   title: Text(
                                                      //       'Hello  Title'),
                                                      //   content: Expanded(
                                                      //     child: Image.network(
                                                      //       "https://favorchapel.dollarstir.com/upload/" +
                                                      //           snapshot.data[0]
                                                      //               ['vpic'],
                                                      //       fit: BoxFit.fill,
                                                      //     ),
                                                      //   ),
                                                      //   actions: <Widget>[
                                                      //     TextButton(
                                                      //       child: Icon(
                                                      //         Icons.close,
                                                      //       ),
                                                      //       onPressed: () {
                                                      //         Navigator.of(
                                                      //                 context)
                                                      //             .pop();
                                                      //       },
                                                      //     ),
                                                      //   ],
                                                      // );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Image.network(
                                                      "http://radio.favorchapel.com/upload/" +
                                                          snapshot.data[0]
                                                              ['vpic'],
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Icon(Icons.error),
                                                      loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) =>
                                                          loadingProgress !=
                                                                  null
                                                              ? Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : child,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                            ),
                                            // SizedBox(height: 5,),

                                            Text(
                                              snapshot.data[0]['dateadded'],
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.red,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),

                                            Text(
                                              snapshot.data[0]['vtitle'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                                  snapshot.data[0]['vdetail']),
                                            ),

                                            // RaisedButton(
                                            //   onPressed: () {},
                                            //   shape: RoundedRectangleBorder(
                                            //       borderRadius: BorderRadius.circular(80.0)),
                                            //   padding: const EdgeInsets.all(0.0),
                                            //   child: Ink(
                                            //     decoration: const BoxDecoration(
                                            //       gradient: LinearGradient(
                                            //         colors: <Color>[
                                            //           Color(0xFF0D47A1),
                                            //           Color(0xFF1976D2),
                                            //           Color(0xFF42A5F5),
                                            //         ],
                                            //       ),
                                            //       borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                            //     ),
                                            //     child: Container(
                                            //       constraints: const BoxConstraints(
                                            //           minWidth: 80.0,
                                            //           minHeight: 36.0), // min sizes for Material buttons
                                            //       alignment: Alignment.center,
                                            //       child: const Text(
                                            //         'Read Now',
                                            //         textAlign: TextAlign.center,
                                            //         style: TextStyle(color: Colors.white),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )

                                            Container(
                                              child: Row(
                                                children: [
                                                  RaisedButton.icon(
                                                    onPressed: () async {
                                                      var mymess =
                                                          "FAVOR CHAPEL INTERNATIONAL\n \nBible verse of the day\n \n" +
                                                              snapshot.data[0]
                                                                  ['vtitle'] +
                                                              ' \n' +
                                                              snapshot.data[0]
                                                                  ['vdetail'];
                                                      // Share.share("FAVOR RADIO\n \nBile verse of the day\n \n" + snapshot.data[0]['vtitle']+ ' \n' + snapshot.data[0]['vdetail'],
                                                      // subject: snapshot.data[0]['vtitle']);
                                                      var mpp = snapshot.data[0]
                                                          ['vpic'];
                                                      var mytt = snapshot
                                                          .data[0]['vtitle'];
                                                      // Share.shareFiles(["https://favorchapel.dollarstir.com/upload/${snapshot.data[0]['vpic']}"],subject: snapshot.data[0]['vtitle'],text:"FAVOR RADIO\n \nBile verse of the day\n \n" + snapshot.data[0]['vtitle']+ ' \n' + snapshot.data[0]['vdetail'] );
                                                      //   var request = await HttpClient().getUrl((Uri.parse('https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg')));
                                                      //  var response = await request.close();
                                                      //   var  bytes = await consolidateHttpClientResponseBytes(response);
                                                      // await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');'

                                                      await _shareImageFromUrl(
                                                          mpp, mymess, mytt);
                                                    },
                                                    color: Colors.transparent,
                                                    disabledColor:
                                                        Colors.transparent,
                                                    icon: Icon(
                                                      Icons.share,
                                                      color: Colors.blue,
                                                    ),
                                                    label: Text(
                                                      "Share",
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Text(
                                    "Something Wrong  or No record in database");
                              },
                            )),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        // iconSize: 10,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "home",
            ),
            backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            title: Text(
              "Radio",
            ),
            backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_business,
            ),
            title: Text(
              "Adverts",
            ),
            backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text(
              "More",
            ),
            backgroundColor: Colors.blue,
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.group_work,  ),
          //   title: Text("Services"),
          // ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.call,color: Colors.white,),
          //   title: Text("Contact",),
          //   backgroundColor: Colors.blue,

          // ),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });

          if (_currentindex == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Myadd();
              }),
            );
          } else if (_currentindex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Myradio();
              }),
            );
          } else if (_currentindex == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Morep();
              }),
            );
          }
        },
      ),
    );
  }

  imageSlider(int index, Map details) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.1, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 300,
            width: Curves.easeInOut.transform(value) * 210,
            child: widget,
          ),
        );
      },
      child: Container(
        // margin: EdgeInsets.all(2),

        child: Card(
          elevation: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 110,
                width: double.infinity,
                child: Image.network(
                  "http://radio.favorchapel.com/upload/${details['pic']}",
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress != null
                          ? Center(child: CircularProgressIndicator())
                          : child,
                ),
              ),
              // SizedBox(height: 5,),

              Text("${details['title']}"),
              Container(
                  width: 150,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Pdetail(item: details);
                      }));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 80.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          'Read Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),

        // decoration: BoxDecoration(
        //    borderRadius: BorderRadius.circular(80.0)),
        // ),
      ),
    );
  }
}

// class ImageDialog extends StatelessWidget {
//   final Map item;

//   ImageDialog({this.item});
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: 200,
//         height: 200,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(
//                     "https://favorchapel.dollarstir.com/upload/${this.item['pic']}"),
//                 fit: BoxFit.cover)),
//       ),
//     );
//   }
// }
