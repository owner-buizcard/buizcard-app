

import 'package:intl/intl.dart';

String formatDate(dateString){
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MMM').format(dateTime);
}