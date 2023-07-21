import 'package:flutter/material.dart';

extension RuLocaleDateTimeConvertor on DateTime {
  static const namesOfMonths = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря'
  ];

  String toRuLocale() {
    return '$day ${namesOfMonths[month - 1]} $year';
  }
}

extension ColorExtension on String {
  Color? toColor() {
    if (isEmpty) {
      return null;
    }
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst(RegExp('#|0x'), ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
