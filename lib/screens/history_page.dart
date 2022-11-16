import 'package:currency_converter/constants/text_constants.dart';
import 'package:currency_converter/store/history_data_store.dart';
import 'package:currency_converter/theme/colors.dart';
import 'package:currency_converter/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryPage extends StatefulWidget {
  

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HiveDataStore dataStore = HiveDataStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            AppText.histories,
            style: AppTextStyles.titleStyle,
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: ValueListenableBuilder(
          valueListenable: HiveDataStore.box.listenable(),
          builder: (context, Box box, widget) {
            return SafeArea(
              child: box.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: box.length,
                      itemBuilder: (BuildContext context, int index) {
                        var historyData = box.getAt(index);
                        return Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 3,
                            child: ListTile(
                                title: Text(
                                  ' ${historyData.amount.toString()} ${historyData.from.toString()}  =  ${historyData.result.toString()} ${historyData.to.toString()}',
                                  style: AppTextStyles.historyText,
                                ),
                                subtitle: Text(
                                  '${historyData.date}',
                                  style: AppTextStyles.historySubtext,
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
                                          dataStore.deleteHistory(index: index);
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
            );
          },
        ));
  }
}
