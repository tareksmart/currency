import 'package:currencypro/controller/wep_services.dart';

import '../model/currency_data.dart';

class CurrencyRepository{
  final CurrencyWebService webService;

  CurrencyRepository(this.webService);
  Future<List<CurrencyData>> getAllCurrency ()async{
final currencies=await webService.getAllCurrencyData();
var currToLoist=currencies.map((currency) => CurrencyData.fromMap(currency)).toList();
return currToLoist;
  }
}