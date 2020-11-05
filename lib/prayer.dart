import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:audio_picker/audio_picker.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class Prayer extends StatefulWidget {
  Prayer({Key key}) : super(key: key);

  _PrayerState createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  String _absolutePathOfAudio="Browse your audio file";
  String _audioname="";
  File _file;
  AudioPlayer audioPlayer;
  var cpercent=0;
  var ttpercent=0;
  var name;
  var phone;
  var description;
  var mess = "";
  bool _visible = true;
  bool _isready = true;
    TextEditingController cname = new TextEditingController();
    TextEditingController cphone = new TextEditingController();
    TextEditingController cdescription = new TextEditingController();




  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  // void openAudioPicker() async {
  //   // showLoading();
  //   var myaudiofile = await AudioPicker.pickAudio();
  //   // dismissLoading();
  //   setState(() {
  //     _absolutePathOfAudio = path;
  //   });
  // }

  void getFile()async{
      File file = await FilePicker.getFile();

      setState(() {
       
        if (file != null) {
           _file = file;
           _absolutePathOfAudio= file.path;

            
            
          
          
        } else {
          print('no image selected');
        }
        
      });
      print(_file);
    }



    void _uploadFile(filePath) async {
    String fileName = basename(filePath.path);
    print("file base name:$fileName");
    setState(() {
      _isready= !_isready;
    });

    try {
     
      FormData formData = new FormData.fromMap({
         "name": cname.text,
         "phone": cphone.text,
         "detail" : cdescription.text,
         "file": await MultipartFile.fromFile(filePath.path, filename: fileName),
        
      });

      Response response = await Dio().post("http://radio.favorchapel.com/prayer.php",data: formData,onSendProgress: (int sent, int total) {
          print(((sent /total)*100).round());
          setState(() {
            cpercent= ((sent /total)*100).round();
            ttpercent =((total /total)*100).round();
          });
  },);
      print("File upload response: $response");
      // _showSnackBarMsg(response.data['message']);
        setState(() {
           mess = response.data['message'];
           _visible = !_visible;
        });
          } catch (e) {
            print("expectation Caugch: $e");
          }
      

      
       }

  void playMusic() async {
    await audioPlayer.play(_absolutePathOfAudio, isLocal: true);
  }

  void stopMusic() async {
    await audioPlayer.stop();
  }

  void resumeMusic() async {
    await audioPlayer.resume(); // quickly plays the sound, will not release
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer request"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(height: 50),
                  
                  Container(
                    padding: EdgeInsets.only(left: 40,right: 10),
                    
                    child:Text(_absolutePathOfAudio),
                  ),


                  SizedBox(height: 20),

                  Container(
                    child:RaisedButton(
                onPressed: () {
                  getFile();
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
                      'Browse Audio file',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
                  ),

                   SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top:10,left: 20,right: 20),
              child: TextField(
                controller: cname,
                decoration: new InputDecoration(
                  hintText: "Your name",
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:10,left: 20,right: 20),
              child: TextField(
                controller: cphone,
                decoration: new InputDecoration(
                  hintText: "Your number eg +233244044013",
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:10,left: 20,right: 20),
              child: TextField(
                controller: cdescription,
                decoration: new InputDecoration(
                  hintText: "descirbe your request",
                ),
              ),
            ),


                  Center(
              child: AnimatedOpacity(
                opacity: _isready ? 0.0 : 1.0,
                duration: Duration(milliseconds: 100),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                // animationDuration: 2500,
                percent: cpercent/100,
                center: Text(cpercent.toString()+ "%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ),
            ),
              ],
            ),
              ),
            ),
             SizedBox(height: 20),

                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _file == null
                      ? Container()
                      : FlatButton(
                          color: Colors.blue[400],
                          child: Text(
                            "Play",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: playMusic,
                        ),
                  _file == null
                      ? Container()
                      : FlatButton(
                          color: Colors.red[400],
                          child: Text(
                            "Stop",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: stopMusic,
                        ),


                    _file == null
                      ? Container()
                      : FlatButton(
                          color: Colors.green[400],
                          child: Text(
                            "Send Request",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: (){
                            _uploadFile(_file);
                          },
                        )
                    ],
                  ),

                  Center(
              child: AnimatedOpacity(
                opacity: _visible ? 0.0 : 1.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  //  color: Colors.blue,c

                  child: Card(
                    elevation: 15,
                    color: Colors.green,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              onPressed: (){
                                setState(() {
                                  _visible= true;
                                  _isready= true;
                                });

                              },
                          
                          color: Colors.green,
                          textColor: Colors.red,
                          child: Icon(Icons.close),
                        ),
                          ],
                        ),
                        Center(
                          child: Text(
                            mess,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                ],
              ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
