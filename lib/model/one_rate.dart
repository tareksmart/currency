class OneRate {
  String? rate;

  OneRate({this.rate});

  Map<String, dynamic> toMap() {
    return {
      'rate': this.rate,
    };
  }

  factory OneRate.fromMap(Map<String, dynamic> map, String symbole) {
    return OneRate(rate: map['$symbole']);
  }
}
