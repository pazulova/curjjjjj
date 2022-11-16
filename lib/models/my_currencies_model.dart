import 'package:hive/hive.dart';

part 'my_currencies_model.g.dart';

@HiveType(typeId: 1)
class MyCurModel extends HiveObject {
  @HiveField(0)
  final String currencyName;
  MyCurModel({
    required this.currencyName,
  });
}
