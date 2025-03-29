import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/database/expense_database.dart';

void main() async {
  // 앱이 실행되기전에 DB초기화
  WidgetsFlutterBinding.ensureInitialized();
  // DB연결
  await ExpenseDatabase.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseDatabase(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
