import 'package:hive/hive.dart';

part 'history_model.g.dart';

@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  final String from;
  @HiveField(1)
  final String to;
  @HiveField(2)
  final int amount;
  @HiveField(3)
  final double result;
  @HiveField(4)
  final String date;

  HistoryModel({
    required this.from,
    required this.to,
    required this.amount,
    required this.result,
    required this.date,
  });
}
