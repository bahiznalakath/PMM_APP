import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'UI/add_transaction/screen_add_transaction.dart';
import 'UI/home/screens_home.dart';
import 'model/Category_model/category_model.dart';
import 'model/Transaction_model/transaction_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// db init
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MONEY MANAGER",
      debugShowCheckedModeBanner: false,
      home: const ScreenHome(),
      theme: ThemeData(
        primarySwatch: Colors.pink, // Set the primary color to pink

      ),
      routes: {
        ScreenAddTransaction.routeName: (ctx) => const ScreenAddTransaction(),
      },
    );
  }
}
