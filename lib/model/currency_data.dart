class CurrencyData {
  final String currencyCode;
  final String currencyName;
  final String icon;
  final String countryCode;
  final String countryName;

  CurrencyData(
      {required this.currencyCode,
        required this.currencyName,
        required this.icon,
        required this.countryCode,
        required this.countryName});

  Map<String, dynamic> toMap() {
    return {
      'currencyCode': this.currencyCode,
      'currencyName': this.currencyName,
      'icon': this.icon,
      'countryCode': this.countryCode,
      'countryName': this.countryName,
    };
  }

  factory CurrencyData.fromMap(Map<String, dynamic> map) {
    return CurrencyData(
      currencyCode: map['currencyCode'] as String,
      currencyName: map['currencyName'] as String,
      icon: map['icon'] as String,
      countryCode: map['countryCode'] as String,
      countryName: map['countryName'] as String,
    );
  }
}
