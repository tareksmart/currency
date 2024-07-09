import 'package:currencypro/error_handle/failur.dart';
import 'package:currencypro/services/wep_services.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/one_rate.dart';
import 'package:dartz/dartz.dart';

import '../model/currency_data.dart';

class CurrencyRepository {

  Future<Either<Failur, List<CurrencyData>>> getAllCurrency() async {
    try {
  final Map currencies = await CurrencyWebService().getAllCurrencyData();
  CurrencyData currencyData = CurrencyData();
  List<CurrencyData> currency_data = [];
  currencies.forEach((key, value) {
    // print('value:$value['']');
    var curr = CurrencyData(
        currencyCode: value['currencyCode'],
        countryCode: value['countryCode'],
        currencyName: value['currencyName'],
        countryName: value['countryName'],
        icon: value['icon']);
    currency_data.add(curr);
    //  print('key by key $key: ${curr.currencyName}');
  });
  
  return right(currency_data) ;
} on Exception catch (e) {
  // TODO
}
  }

  Future<CurrencyRate> getAllRates() async {
    final rates = await CurrencyWebService().getLatestrates();
    var obj = CurrencyRate.fromJson(rates);

    //l.map((key, value) => CurrencyRate.fromJson(json));
    // print('repo=/////////////////////////////////////');
    // print(obj.eGP);
    // print('repo//////////////////////////');
    return obj;
  }

  Future<OneRate> getOneRates(String symbole) async {
    final rates = await CurrencyWebService().getOneRates(symbole);
    var obj = OneRate.fromMap(rates, symbole);

    //l.map((key, value) => CurrencyRate.fromJson(json));
    // print('repo=/////////////////////////////////////');
    // print(obj.rate);
    // print('repo//////////////////////////');
    return obj;
  }
}
