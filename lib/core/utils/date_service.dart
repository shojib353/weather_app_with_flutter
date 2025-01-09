import 'package:intl/intl.dart';
String formatDate(String localtime) {
  try {
    DateTime date = DateTime.parse(localtime);  // Parse the string to DateTime
    // Format: Day of the week, Day Month Year (e.g., "Monday, 8 January 2025")
    return DateFormat('d MMMM, EEEE').format(date);
  } catch (e) {
    return 'Invalid Date';  // In case parsing fails
  }
}


String formatHourWithAMPM(String localtime) {
  try {
    DateTime date = DateTime.parse(localtime);  // Parse the string to DateTime
    // Format: Hour with AM/PM (e.g., "2 PM")
    return DateFormat('h a').format(date);  // 'h' for 12-hour format and 'a' for AM/PM
  } catch (e) {
    return 'Invalid Time';  // In case parsing fails
  }
}


String getDayName(String dateString) {
  try {
    // Parse the date string
    DateTime date = DateTime.parse(dateString);
    // Format to get the day name (e.g., "Monday")
    return DateFormat('EEEE').format(date);
  } catch (e) {
    // Return a default value if parsing fails
    return 'Invalid Date';
  }
}
