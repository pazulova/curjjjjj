import 'package:currency_converter/constants/api_constants.dart';
import 'package:currency_converter/models/curreccy_result.dart';
import 'package:dio/dio.dart';

Future<CurrencyResult?> getRate(String from, String to, String amount) async {
  Dio dio = new Dio();
  // dio.options.headers["apikey"] = "${ApiConst.apiKey}";
  final response = await dio
      .get('${ApiConst.convertFromTo}from=$from&to=$to&amount=$amount');
  var resData = response.data;
  if (response.statusCode == 200) {
    // Map<String, dynamic> mapForm = Map<String, dynamic>.from(resData);
    final currencyObj = CurrencyResult.fromJson(resData);

    return currencyObj;
  } else {
    throw Exception("Failed to connect to API");
  }
}
