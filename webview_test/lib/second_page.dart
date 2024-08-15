import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // This is for the svg picture
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_test/webview.dart';

class second_page extends StatefulWidget{
  late WebViewController webController;
 //final String uriString;
  bool internetConnected = true;

  second_page({required this.webController, super.key});

  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<second_page>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.internetConnected){
      return SafeArea(
        child: WebviewWidget(webViewCtrl: widget.webController,) 
      );
    } else {
      return PlatformText("No internet connection detected");
    }
  }

  @override
  dispose() {
    super.dispose();
  }
}