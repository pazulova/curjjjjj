import 'package:currency_converter/constants/api_constants.dart';
import 'package:dio/dio.dart';

Future<List> fetchCurrencies() async {
  Dio dio = new Dio();
  // dio.options.headers["apikey"] = "${ApiConst.apiKey}";
  var response = await dio.get(ApiConst.allSymbols);
  var resData = response.data;
  if (response.statusCode == 200) {
    var list = resData["Сандар"];
    List currenciesKey = (list.keys).toList();
    List currenciesVal = (list.values).toList();

    return [currenciesKey, currenciesVal];
  } else {
    throw Exception("Failed to connect to API");
  }
}
