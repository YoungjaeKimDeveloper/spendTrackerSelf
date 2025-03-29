import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tracker/models/expense.dart';

class ExpenseDatabase {
  // 클래스 레벨에서만 사용할수있도록 싱글톤
  // 하나의 객체만 생성하고 앱 전체 어디에서든 연결할수있도록하는 것 
  static late Isar isar;
  // DB 연결
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }
}
