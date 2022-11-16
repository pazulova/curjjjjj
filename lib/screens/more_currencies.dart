import 'package:currency_converter/constants/text_constants.dart';
import 'package:currency_converter/models/my_currencies_model.dart';
import 'package:currency_converter/services/fetch_currencies.dart';
import 'package:currency_converter/store/my_currencies_store.dart';
import 'package:currency_converter/theme/colors.dart';
import 'package:currency_converter/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class MoreCurrencies extends StatefulWidget {
  

  @override
  State<MoreCurrencies> createState() => _MoreCurrenciesState();
}

class _MoreCurrenciesState extends State<MoreCurrencies> {
  List? currencies;
  MyCurDataStore dataStore = MyCurDataStore();

  Future<void> getCurrencyList() async {
    final allCurrencies = await fetchCurrencies();
    currencies = allCurrencies;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrencyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.allCurencies,
          style: AppTextStyles.titleStyle,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        color: AppColors.mainColor,
        child: currencies == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                      child: ValueListenableBuilder(
                    valueListenable:
                        MyCurDataStore.boxCurrency.listenable(),
                    builder: ((context, Box box, widget) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: currencies?[0].length,
                          itemBuilder: (BuildContext context, int index) {
                            var curencyKey = currencies![0][index];
                            var curencyVal = currencies![1][index];
                            var isFavorite = box.get(index) != null;

                            return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 3,
                              child: ListTile(
                                autofocus: false,
                                title: Text('$curencyKey'),
                                subtitle: Text('$curencyVal'),
                                trailing: IconButton(
                                  onPressed: () {
                                    MyCurModel myCrMod =
                                        MyCurModel(
                                     currencyName: curencyKey);
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();

                                    if (isFavorite) {
                                      dataStore.deleteCurrency(index: index);
                                      const snackBar = SnackBar(
                                        content: Text(AppText.reSuccess),
                                        backgroundColor: AppColors.mainColor,
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      dataStore.addCurrency(
                                          myCurrenciesBox: myCrMod,
                                          index: index);
                                      const snackBar = SnackBar(
                                        content: Text(AppText.addSuccess),
                                        backgroundColor: AppColors.mainColor,
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
                  )),
                ],
              ),
      ),
    );
  }
}
