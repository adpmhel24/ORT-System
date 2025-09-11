import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:intl/intl.dart';

class Utils {
  static String formatPrice([double? price = 0]) =>
      'P ${price!.toStringAsFixed(2)}';
  static String formatAmount(double? dataAmount,
      {bool hasCurrency = false, int decimalPlaces = 2}) {
    double amount = dataAmount ?? 0.00;

    String currency = 'P ';
    var newValue = '';
    final f = NumberFormat.currency(
        locale: 'en_US', decimalDigits: decimalPlaces, symbol: '');
    var num = double.parse(amount.toString().replaceAll(',', ''));
    if (hasCurrency) {
      newValue = currency + f.format(num).trim();
    } else {
      newValue = f.format(num).trim();
    }

    return newValue;
  }

  static String formatDate(DateTime? date, [String? format = "MM/dd/yyyy"]) =>
      date != null ? DateFormat(format).format(date) : "";

  static String formatDateTime(DateTime? date, [bool withTime = true]) =>
      date != null
          ? DateFormat('MM/dd/yyyy${withTime ? " hh:mm aaa" : ""}').format(date)
          : "";
}

class Constant {
  static const contentBackGroundColor = Color(0xFFFDEFF4);
  static const cardBackgroundColor = Color.fromARGB(255, 74, 75, 89);
  static const modalBackground = Color(0xFFF7F7F7);
  static const rowSpacer = SizedBox(width: 10);
  static const primaryBgColor = Color(0xFFF7F7F7);
  static const secondaryBgColor = Color(0xFFF7ECDE);
  static const menuTextColor = Color(0xFF603601);
  static const onSelectedColor = Color(0xFFD67D3E);
  static const double minPadding = 10.0;
  static const SizedBox heightSpacer = SizedBox(height: 10);
  static const SizedBox widthSpacer = SizedBox(width: 10);
  static var dataTableHeaderRow = m.WidgetStateProperty.resolveWith(
    (states) => const Color.fromARGB(255, 172, 164, 157),
  );
}
