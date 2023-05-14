import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;
  final String title;

  const WebView({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() {
    return _WebViewState();
  }
}

class _WebViewState extends State<WebView> {
  final WebViewController _controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // 左侧图标，自定义
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 判断是否返回浏览器上一级或者退出页面
            _controller.canGoBack().then((value) {
              if (value) {
                _controller.goBack();
              } else {
                return Navigator.pop(context);
              }
            });
          },
        ),
      ),
      // Expanded撑满界面
      body: WebViewWidget(controller: _controller),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setBackgroundColor(const Color(0x00000000));
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onUrlChange: (UrlChange change) {
          // url发生变化
          // 第一次也会触发
        },
        onPageStarted: (String url) {
          // 页面开始加载
        },
        onPageFinished: (String url) {
          // 页面加载完毕
        },
        onWebResourceError: (WebResourceError error) {
          // 页面加载失败
        },
        // onNavigationRequest: (NavigationRequest request) {
        //   if (request.url.startsWith('https://www.youtube.com/')) {
        //     return NavigationDecision.prevent;
        //   }
        //   return NavigationDecision.navigate;
        // },
      ),
    );
    // 加载网页
    _controller.loadRequest(Uri.parse(widget.url));
  }
}
