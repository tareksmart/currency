import 'package:currencypro/error_handle/failur.dart';
import 'package:currencypro/model/currency_rates_model.dart';
import 'package:currencypro/services/wep_services.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/one_rate.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

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

      return right(currency_data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailur.fromDioError(e));
      }
      return left(ServerFailur(
          errorMessage: 'Oops there was an error please try later'));
    }
  }

  Future<Either<Failur, CurrencyRatesModel>> getAllRates() async {
    try {
      final rates = await CurrencyWebService().getLatestrates();
      var data = CurrencyRatesModel.fromJson(rates);
      //  CurrencyRate.fromJson(rates);//تحويلها الى ماب
     // Map<String, dynamic> data = obj.rates;
      print('*************data rates $data');
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailur.fromDioError(e));
      }
      return left(ServerFailur(
          errorMessage: 'Oops there was an error please try later'));
    }
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
