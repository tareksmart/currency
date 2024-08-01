import 'package:currencypro/utilities/api_links.dart';
import 'package:dio/dio.dart';

class CurrencyWebService {
  late Dio dio;
  CurrencyWebService() {
    BaseOptions options = BaseOptions(
        baseUrl: ApiLinks.apiLink,
        receiveDataWhenStatusError: true,
        connectTimeout:const Duration(seconds: 20*1000),
        receiveTimeout: const Duration(seconds: 20*1000));

    dio = Dio(options);
  }
  Future<dynamic> getAllCurrencyData() async {
    
      var response = await dio.get(ApiLinks.currencyData);
     //  print('web===========');
      // print(response.data['supportedCurrenciesMap']);
      // print('web===========');
      return response.data['supportedCurrenciesMap'];
    
  }

  Future<dynamic> getLatestrates() async {
   
      var response = await dio.get(ApiLinks.currencyRates);
     // print('Rates web**********************************');
    //  print(response.data["rates"]);
    //  print('Rates*********************************');
      return response.data["rates"];
   
  }
 

  Future<dynamic> getOneRates(String symbole) async {
    try {
      var response = await dio.get(ApiLinks.currencyOneRates + symbole);
      // print('web**********************************');
      // print(response.data["rates"]);
      // print('web*********************************');
      return response.data["rates"];
    } on Exception catch (e) {
      print('$e');
      return [];
    }
  }
}
