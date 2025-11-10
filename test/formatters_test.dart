import 'package:flutter_test/flutter_test.dart';
import 'package:clothiva_project/utils/formatters/formatters.dart';

void main() {
  group('CFormatter Tests', () {
    test('formatDate formats DateTime correctly', () {
      final date = DateTime(2025, 10, 20);
      expect(CFormatter.formatDate(date), '20-Oct-2025');
    });

    test('formatPhoneNumber formats 10-digit number', () {
      expect(CFormatter.formatPhoneNumber('1234567890'), '(123) 456 7890');
    });
  });
}
