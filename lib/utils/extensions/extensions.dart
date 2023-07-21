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
