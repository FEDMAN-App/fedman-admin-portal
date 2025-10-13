import 'package:intl/intl.dart';


// 'yyyy-MM-dd' will format the date as 2023-10-05.
//
// 'MM/dd/yyyy' will format the date as 10/05/2023.
//
// 'dd MMM yyyy' will format the date as 05 Oct 2023.
String? formatDate(DateTime? date, String format) {
  if(date != null){

    // Create a DateFormat object with the provided format string
    DateFormat formatter = DateFormat(format);

    // Format the date and return the result as a string
    return formatter.format(date);
  }else{
  return  null;
  }
}

