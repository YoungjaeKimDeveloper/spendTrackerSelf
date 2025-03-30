import 'package:intl/intl.dart';

double convertStringToDouble(String string) {
  // Null 값이 반환될수도 있기때문임
  double? amount = double.tryParse(string);
  return amount ?? 0;
}

String dollarForamt(double number) {
  String formateedAmount = NumberFormat.simpleCurrency(
    locale: "en_us",
  ).format(number);
  return formateedAmount;
}
