import 'package:flet/flet.dart';
import 'package:flutter/material.dart';

import 'webview_mobile_and_mac.dart';
import 'webview_web.dart' if (dart.library.io) "webview_web_vain.dart";
import 'webview_windows_and_linux.dart'
    if (dart.library.html) "webview_windows_and_linux_vain.dart";

class WebViewControl extends StatelessWidget {
  final Control control;

  const WebViewControl({super.key, required this.control});

  Control focusWrap(Control control) {
    return Focus(
      onKey: (node, event) {
        // Allow webview to handle cursor keys. Without this, the
        // arrow keys seem to get "eaten" by Flutter and therefore
        // never reach the webview.
        // (https://github.com/flutter/flutter/issues/102505).
        if ({
          LogicalKeyboardKey.arrowLeft,
          LogicalKeyboardKey.arrowRight,
          LogicalKeyboardKey.arrowUp,
          LogicalKeyboardKey.arrowDown
        }.contains(event.logicalKey)) {
          return KeyEventResult.skipRemainingHandlers;
        }
      },
      child: control
    )
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("WebViewControl build: ${control.id}");
    Widget view =
        const ErrorControl("Webview is not yet supported on this platform.");
    if (isWebPlatform()) {
      view = WebviewWeb(control: control);
    } else if (isMobilePlatform() || isMacOSDesktop()) {
      view = focusWrap(control: WebviewMobileAndMac(control: control));
    } else if (isWindowsDesktop() || isLinuxDesktop()) {
      view = const WebviewDesktop();
    }

    return LayoutControl(control: control, child: view);
  }
}
