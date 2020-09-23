import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<int> _showRewardedAlt() async {
    var completer = Completer<int>();

    AdmobReward rewardAd;
    rewardAd = AdmobReward(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        print('>>>>EVENT ARGS $args');
        switch (event) {
          case AdmobAdEvent.rewarded:
            completer.complete(args["rewardAmount"]);
            break;

          case AdmobAdEvent.clicked:
          case AdmobAdEvent.impression:
          case AdmobAdEvent.opened:
          case AdmobAdEvent.started:
          case AdmobAdEvent.completed:
            print('New reward event: $event');
            break;

          case AdmobAdEvent.failedToLoad:
          case AdmobAdEvent.leftApplication:
          case AdmobAdEvent.closed:
            print('Rewarded event ERROR with $event');
            completer.completeError(event);
            break;

          case AdmobAdEvent.loaded:
            print('CARREGOU');
            rewardAd.show();
            break;
        }
      },
    );

    rewardAd.load();
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Demo the AdmobReward'),
            RaisedButton(
              child: Text('_showRewardedAlt'),
              onPressed: () {
                _showRewardedAlt().then((value) => print('>>>value: $value'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
