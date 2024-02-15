

class SFormatter {


  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
     if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
    // Not fully tested.
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from the digitsOnly
    String countryCode = digitsOnly.substring(0, 2);
    digitsOnly = digitsOnly.substring(2);

    // Format international phone number with country code
    return '+$countryCode $digitsOnly';
  }
}
