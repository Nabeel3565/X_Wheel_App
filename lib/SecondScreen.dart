import 'dart:async';
// import 'dart:io';
import 'dart:math';
import 'dart:ui';
// import 'package:toast/toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
// import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Ads/ad_helper.dart';

// COMPLETE: Add _bannerAd
BannerAd? _bannerAd;

// COMPLETE: Add _isBannerAdReady
bool _isBannerAdReady = false;

// COMPLETE: Add _interstitialAd
InterstitialAd? _interstitialAd;

// COMPLETE: Add _isInterstitialAdReady
bool _isInterstitialAdReady = false;

// COMPLETE: Add _rewardedAd
RewardedAd? _rewardedAd;

// COMPLETE: Add _isRewardedAdReady
bool _isRewardedAdReady = false;

// ignore: must_be_immutable
class SecondScreen extends StatefulWidget {
  String img;
  SecondScreen(this.img);
  @override
  _SecondScreenState createState() => _SecondScreenState(img);
}

class _SecondScreenState extends State<SecondScreen> {
  int? select;
  String? img;
  _SecondScreenState(this.img);
  // ignore: close_sinks
  StreamController<int> selectController = StreamController<int>();

  double r = 0, result = 0;
  @override
  void initState() {
    // COMPLETE:
    // Initialize _bannerAd;
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd!.load();

    // COMPLETE: Load a Rewarded Ad
    _loadRewardedAd();
    point = [0, 0, 0, 0, 0, 0, 0, 0];

    super.initState();
  }

  @override
  void dispose() {
    // COMPLETE: Dispose a BannerAd object
    _bannerAd!.dispose();

    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    // COMPLETE: Dispose a RewardedAd object
    _rewardedAd?.dispose();

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
  // int selects = 0;
  // bool btnvalue = true;
  // int mapData(int s) {
  //   final Map<int, int> label = {
  //     1: 10,
  //     2: 20,
  //     3: 30,
  //     4: 40,
  //     5: 50,
  //     6: 60,
  //     7: 70,
  //     8: 80,
  //   };

  //   return select = label.values.elementAt(s);
  //   // select = '${label[s]}';
  // }

  @override
  Widget build(BuildContext context) {
    print("Select");
    // print(select);
    // mapData(select);
    // print(mapData(select));
    // print(select);
    select = selected * 10;
    r = select! / 16 * 60.5;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.orange, Colors.orangeAccent])),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Stack(
                  children: [
                    Image.network(
                      img!,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.7,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: result,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.8),
                        child: Container(
                          color: Colors.white.withOpacity(0.8),
                          child: Container(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.clear_outlined),
                        onPressed: () {
                          _rewardedAd?.show(
                              onUserEarnedReward:
                                  (RewardedAd ad, RewardItem reward) {});
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SpinningWheel(
                  //   Image.asset("images/2.png"),
                  //   height: MediaQuery.of(context).size.height / 3.2,
                  //   width: MediaQuery.of(context).size.width / 1.5,
                  //   canInteractWhileSpinning: false,
                  //   initialSpinAngle: _randomAngle(),
                  //   dividers: 8,
                  //   shouldStartOrStop: _wheelNotifier.stream,
                  //   spinResistance: 0.2,
                  //   onEnd: _dividerController.add,
                  //   onUpdate: _dividerController.add,
                  // ),Container(
                  // Container(
                  //   height: 200,
                  //   width: 200,
                  //   child: FortuneWheel(
                  //       selected: selectController.stream,
                  //       onAnimationEnd: () {
                  //         setState(() {
                  //           print(selectController);
                  //         });
                  //       },
                  //       rotationCount: rotation_count,
                  //       onFling: () => {
                  //             setState(() {
                  //               selected = selectController as int;
                  //               selected = Random().nextInt(items.length);
                  //               point[selected] = point[selected] + 1;
                  //               print(
                  //                   "Selected value1 $selected ${point[selected]}");
                  //             })
                  //           },
                  //       items: [
                  //         for (var i in items) FortuneItem(child: Text(i)),
                  //       ]),
                  // ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: FortuneWheel(
                        // onAnimationStart: () {
                        //   print(selectController);
                        // },
                        physics: CircularPanPhysics(
                          duration: Duration(minutes: 1),
                          curve: Curves.decelerate,
                        ),
                        // onFling: () {},
                        // styleStrategy:
                        //     AlternatingStyleStrategy(disabledIndices: []),
                        selected: selectController.stream,
                        // animateFirst: false,
                        // onAnimationEnd: () {
                        //   setState(() {
                        //     print(selectController);
                        //   });
                        // },
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
                        items: [
                          for (var i in items)
                            FortuneItem(
                                child: Text(i),
                                style: FortuneItemStyle(
                                    color: Colors.black,
                                    borderColor: Colors.amber,
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                        ]),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      // StreamBuilder(
                      //   stream: _dividerController.stream,
                      //   builder: (c, s) {
                      //     return s.hasData
                      //         ? DisplayResult(s.data)
                      //         : Container();
                      //   },
                      // ),
                      Text('Press the start to spin'),
                      Text("the wheel"),
                      // Text("$select"),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: Theme.of(context).buttonColor,
                        onPressed: () async {
                          setState(() {
                            scroll();
                            // print(result);
                            // print(btnvalue);
                            selected = Random().nextInt(items.length);
                            point[selected] = point[selected] + 1;
                            print(
                                "Selected value1 $selected ${point[selected]}");
                            //   selectController = selected as StreamController<int>;
                            // });
                            selectController.add(Fortune.randomInt(0, 8));
                          });
                        },
                        minWidth: MediaQuery.of(context).size.width / 3.5,
                        child: Text(
                          "Start",
                        ),
                        shape: StadiumBorder(),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scroll() async {
    // ignore: await_only_futures
    // _wheelNotifier.sink.add(_randomVelocity());
    await Future.delayed(const Duration(seconds: 4), () {
      result = r + result;
    });
    _rewardedAd?.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem reward) {});
    // double s = _sigmaValue - r;
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }
}

// return Text(
//   '${label[selected]}',
//   style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
// );
