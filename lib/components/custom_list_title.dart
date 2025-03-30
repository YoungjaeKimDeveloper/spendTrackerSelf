import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tracker/helper/helper_function.dart';
import 'package:tracker/models/expense.dart';
import 'package:intl/intl.dart';

// 정적으로 UI 변할필요가없음으로  Stless
class CustomListTitle extends StatelessWidget {
  // Member Variables
  Expense individualExpense;
  // Constructor
  CustomListTitle({super.key, required this.individualExpense});
  // State가 따로 존재하지않음
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(0),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: null,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: null,
            backgroundColor: Colors.red,
            foregroundColor: Colors.black,
            icon: Icons.settings,
          ),
        ],
      ),
      child: ListTile(
        title: Text(individualExpense.title),
        trailing: Text(dollarForamt(individualExpense.amount)),
      ),
    );
  }
}
