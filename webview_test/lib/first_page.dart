import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // This is for the svg picture
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_test/webview.dart';


class firstPage extends StatefulWidget{
  late WebViewController webController;
  bool internetConnected = false;

  firstPage({required this.webController, super.key});

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<firstPage>{

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
