import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:eraport/app/modules/home/views/home_view.dart';
import 'package:eraport/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyConnectionLogin extends StatefulWidget {
  MyConnectionLogin({
    Key? key,
  }) : super(key: key);

  @override
  _MyConnectionLoginState createState() => _MyConnectionLoginState();
}

class _MyConnectionLoginState extends State<MyConnectionLogin>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 500);

  bool startAnimation = false;
  bool startBroke = false;
  AnimationController? _animationController;
  String _connectionStatus = 'Unknown';
  int status = 0;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      _animationController!.forward();
    });
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return status == 2 ? NoConnectionScreen() : LoginView();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(
          () => status = result.index,
        );
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/1_No Connection.png",
            fit: BoxFit.cover,
          ),
          // Positioned(
          //   bottom: 100,
          //   left: 30,
          //   child: FlatButton(
          //     color: Colors.white,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(50)),
          //     onPressed: () {},
          //     child: Text("Retry".toUpperCase()),
          //   ),
          // )
        ],
      ),
    );
  }
}
