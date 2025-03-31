import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tracker/helper/helper_function.dart';
import 'package:tracker/models/expense.dart';

// 정적으로 UI 변할필요가없음으로  Stless
// ignore: must_be_immutable
class CustomListTitle extends StatelessWidget {
  // Member Variables
  Expense individualExpense;
  final void Function(BuildContext)? onEditPress;
  final void Function(BuildContext)? onDeletePress;
  // Constructor
  CustomListTitle({
    super.key,
    required this.individualExpense,
    required this.onEditPress,
    required this.onDeletePress,
  });
  // State가 따로 존재하지않음
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Slidable(
            key: ValueKey(0),
            // Right side
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                // Settings option
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: onEditPress,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  icon: Icons.settings,
                ),
                // Delete Option
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: onDeletePress,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.black,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: ListTile(
              title: Text(individualExpense.title),
              trailing: Text(dollarForamt(individualExpense.amount)),
            ),
          ),
        ),
      ),
    );
  }
}
