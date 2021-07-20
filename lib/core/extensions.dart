extension S on DateTime {
  String get ddMonthYYYY => '$day ${getMonthName(month)} $year';
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Ocak';
    case 2:
      return 'Şubat';
    case 3:
      return 'Mart';
    case 4:
      return 'Nisan';
    case 5:
      return 'Mayıs';
    case 6:
      return 'Haziran';
    case 7:
      return 'Temmuz';
    case 8:
      return 'Ağustos';
    case 9:
      return 'Eylül';
    case 10:
      return 'Ekim';
    case 11:
      return 'Kasım';
    case 12:
      return 'Aralık';
    default:
      return '';
  }
}
