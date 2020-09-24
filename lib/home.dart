import 'dart:convert';

import 'package:flutter/material.dart';
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

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentindex = 0;
  int _currentPage = 0;

  PageController pageController;

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

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.6,
    );

    Timer.periodic(Duration(seconds: 15), (Timer timer) {
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
    http.Response response = await http.get("https://dollarstir.com/admin/html/ltr/pages/api.php");
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
                height: 200,
                child: Card(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/2.jpg',
                        ),
                      ),
                      Container(
                        width: 150,
                        // height: 100,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.play_arrow),
                          label: Text(
                            'Play',
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          onPressed: () {},
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
                                if(snapshot.connectionState == ConnectionState.waiting)
                                  return Text("lOADING");

                                if(snapshot.connectionState == ConnectionState.done)
                                  if(snapshot.hasData) {
                                    List images = snapshot.data.map((e) => e['pic']).toList();
                                    
                                    return PageView.builder(
                                      controller: pageController,
                                      onPageChanged: _onPageChnaged,
                                      itemCount: images.length,
                                      itemBuilder: (context, position) {
                                        return imageSlider(position, images);
                                      },
                                    );
                                  }
                                return Text("eRROR");
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
                                        Image.asset("assets/images/1.jpg",
                                            fit: BoxFit.cover),
                                        // SizedBox(height: 5,),

                                        Text(
                                          "SEPTEMBER 18",
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
                                              "A peaceful heart leads to a healthy body jealosy is like cancer in the bones"),
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
                return Morep();
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
                return;
              }),
            );
          }
        },
      ),
    );
  }

  imageSlider(int index, List images) {
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
            height: Curves.easeInOut.transform(value) * 200,
            width: Curves.easeInOut.transform(value) * 220,
            child: widget,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Card(
          elevation: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                "https://dollarstir.com/admin/html/ltr/pages/${images[index]}", 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                loadingBuilder: (context, child, loadingProgress) => loadingProgress != null ? Center(child: CircularProgressIndicator()) : child,
              ),
              // SizedBox(height: 5,),

              Text("Some title Here"),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Pdetail();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
