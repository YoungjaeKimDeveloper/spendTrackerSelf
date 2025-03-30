import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/database/expense_database.dart';
import 'package:tracker/pages/home_page.dart';

void main() async {
  // 비동기작업(DB Firebase...등등) 과 flutter Engine을 연결하려면
  // WidgetFlutterBiding.ensure이 부분이 필요하다는것임
  // Flutter엔진와 다른걸을 연결하기위해 사용함
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
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
