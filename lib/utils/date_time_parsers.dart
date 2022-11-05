import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime getCurrentDateAndTime() {
  return DateTime.now();
}

/// @func timestampParser() parses timestamp to a String
String timestampDateParser(Timestamp timestamp) {
  DateTime dt = timestamp.toDate();
  String formattedDate = getFormattedDate(dt.toString());
  return formattedDate;
}

/// @func getFormattedDate() parses the date in the given format and then returns it as a String
String getFormattedDate(String date) {
  /// Convert into local date format.
  var localDate = DateTime.parse(date).toLocal();

  /// inputFormat - format getting from api or other func.
  /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
  /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var inputDate = inputFormat.parse(localDate.toString());

  /// outputFormat - convert into format you want to show.
  var outputFormat = DateFormat('dd/MM/yyyy');
  // var outputFormat = DateFormat('dd/mm/yyyy HH:mm');
  var outputDate = outputFormat.format(inputDate);

  return outputDate.toString();
}

String timestampTimeParser(Timestamp timestamp) {
  DateTime dt = timestamp.toDate();

  /// a defines am/pm
  String formattedTime = DateFormat('hh:mm:ss a').format(dt);
  return formattedTime;
}

// String getFormattedTime(String time) {
//   /// Convert into local date format.
//   var localTime = DateTime.parse(time).toLocal();

//   var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
//   var inputTime = inputFormat.parse(localTime.toString());

//   /// outputFormat - convert into format you want to show.
//   var outputFormat = DateFormat('HH:mm');
//   // var outputFormat = DateFormat('dd/mm/yyyy HH:mm');
//   var outputTime = outputFormat.format(inputTime);

//   return outputTime.toString();
// }