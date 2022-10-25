import 'package:currencypro/controller/wep_services.dart';

import '../model/currency_data.dart';

class CurrencyRepository {
  final CurrencyWebService webService;

  CurrencyRepository({required this.webService});

  Future<List<CurrencyData>> getAllCurrency() async {
    final currencies = await webService.getAllCurrencyData();

    var currToLoist =
        currencies.map((currency) {
        //  print('repo============================');
         // print(currency);
          //print('repo============================');
          return CurrencyData.fromMap(currency);
        }).toList();

    return currToLoist;
  }
}
