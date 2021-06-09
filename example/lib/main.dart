import 'package:flutter_appcenter/flutter_appcenter_bundle.dart';
import 'package:flutter/material.dart';

void main() {
  AppCenter.startAsync(
      appSecretAndroid: "appSecretAndroid", appSecretIOS: "appSecretIOS");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('App center SDK test'),
        ),
      ),
    );
  }
}
