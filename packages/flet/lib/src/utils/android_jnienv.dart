import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';


const nativeChannel = MethodChannel('flet_native_channel');


Future<int> androidGetJNIEnv() async {
  try {
    final int result = await nativeChannel.invokeMethod('androidGetJNIEnv');
    return result;
  } catch (e) {
    debugPrint('Error calling native androidGetJNIEnv: $e');
    return 0;
  }
}
