class ApiLinks {
  static const String apiLink = 'https://api.currencyfreaks.com/v2.0/';

  static const String apiKey = '98cde01776bf4d4c9b484681f45b0ecc';
  static const String currencyData =
      '${apiLink}supported-currencies';
  static const String currencyRates = 'rates/latest?apikey=$apiKey';
  static const String currencyOneRates = 'rates/latest?apikey=$apiKey&symbols=';
}
