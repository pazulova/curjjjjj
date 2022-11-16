import 'package:currency_converter/models/history_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const historyBox = "historyBox";
  static Box<HistoryModel> box = Hive.box<HistoryModel>(historyBox);

  Future<void> addHistory({required HistoryModel historyModel}) async {
    await box.add(historyModel);
  }

  Future<void> deleteHistory({required int index}) async {
    await box.deleteAt(index);
  }
}
