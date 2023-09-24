/// Extension adding an ability to get initials from a [String].
extension InitialsExtension on String {
  /// Returns initials (two letters which begin each word) of this string.
  String initials() {
    List<String> words = split(' ').where((e) => e.isNotEmpty).toList();

    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      if (words[0].length >= 2) {
        return '${words[0][0].toUpperCase()}${words[0][1].toLowerCase()}';
      } else {
        return words[0].toUpperCase();
      }
    }

    return '';
  }

  String formatPhoneNumber() {
    // Удаление всех символов, кроме цифр
    String digitsOnly = replaceAll(RegExp(r'[^0-9]'), '');

    // Проверка длины строки
    if (digitsOnly.length == 11) {
      // Форматирование номера с 11 цифрами (начинается с "7")
      return '+7 (${digitsOnly.substring(1, 4)}) ${digitsOnly.substring(4, 7)}-${digitsOnly.substring(7, 9)}-${digitsOnly.substring(9)}';
    } else if (digitsOnly.length == 10) {
      // Форматирование номера с 10 цифрами (не начинается с "7")
      return '+7 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, 8)}-${digitsOnly.substring(8)}';
    } else {
      // Номер не соответствует требуемым длинам
      return this;
    }
  }
}

/// Extension adding an ability to get a sum of [String] code units.
extension SumStringExtension on String {
  /// Returns a sum of [codeUnits].
  int sum() => codeUnits.fold(0, (a, b) => a + b);
}
