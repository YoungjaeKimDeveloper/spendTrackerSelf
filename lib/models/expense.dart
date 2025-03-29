import 'package:isar/isar.dart';
// 하나의 Table의 기능들을 사용할수있도록해주는것
part 'expense.g.dart';
// 이제 class ->하나의 noSQL Table이 되었음
@collection
class Expense {
  Id id = Isar.autoIncrement;
  // Member variables
  final String title;
  final double amount;
  final DateTime date;

  // Constructor
  Expense(this.title, this.amount, this.date);
}
