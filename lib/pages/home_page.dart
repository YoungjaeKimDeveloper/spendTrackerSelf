import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/components/custom_list_title.dart';
import 'package:tracker/database/expense_database.dart';
import 'package:tracker/helper/helper_function.dart';
import 'package:tracker/models/expense.dart';

// 지속적으로 UI를 변경시키려면 StatefulWidget
// 단순히 고정된 UI는 Stateless로 설정해주어야함
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // 처음에 실행될때 Database에 있는 data를 로딩함
    // UseEffect같은ㄴ느김임......
    Provider.of<ExpenseDatabase>(context, listen: false).readExpense();
    super.initState();
  }

  // Title Controller
  TextEditingController titleController = TextEditingController();
  // Amount Controller
  TextEditingController amountController = TextEditingController();
  void openExpenseBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Title"),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "amount"),
                controller: amountController,
              ),
            ],
          ),
          actions: [cancelBtn(), createBtn()],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Expense Title")),
          floatingActionButton: FloatingActionButton(
            onPressed: openExpenseBox,
            child: Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: value.allExpenses.length,
            itemBuilder: (BuildContext context, int index) {
              Expense individualExpense = value.allExpenses[index];
              return CustomListTitle(individualExpense: individualExpense);
            },
          ),
        );
      },
    );
  }

  // Create new Expense
  Widget createBtn() {
    return MaterialButton(
      onPressed: () {
        // 새로운 데이터 Database에 저장해주기
        if (titleController.text.isNotEmpty &&
            amountController.text.isNotEmpty) {
          Navigator.pop(context);
          // 새로운 Expense를 일단 객체로 만들어주기
          Expense newExpense = Expense(
            titleController.text,
            convertStringToDouble(amountController.text),
            DateTime.now(),
          );
          // 데이터 베이스에 추가해주기
          context.read<ExpenseDatabase>().createExpense(newExpense);
          // 원래있던 inputBox 초괴화 해주기
          titleController.clear();
          amountController.clear();
        }
      },
      child: Text("Create"),
    );
  }

  Widget cancelBtn() {
    return TextButton(
      onPressed: () {
        // 현재의 위치에서 상태를닫겠다?
        Navigator.pop(context);
      },
      child: Text("No"),
    );
  }
}

// UI -> Logic
