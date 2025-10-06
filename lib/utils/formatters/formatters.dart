import 'package:intl/intl.dart';

class CFormatter {
  // Format Date And Time
  static String formatDateAndTime(DateTime? date,
      {bool use24HourFormat = false}) {
    date ??= DateTime.now();
    final onlyDate = DateFormat('dd/MM/yyyy').format(date);
    // Use 'hh:mm a' for 12-hour with AM/PM, or 'HH:mm' for 24-hour format.
    final timeFormat = use24HourFormat ? 'HH:mm' : 'hh:mm a';
    final onlyTime = DateFormat(timeFormat).format(date);
    return '$onlyDate at $onlyTime';
  }

  // Format Date
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Customize the date format as needed
  }

  // Format Currency
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }
  // // Format Phone Number (for Egypt +20 by default)
  // static String formatPhoneNumber(String phoneNumber) {
  //   // Remove all non-numeric characters
  //   phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

  //   // Check if it's a valid 11-digit phone number starting with 01 (local Egyptian numbers)
  //   if (phoneNumber.length == 11 && phoneNumber.startsWith('01')) {
  //     return '+20 (${phoneNumber.substring(1, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
  //   } else {
  //     return phoneNumber; // If it's invalid, just return it as is
  //   }
  // }

  /// Concatenate phone number and country code
  static String formatPhoneNumberWithCountryCode(
      String countryCode, String phoneNumber) {
    // Remove leading zero if present
    // if (phoneNumber.startsWith('0')) {
    //   phoneNumber = phoneNumber.substring(1);
    // }

    // Combine country code and phone number
    return '$countryCode$phoneNumber';
  }
}
