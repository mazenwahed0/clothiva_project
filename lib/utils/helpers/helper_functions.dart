import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class CHelperFunctions {
  // Function to get color based on string input (product specific colors)
  static Color? getColor(String value) {
    switch (value.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'pink':
        return Colors.pink;
      case 'grey':
        return Colors.grey;
      case 'purple':
        return Colors.purple;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'brown':
        return Colors.brown;
      case 'teal':
        return Colors.teal;
      case 'indigo':
        return Colors.indigo;
      case 'amber':
        return Colors.amber;
      case 'cyan':
        return Colors.cyan;
      case 'deeporange':
        return Colors.deepOrange;
      case 'deeppurple':
        return Colors.deepPurple;
      case 'lime':
        return Colors.lime;
      case 'lightblue':
        return Colors.lightBlue;
      case 'lightgreen':
        return Colors.lightGreen;
      case 'orange':
        return Colors.orange;
      case 'pinkaccent':
        return Colors.pinkAccent;
      case 'purpleaccent':
        return Colors.purpleAccent;
      case 'redaccent':
        return Colors.redAccent;
      case 'tealaccent':
        return Colors.tealAccent;
      case 'yellow':
        return Colors.yellow;
      case 'yellowaccent':
        return Colors.yellowAccent;
      case 'transparent':
        return Colors.transparent;
      case 'bluegrey':
        return Colors.blueGrey;
      case 'lightblueaccent':
        return Colors.lightBlueAccent;
      case 'lightgreenaccent':
        return Colors.lightGreenAccent;
      case 'dark blue':
        return const Color.fromARGB(255, 2, 39, 102);
      case 'limeaccent':
        return Colors.limeAccent;
      case 'orangeaccent':
        return Colors.orangeAccent;
      case 'amberaccent':
        return Colors.amberAccent;
      case 'blueaccent':
        return Colors.blueAccent;
      case 'cyanaccent':
        return Colors.cyanAccent;
      case 'greenaccent':
        return Colors.greenAccent;
      case 'indigoaccent':
        return Colors.indigoAccent;
      default:
        return null; // Return null if no match
    }
  }

  // Function to show a Snackbar
  static void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: CColors.darkerGrey,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      isDismissible: true,
      duration: const Duration(seconds: 3),
    );
  }

  // Function to show an Alert Dialog
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      // 5AM to 12PM
      return 'Good Morning';
    } else if (hour >= 12 && hour < 16) {
      // 12PM to 4PM
      return 'Good Afternoon';
    } else if (hour >= 16 && hour < 19) {
      // 5PM to 7PM
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  /// Function to convert asset to file
  static Future<File> assetToFile(String assetPath) async {
    // Load asset bytes
    final byteData = await rootBundle.load(assetPath);

    // Get temp directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    // Write bytes to temp file
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file;
  }

  // Function to format date into a specific format
  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) {
    return DateFormat(format).format(date);
  }
}
