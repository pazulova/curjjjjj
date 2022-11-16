import 'dart:async';
import 'package:currency_converter/models/history_model.dart';
import 'package:currency_converter/models/my_currencies_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'routes/router.dart';
import 'screens/main.conversion.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<HistoryModel>(HistoryModelAdapter());
  Hive.registerAdapter<MyCurModel>(MyCurModelAdapter());

  await Hive.openBox<HistoryModel>("historyBox");
  await Hive.openBox<MyCurModel>("myCurrenciesBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyApps(),
    );
  }
}

class MyApps extends StatelessWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.router.onGenerate,
    );
  }
}

//Гулнура