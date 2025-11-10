import 'package:flutter_test/flutter_test.dart';
import 'package:clothiva_project/utils/validators/validation.dart';

void main() {
  group('CValidator.validateEmail Tests', () {
    test('Empty email returns error message', () {
      // Act
      final String? result = CValidator.validateEmail('');
      // Assert
      expect(result, 'Email is required.');
    });

    test('Null email returns error message', () {
      // Act
      final String? result = CValidator.validateEmail(null);
      // Assert
      expect(result, 'Email is required.');
    });

    test('Invalid email format returns error message', () {
      // Act
      final String? result = CValidator.validateEmail('hello.com');
      // Assert
      expect(result, 'Invalid email address.');
    });

    test('Valid email returns null (no error)', () {
      // Act
      final String? result = CValidator.validateEmail('test@example.com');
      // Assert
      expect(result, null);
    });
  });

  group('CValidator.validatePassword Tests', () {
    test('Empty password returns error message', () {
      expect(CValidator.validatePassword(''), 'Password is required.');
    });

    test('Short password returns error message', () {
      expect(
        CValidator.validatePassword('123'),
        'Password must be at least 6 characters long.',
      );
    });

    test('Password without uppercase returns error message', () {
      expect(
        CValidator.validatePassword('password123!'),
        'Password must contain at least one uppercase letter.',
      );
    });

    test('Password without number returns error message', () {
      expect(
        CValidator.validatePassword('Password!'),
        'Password must contain at least one number.',
      );
    });

    test('Password without special character returns error message', () {
      expect(
        CValidator.validatePassword('Password123'),
        'Password must contain at least one special character.',
      );
    });

    test('Valid password returns null (no error)', () {
      expect(CValidator.validatePassword('Password123!'), null);
    });
  });
}
