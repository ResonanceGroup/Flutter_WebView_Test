// See here for a webview in flutter: https://codelabs.developers.google.com/codelabs/flutter-webview#0
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // This is for the svg picture
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  final WebViewController wvController;
  const NavigationControls({required this.wvController, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = (Theme.of(context).brightness == Brightness.dark);
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () async {
            var returnValue = wvController.canGoBack();
            var someURL = await wvController.currentUrl();
            returnValue.then((value){
              print("Can go back: $value");
              print("URL: $someURL");
              wvController.goBack();
            });
          },
          icon: SvgPicture.asset(
            "assets/icons/back_arrow.svg",
            width: 25,
            height: 25,
            colorFilter: (isDarkMode)
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),
        IconButton(
          onPressed: () async {
            if (await wvController.canGoForward()) {
              await wvController.goForward();
            }
          },
          icon: SvgPicture.asset(
            "assets/icons/forward_button.svg",
            width: 25,
            height: 25,
            colorFilter: (isDarkMode)
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),
        IconButton(
          onPressed: () {
            wvController.reload();
          },
          icon: SvgPicture.asset(
            "assets/icons/refresh_button.svg",
            width: 25,
            height: 25,
            colorFilter: (isDarkMode)
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}

class WebViewStack extends StatefulWidget {
  final WebViewController wvController;
  bool isFinishedLoading = false;
  WebViewStack({required this.wvController, super.key});

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  int loadingPercent = 0;

  @override
  void initState() {
    super.initState();
    widget.wvController.setNavigationDelegate(
      
      NavigationDelegate(
        onUrlChange: (change) {
          print("URL changed: ${change.url}");
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageFinished: (url) {
          print("Page finished loading: $url");
          this.setState(() {
            widget.isFinishedLoading = true;
          });
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
          controller: widget.wvController,
      );
  }
}

class WebviewWidget extends StatelessWidget {
  late WebViewController webViewCtrl;
  //final String uriParameter;
  WebviewWidget({required this.webViewCtrl, super.key});

  WebViewController getController(){
    return webViewCtrl;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = (Theme.of(context).brightness == Brightness.dark);
    webViewCtrl.reload();
    return WebViewStack(
        wvController: webViewCtrl,
      );
  }
}
