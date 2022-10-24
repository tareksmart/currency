import 'package:currencypro/utilities/api_links.dart';
import 'package:dio/dio.dart';

class CurrencyWebService {
  late Dio dio;
  CurrencyWebService() {
    BaseOptions options = BaseOptions(
        baseUrl: ApiLinks.apiLink,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);

    dio=Dio(options);
  }
  Future<List<dynamic>> getAllCurrencyData()async{
    try{
      var response=await dio.get('supported-currencies');
      print(response.data+'===========');
      return response.data;

    }
    on Exception catch(e){print('$e');return [];}
  }
}
