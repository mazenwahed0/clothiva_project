import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      case 'deepOrange':
        return Colors.deepOrange;
      case 'deepPurple':
        return Colors.deepPurple;
      case 'lime':
        return Colors.lime;
      case 'lightBlue':
        return Colors.lightBlue;
      case 'lightGreen':
        return Colors.lightGreen;
      case 'orange':
        return Colors.orange;
      case 'pinkAccent':
        return Colors.pinkAccent;
      case 'purpleAccent':
        return Colors.purpleAccent;
      case 'redAccent':
        return Colors.redAccent;
      case 'tealAccent':
        return Colors.tealAccent;
      case 'yellow':
        return Colors.yellow;
      case 'yellowAccent':
        return Colors.yellowAccent;
      case 'transparent':
        return Colors.transparent;
      case 'blueGrey':
        return Colors.blueGrey;
      case 'lightBlueAccent':
        return Colors.lightBlueAccent;
      case 'lightGreenAccent':
        return Colors.lightGreenAccent;
      case 'limeAccent':
        return Colors.limeAccent;
      case 'orangeAccent':
        return Colors.orangeAccent;
      case 'amberAccent':
        return Colors.amberAccent;
      case 'blueAccent':
        return Colors.blueAccent;
      case 'cyanAccent':
        return Colors.cyanAccent;
      case 'greenAccent':
        return Colors.greenAccent;
      case 'indigoAccent':
        return Colors.indigoAccent;
      default:
        return null; // Return null if no match
    }
  }

  // Function to show a Snackbar
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
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

  // Function to navigate to a new screen
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Function to truncate text if it exceeds a max length
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  // (Replaced in context.isDarkMode for Get Package)
  // Function to check if Dark Mode is enabled
  // That's not working well:
   static bool isDarkMode(BuildContext context) {
     return Theme.of(context).brightness == Brightness.dark;
   }
  // Working well!
  // static bool isDarkMode(BuildContext context) {
  //   return MediaQuery.of(context).platformBrightness == Brightness.dark;
  // }

  // Function to get screen height
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  // Function to get screen width
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  // Function to format date into a specific format
  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  // Function to remove duplicates from a list
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  // Function to wrap widgets into rows with a specified size
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
