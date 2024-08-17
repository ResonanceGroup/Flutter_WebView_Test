import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart'; // This is for the svg picture
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_test/first_page.dart';
import 'package:webview_test/second_page.dart';
import 'package:webview_test/webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class webviewPages extends StatelessWidget{
  


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  final WebViewController firstPageWebController = WebViewController()
  ..loadRequest(Uri.parse("https://www.juicehouse.org/juicepress-index-app/"))
  ..setJavaScriptMode(JavaScriptMode.unrestricted);
  
  final WebViewController secondPageWebController = WebViewController()
  ..loadRequest(Uri.parse("https://forum.juicehouse.org"))
  ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late Widget displayedWidget;

   List<String> labelList = ["First Page", "Second Page"]; // This list here is in the same order as the tabs

  var _tabSelectedIndex = 0;
  String navBarTitle = "";

   setSelectedIndexState(int index){
    setState(() {
      getTabScreen(index);
      _tabSelectedIndex = index;
      navBarTitle = labelList[index];
    });
  }

  @override
  void initState(){
    super.initState();
    displayedWidget = firstPage(webController: widget.firstPageWebController);
    setSelectedIndexState(_tabSelectedIndex); // Just Added
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return PlatformScaffold (
      appBar: PlatformAppBar(
        title: Text(navBarTitle),
        //trailingActions: [NavigationControls(wvController: (_tabSelectedIndex == 0) ? widget.firstPageWebController : widget.secondPageWebController)],
      ),
      body: displayedWidget,
      bottomNavBar: PlatformNavBar(
        currentIndex: _tabSelectedIndex,
        itemChanged: (index){
          setSelectedIndexState(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home_outline.svg',
              height: 25,
              ),
            label: "First Page",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/blender_outline.svg',
              height: 25,
            ),
            label: "Second Page",
          ),
        ],
      ),
    );
  }

  getTabScreen(int tabIndex){
    switch(tabIndex){
      case 0:
        displayedWidget = firstPage(webController: widget.firstPageWebController);
        break;
      case 1:
        displayedWidget = second_page(webController: widget.secondPageWebController);
        break;
      default:
        displayedWidget = firstPage(webController: widget.firstPageWebController);
        break;
    }
  }
}
