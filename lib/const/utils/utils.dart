
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatDateTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDateTime = DateFormat('M/d/yyyy h:mm a').format(dateTime);
    return formattedDateTime;
  }

  static bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }
}