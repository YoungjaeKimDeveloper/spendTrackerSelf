import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tracker/models/expense.dart';

class ExpenseDatabase extends ChangeNotifier {
  // 클래스 레벨에서만 사용할수있도록 싱글톤
  //인스턴스 없이객체에 직접접근허용가능
  static late Isar isar;

  // UI 뿌려줄것
  final List<Expense> _allExpenses = [];
  // DB 연결 - ㅡmongoDB에서 연결하는것과같음 비동기로 연결
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  // Create
  Future<void> createExpense(Expense newExpense) async {
    await isar.writeTxn(() async {
      // 데이터 베이스에 넣어주기
      await isar.expenses.put(newExpense);
    });
    // 새로 변경될때마다 값 다시읽어주기 - UI 변경
    readExpense();
  }

  // Delete
  Future<void> deleteExpense(Expense expense) async {
    await isar.writeTxn(() async {
      // 데이터 베이스에서 지워주기
      await isar.expenses.delete(expense.id); // delete
    });
    // 새로 변경될때마다 값 다시읽어주기 - UI 변경
    readExpense();
  }

  // Update
  Future<void> updateExpense(int id, Expense updateExpense) async {
    // put 데이터가 있으면 업데이트 / 없으면 새로 추가
    updateExpense.id = id;
    await isar.writeTxn(() async {
      // 데이터 베이스에서 업데이트해주기
      await isar.expenses.put(updateExpense); // insert & update
    });
    // 새로 변경될때마다 값 다시읽어주기 - UI 변경
    readExpense();
  }

  // Read
  Future<void> readExpense() async {
    // 불릴때마다 데이트베이스에서 다시가져와서 실제 Local 에 넣어서 UI업데이트해주기
    List<Expense> fetchedExpenses = await isar.expenses.where().findAll();
    _allExpenses.clear();
    _allExpenses.addAll(fetchedExpenses);
    notifyListeners();
  }
}
