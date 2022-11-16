
import 'package:currency_converter/models/my_currencies_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class MyCurDataStore {
  static const myCurrenciesBox = "myCurrenciesBox";
  static Box<MyCurModel> boxCurrency =
      Hive.box<MyCurModel>(myCurrenciesBox);

  Future<void> addCurrency(
      {required MyCurModel myCurrenciesBox, required int index}) async {
    await boxCurrency.put(index, myCurrenciesBox);
  }

  Future<void> deleteCurrency({required int index}) async {
    await boxCurrency.delete(index);
  }
}
