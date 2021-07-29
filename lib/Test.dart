import 'dart:async';
import 'dart:math';
import 'dart:ui';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  // ignore: close_sinks
  StreamController<int> selectController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    point = [0, 0, 0, 0, 0, 0, 0, 0];
    animationController =
        new AnimationController(vsync: this, duration: new Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  int selected = 0;
  // ignore: non_constant_identifier_names
  int rotation_count = 10;
  List<int> point = [0, 0, 0, 0, 0, 0, 0, 0];
  final items = <String>[
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                child: FortuneWheel(
                    // onAnimationStart: () {
                    //   print(selectController);
                    // },
                    // physics: CircularPanPhysics(
                    //   duration: Duration(seconds: 9),
                    //   curve: Curves.decelerate,
                    // ),
                    // onFling: () {},
                    // styleStrategy: AlternatingStyleStrategy(),
                    selected: selectController.stream,
                    // animateFirst: false,
                    onAnimationEnd: () {
                      setState(() {
                        print(selectController);
                      });
                    },
                    rotationCount: rotation_count,
                    onFling: () => {
                          setState(() {
                            selected = selectController as int;
                            selected = Random().nextInt(items.length);
                            point[selected] = point[selected] + 1;
                            print(
                                "Selected value1 $selected ${point[selected]}");
                          })
                        },
                    // curve: FortuneCurve.none,
                    // duration: FortuneWidget.kDefaultDuration,

                    items: [
                      // FortuneItem(
                      //   child: Text("10%"),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),
                      //     color: Colors
                      //         .deepOrange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),
                      // FortuneItem(
                      //   child: Text('20%'),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),

                      //     color: Colors
                      //         .orange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),
                      // FortuneItem(
                      //   child: Text("30%"),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),

                      //     color: Colors
                      //         .deepOrange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),
                      // FortuneItem(
                      //   child: Text("40%"),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),

                      //     color: Colors
                      //         .orange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),
                      // FortuneItem(
                      //   child: Text("50%"),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),

                      //     color: Colors
                      //         .deepOrange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),
                      // FortuneItem(
                      //   child: Text("60%"),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),

                      //     color: Colors
                      //         .orange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),
                      // FortuneItem(
                      //   child: Text("70%"),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),

                      //     color: Colors
                      //         .deepOrange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),
                      // FortuneItem(
                      //   child: Text("80%"),
                      //   style: FortuneItemStyle(
                      //     textStyle: TextStyle(fontSize: 20),
                      //     color: Colors
                      //         .orange, // <-- custom circle slice fill color
                      //     borderColor: Colors
                      //         .orangeAccent, // <-- custom circle slice stroke color
                      //     borderWidth:
                      //         3, // <-- custom circle slice stroke width
                      //   ),
                      // ),

                      for (var i in items) FortuneItem(child: Text(i)),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    selected = Random().nextInt(items.length);
                    point[selected] = point[selected] + 1;
                    print("Selected value1 $selected ${point[selected]}");
                    //   selectController = selected as StreamController<int>;
                    // });
                    selectController.add(Fortune.randomInt(0, 8));

                    // print("Value :" + "$selectController");
                  });
                },
                hoverColor: Colors.orange[100],
                splashColor: Colors.orange,
                color: Colors.deepOrange,
                elevation: 5,
                child: Text("Spin"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
