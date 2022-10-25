class CurrencyData {
   String? currencyCode;
   String? currencyName;
   String? icon;
   String? countryCode;
   String? countryName;

  CurrencyData(
      { this.currencyCode,
         this.currencyName,
         this.icon,
         this.countryCode,
         this.countryName});

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
      currencyCode: map['currencyCode'] ,
      currencyName: map['currencyName'] ,
      icon: map['icon'] ,
      countryCode: map['countryCode'] ,
      countryName: map['countryName'] ,
    );
  }
}
