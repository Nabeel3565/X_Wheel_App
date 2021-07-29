import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'DisplayResult.dart';
import 'SecondScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // double _randomAngle() => Random().nextDouble() * pi * 2;
  // // ignore: unused_element
  // double _randomVelocity() => (Random().nextDouble() * 6000) + 2000;

  // // ignore: close_sinks
  // StreamController _dividerController = StreamController<int>();
  // // ignore: close_sinks
  // StreamController _wheelNotifier = StreamController<double>();
  dynamic result;
  String mg = '';
  final db = FirebaseFirestore.instance;
  // CollectionReference matchReference;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(vsync: this, duration: new Duration(seconds: 5))
          ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // Future showImage() {
  //   return FirebaseFirestore.instance
  //       .collection('image')
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((result) {
  //       // print(result.data());
  //       Map<String, dynamic> image = result.data();
  //       result.data()['imageLink'] != null
  //           ? articles(image[ValueKey])
  //           : Container(child: Text("No data"));
  //       // print(image[Key][ValueKey]);
  //       // final datas = buildTile(image[ValueKey], context);
  //     });
  // if (snapshot != null) {
  //   print('Document data: Loaded');
  //   final service = snapshot.docs;
  //   // List<Widget> serviceWidget = [];

  //   for (var i in service) {
  //     mg = i.data()['imageLink'];

  //     // final datas = buildTile(image, context);
  //     print("image");
  //     print(mg);
  //     return Text(mg);
  //     // serviceWidget.add(datas);
  //     // if (image != null) {}
  //   }
  // } else {
  //   print('Document does not exist on the database');
  // }
  //   });
  // }

  Container articles(String img) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,
      width: 80,
      child: InkWell(
        child: GestureDetector(
          child: Card(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(img), fit: BoxFit.cover)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
              // width: 400.0,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SecondScreen(img)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.orange, Colors.orangeAccent])),
        child: Column(
          children: [
            Center(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "X Wheel",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),

                Container(
                  height: 150,
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: db
                          .collection('image')
                          .snapshots(includeMetadataChanges: true),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Text(
                            "No Notification",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ));
                        } else if (snapshot.data!.docs.length == 0) {
                          return Center(
                              child: Text(
                            "No Notification",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ));
                        }
                        if (snapshot.hasData) {
                          final service = snapshot.data!.docs;
                          List<Widget> serviceWidget = [];

                          for (var i in service) {
                            final image =
                                (i.data() as Map)['imageLink'].toString();

                            final datas = buildTile(image, context);
                            print("image");

                            print(image);
                            serviceWidget.add(datas);
                          }
                          return ListView(
                            children: serviceWidget,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // padding: EdgeInsets.all(5),
                            physics: BouncingScrollPhysics(),
                          );
                        }
                        return CircularProgressIndicator();
                        // child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: ListView(
                        //     scrollDirection: Axis.vertical,
                        //     padding: const EdgeInsets.all(8.0),
                        //     children: snapshot.data.docs.map((document) {
                        //       return InkWell(
                        //         onTap: () async {
                        //           showDialog(
                        //               context: context,
                        //               builder: (context) {
                        //                 return Center(
                        //                     child: CircularProgressIndicator(
                        //                   strokeWidth: 2,
                        //                   valueColor: AlwaysStoppedAnimation<Color>(
                        //                       Colors.white),
                        //                 )
                        //                 );
                        //               }
                        //               );
                        //         },
                        //         child: CachedNetworkImage(
                        //           fit: BoxFit.cover,
                        //           imageUrl: document.data()['imageLink'][0] ?? '',
                        //           useOldImageOnUrlChange: true,
                        //           placeholder: (context, url) =>
                        //               CupertinoActivityIndicator(
                        //             radius: 5,
                        //           ),
                        //           errorWidget: (context, url, error) =>
                        //               Icon(Icons.error),
                        //           imageBuilder: (context, imageProvider) =>
                        //               Container(
                        //             alignment: Alignment.bottomCenter,
                        //             decoration: BoxDecoration(
                        //               color: Colors.white.withOpacity(0.9),
                        //               borderRadius: BorderRadius.circular(10),
                        //               image: DecorationImage(
                        //                   image: imageProvider, fit: BoxFit.cover),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Picture to See",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                // SpinningWheel(
                //   Image.asset(
                //     "images/2.png",
                //   ),
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height / 1.8,
                //   //  height: MediaQuery.of(context).size.height / 1.5,
                //   // width: MediaQuery.of(context).size.width / 1.5,
                //   canInteractWhileSpinning: false,
                //   initialSpinAngle: 0.1,
                //   dividers: 8,
                //   shouldStartOrStop: _wheelNotifier.stream,
                //   spinResistance: 0.2,
                //   onEnd: _dividerController.add,
                //   onUpdate: _dividerController.add,
                // ),
                // StreamBuilder(
                //   stream: _dividerController.stream,
                //   builder: (c, s) {
                //     return s.hasData ? DisplayResult(s.data) : Container();
                //    },
                // ),
                // MaterialButton(
                //   color: Theme.of(context).buttonColor,
                //   onPressed: () {
                //     // _wheelNotifier.sink.add(_randomVelocity());
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => SecondScreen()));
                //   },
                //   child: Text(
                //     "Start",
                //   ),
                //   minWidth: 150,
                //   shape: StadiumBorder(),
                // )
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.9,
                  alignment: Alignment.center,
                  child: new AnimatedBuilder(
                    animation: animationController,
                    // child: RotationTransition(
                    //   turns: Tween(begin: 0.0, end: 1.0).animate(animationController),

                    // ),
                    builder: (BuildContext? context, Widget? _widget) {
                      return new Transform.rotate(
                        angle: animationController.value * 2 * pi,
                        child: _widget,
                      );
                    },
                    child: Image.asset(
                      'images/2.png',
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      )),
    );
  }

  buildTile(image, BuildContext context) {
    return articles(image);
  }
}
