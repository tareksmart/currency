class CurrencyData {
  String? currencyCode;
  String? currencyName;
  String? countryCode;
  String? countryName;
  String? status;
  String? availableFrom;
  String? availableUntil;
  String? icon;

  CurrencyData(
      {this.currencyCode,
      this.currencyName,
      this.countryCode,
      this.countryName,
      this.status,
      this.availableFrom,
      this.availableUntil,
      this.icon});

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    // currencyCode = json['currencyCode'];
    // currencyName = json['currencyName'];
    // countryCode = json['countryCode'];
    // countryName = json['countryName'];
    // status = json['status'];
    // availableFrom = json['availableFrom'];
    // availableUntil = json['availableUntil'];
    // icon = ;
    return CurrencyData(
        countryCode: json['currencyCode'], countryName: json['countryName'],currencyName:json['currencyName'],
        currencyCode: json['countryCode'] ,icon: json['countryCode']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currencyCode'] = this.currencyCode;
    data['currencyName'] = this.currencyName;
    data['countryCode'] = this.countryCode;
    data['countryName'] = this.countryName;
    data['status'] = this.status;
    data['availableFrom'] = this.availableFrom;
    data['availableUntil'] = this.availableUntil;
    data['icon'] = this.icon;
    return data;
  }
}
