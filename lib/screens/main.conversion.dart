
import 'package:currency_converter/components/home_drawer.dart';
import 'package:currency_converter/models/curreccy_result.dart';
import 'package:currency_converter/store/my_currencies_store.dart';
import 'package:currency_converter/theme/colors.dart';
import 'package:currency_converter/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../components/sustom_drop_down.dart';
import '../components/home_page_app_bar.dart';
import '../constants/text_constants.dart';
import '../models/history_model.dart';
import '../models/my_currencies_model.dart';
import '../services/get_rate.dart';
import '../store/history_data_store.dart';

class MainCurrencyPage extends StatefulWidget {
  

  @override
  State<MainCurrencyPage> createState() => _MainCurrencyPageState();
}

class _MainCurrencyPageState extends State<MainCurrencyPage> {
  final HiveDataStore dataStore = HiveDataStore();

  CurrencyResult? currencyResult;
  MyCurDataStore favoriteDataStore = MyCurDataStore();
  String from = "";
  String to = "";

  String amount = '0';
  double? result;

  Future<CurrencyResult?> showResult() async {
    CurrencyResult? c2 = await getRate(from, to, amount);
    return c2;
  }

  void returnAllInfo(CurrencyResult item) {
    HistoryModel historyMod = HistoryModel(
        from: item.from,
        to: item.to,
        amount: item.amount,
        result: item.result,
        date: item.date);
    dataStore.addHistory(historyModel: historyMod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomePageAppbar(),
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   currencyfromTo(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          labelText: AppText.textFieldLabelStyle,
                          labelStyle: AppTextStyles.textFieldLabelStyle),
                      style: AppTextStyles.textFieldStyle,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        currencyResult = null;
                        setState(() {
                          amount = value;
                          result = null;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            primary: AppColors.secondColor),
                        onPressed: () async {
                          result = null;

                          currencyResult = await showResult();
                          double? res = currencyResult?.result;

                          returnAllInfo(currencyResult!);
                          setState(() {
                            result = res;
                          });
                        },
                        child: const Text(AppText.convert)
                        ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(children: [
                  const Text(
                    AppText.result,
                    style: AppTextStyles.resultTextStyle,
                  ),
                  currencyResult == null
                      ? const Text('')
                      : Text('$result', style: AppTextStyles.resultStyle)
                ]),
              )
            ]),
      )),
      drawer: const HomeDrawer(),
    );
  }


  
  ValueListenableBuilder<Box<MyCurModel>> currencyfromTo() {
    return ValueListenableBuilder(
        valueListenable: MyCurDataStore.boxCurrency.listenable(),
        builder: (context, Box box, widget) {
          var list = box.values.toList();

          return Column(
            children: [
              list.isNotEmpty
                  ? currDropDown(from, (val) {
                      setState(() {
                        from = val;
                      });
                    })
                  : const CircularProgressIndicator(),
              FloatingActionButton(
                onPressed: () {
                  String temp = from;
                  setState(() {
                    from = to;
                    to = temp;
                  });
                },
               
                elevation: 0.0,
               
              ),
            list.isNotEmpty
                 ? 
                  currDropDown(to, (val) {
                      setState(() {
                        to = val;
                      });
                    })
                  :
                  CircularProgressIndicator(),
            ],
          );
        });
  }
}

