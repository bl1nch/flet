import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

import 'utils/platform.dart';

const fletPlatformChannel = MethodChannel('fletPlatformChannel');

Future<String?> callPlatformMethodWithResult(String methodName) async {
  final String? result = await fletPlatformChannel.invokeMethod<String?>(methodName);
  return result;
}

Future setupDesktop() async {
  if (isDesktopPlatform()) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    Map<String, String> env = Platform.environment;
    var hideWindowOnStart = env["FLET_HIDE_WINDOW_ON_START"];
    debugPrint("hideWindowOnStart: $hideWindowOnStart");

    await windowManager.waitUntilReadyToShow(null, () async {
      if (hideWindowOnStart == null) {
        await windowManager.show();
        await windowManager.focus();
      }
    });
  }
}
