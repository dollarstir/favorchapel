import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Mlocation extends StatefulWidget {
 
  YtubeState createState() => YtubeState();
 
}
 
class YtubeState extends State<Mlocation>{
 
  num position = 1 ;
 
  final key = UniqueKey();
 
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }
 
  startLoading(String A){
    setState(() {
      position = 1;
    });
  }
 
  @override
  Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
        title: Text('Location')),
      body: IndexedStack(
      index: position,
      children: <Widget>[
 
      WebView(
        initialUrl: "https://www.google.com/maps/place/6%C2%B041'21.0%22N+1%C2%B045'35.0%22W/@6.68916,-1.761922,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d6.68916!4d-1.7597333?hl=en",
        javascriptMode: JavascriptMode.unrestricted,
        key: key ,
        onPageFinished: doneLoading,
        onPageStarted: startLoading,
        ),
 
       Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator()),
        ),
        
      ])
  );
  }
}

