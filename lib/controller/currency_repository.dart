import 'package:currencypro/controller/wep_services.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/one_rate.dart';

import '../model/currency_data.dart';

class CurrencyRepository {
  final CurrencyWebService webService;

  CurrencyRepository({required this.webService});

  Future<List<CurrencyData>> getAllCurrency() async {
    final currencies = await webService.getAllCurrencyData();

    var currToLoist = currencies.map((currency) {
      //  print('repo============================');
      // print(currency);
      //print('repo============================');
      return CurrencyData.fromMap(currency);
    }).toList();

    return currToLoist;
  }

  Future<CurrencyRate> getAllRates() async {
    final rates = await webService.getLatestrates();
    var obj = CurrencyRate.fromJson(rates);

    //l.map((key, value) => CurrencyRate.fromJson(json));
    print('repo=/////////////////////////////////////');
    print(obj.eGP);
    print('repo//////////////////////////');
    return obj;
  }

  Future<OneRate> getOneRates(String symbole) async {
    final rates = await webService.getOneRates(symbole);
    var obj = OneRate.fromMap(rates, symbole);

    //l.map((key, value) => CurrencyRate.fromJson(json));
    print('repo=/////////////////////////////////////');
    print(obj.rate);
    print('repo//////////////////////////');
    return obj;
  }
}
