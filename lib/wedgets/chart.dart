import 'package:flutter/material.dart';
import 'package:masarefy/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:masarefy/wedgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List <Map<String,Object>> get groupTransactionValues{
    return List.generate(7, (index)  {
      final weekDay = DateTime.now().subtract(Duration(days:index),);
      var totalSum = 0.0;

      for(var i=0; i < recentTransactions.length; i++){
        if (recentTransactions[i].date.day == weekDay.day
            && recentTransactions[i].date.month == weekDay.month
            && recentTransactions[i].date.year == weekDay.year){
          totalSum+=recentTransactions[i].amount;
        }
      }
      return {'day':DateFormat.E("ar").format(weekDay) , "amount" :totalSum }; } ).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, element) => sum+element["amount"]);
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
             groupTransactionValues.map((e) => Flexible(
               fit: FlexFit.tight,
               child: ChartBar(e["day"],e["amount"],
                   totalSpending == 0.0 ? 0.0 : (e["amount"]as double)/ totalSpending),
             )).toList()
        ),
      )
    );
  }
}
