import 'package:currency_converter/constants/text_constants.dart';
import 'package:currency_converter/store/my_currencies_store.dart';
import 'package:currency_converter/theme/colors.dart';
import 'package:currency_converter/theme/text_style.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../services/fetch_currencies.dart';
import 'more_currencies.dart';

class MyCurrenciesPage extends StatefulWidget {
  //  MyCurrenciesPage({super.key});

  @override
  State<MyCurrenciesPage> createState() => _MyCurrenciesPageState();
}

class _MyCurrenciesPageState extends State<MyCurrenciesPage> {
  final MyCurDataStore dataStore = MyCurDataStore ();
  List<String> currencies = [];
  List? selectedCurrencies;

  Future<void> getCurrencyList() async {
    final allCurrencies = await fetchCurrencies();
    currencies = allCurrencies[0];

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
          AppText.myCurencies,
          style: AppTextStyles.titleStyle,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: ValueListenableBuilder(
        valueListenable: MyCurDataStore.boxCurrency.listenable(),
        builder: (context, Box box, widget) {
          var list = box.values.toList();
          var listKey = box.keys.toList();
          return SafeArea(
            child: Column(
              children: [
                box.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          var myFavCurr = list[index];
                          return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 3,
                              child: ListTile(
                                  title: Text(
                                    ' ${myFavCurr.currencyName}',
                                    style: AppTextStyles.historyText,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColors.mainColor,
                                          ),
                                          onPressed: () {
                                            dataStore.deleteCurrency(
                                                index: listKey[index]);
                                          }),
                                    ],
                                  )));
                        })
                    : const Center(
                        child: Text(
                          AppText.noData,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MoreCurrencies()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
