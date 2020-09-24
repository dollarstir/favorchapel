import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pdetail extends StatefulWidget {
  final Map item;

  Pdetail({this.item});
 
  YtubeState createState() => YtubeState();
 
}
 
class YtubeState extends State<Pdetail>{
 
  
 
  @override
  Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
        title: Text('${widget.item['pname']}')),
      body: Container(
        child: Card(
          elevation: 10,
          child: Container(
                            // flex: 1,

                            child: Center(
                              child: SizedBox(
                                height: Curves.easeInOut.transform(1) * 400,
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
                                          "https://dollarstir.com/admin/html/ltr/pages/${widget.item['pic']}", 
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                          loadingBuilder: (context, child, loadingProgress) => loadingProgress != null ? Center(child: CircularProgressIndicator()) : child,
                                        ),

                                        // SizedBox(height: 5,),

                                        Text(
                                          "${widget.item['df']}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),

                                        Text(
                                          "Proverb 14:30",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Container(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          child: Text(
                                              "${widget.item['depo']}"),
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
                              ),
                            ),
                          )
        ),
      ),
  );
  }
}

