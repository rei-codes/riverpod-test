import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      // (Optional): triggers on every screenshot
      onScreenshot: (String name, List<int> bytes) async {
        final path = 'screenshots/$name.png';
        final image = await File(path).create(recursive: true);
        image.writeAsBytesSync(bytes);
        return true;
      },
    );
  } catch (e) {
    if (kDebugMode) print('Error occured: $e');
  }
}
