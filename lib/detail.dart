import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import './model/Slide.dart';

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

class Pdetail extends StatefulWidget {
  final Map item;

  Pdetail({this.item});
 
  YtubeState createState() => YtubeState();
 
}
 
class YtubeState extends State<Pdetail>{
 

 Future<void> _shareImageFromUrl(mypic,mymess,mytt) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          'http://radio.favorchapel.com/upload/$mypic'));
      var response = await request.close();
      var  bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('$mytt', '$mypic', bytes, '*/*',text: mymess);
    } catch (e) {
      print('error: $e');
    }
  }
  
 
  @override
  Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
        title: Text('${widget.item['title']}')),
      body: Container(
        child: Card(
          elevation: 10,
          child: Container(
                            // flex: 1,

                            child: Center(
                              child: SizedBox(
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
                                        Image.network(
                                          "http://radio.favorchapel.com/upload/${widget.item['pic']}", 
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                          loadingBuilder: (context, child, loadingProgress) => loadingProgress != null ? Center(child: CircularProgressIndicator()) : child,
                                        ),

                                        // SizedBox(height: 5,),

                                        Text(
                                          "${widget.item['dateadded']}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),

                                        Text(
                                          "${widget.item['title']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Container(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          child: Text(
                                              "${widget.item['description']}"),
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
                                                onPressed: ()async {
                                                  // Share.share("${widget.item['description']}",
                                                  // subject: '${widget.item['title']}');
                                                  var mytitle=widget.item['title'];
                                                  var mymess= "FAVOR CHAPEL INTERNATIONAL\n \n  TITLE : " + widget.item['title']+ ' \n \n' + widget.item['description'];
                                                  // Share.share("FAVOR RADIO\n \nBile verse of the day\n \n" + snapshot.data[0]['vtitle']+ ' \n' + snapshot.data[0]['vdetail'],
                                                  // subject: snapshot.data[0]['vtitle']);
                                                  var mpp = widget.item['pic'];
                                                  // Share.shareFiles(["http://radio.favorchapel.com/upload/${snapshot.data[0]['vpic']}"],subject: snapshot.data[0]['vtitle'],text:"FAVOR RADIO\n \nBile verse of the day\n \n" + snapshot.data[0]['vtitle']+ ' \n' + snapshot.data[0]['vdetail'] );
                                                    //   var request = await HttpClient().getUrl((Uri.parse('https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg')));
                                                    //  var response = await request.close();
                                                    //   var  bytes = await consolidateHttpClientResponseBytes(response);
                                                    // await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');'

                                                    await _shareImageFromUrl(mpp,mymess,mytitle);

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
                                              ),
                                              
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
        ),
      ),
  );
  }
}

