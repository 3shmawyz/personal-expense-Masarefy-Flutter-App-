import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masarefy/models/transaction.dart';
import 'package:masarefy/wedgets/transaction_item.dart';


 class TransactionList extends StatelessWidget {
 final List<Transaction> transactions;
 TransactionList(this.transactions,this.deleteTx );
 final Function deleteTx;

  @override
  Widget build(BuildContext context) {

       return transactions.isEmpty
          ? LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'لم يتم اضافه اي عمليات',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight  * 0.6,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
       },)

      :ListView.builder(
         itemBuilder:(ctx,index) =>
             TransactionItem(transaction: transactions[index], deleteTx: deleteTx),
        itemCount: transactions.length,
    );
  }
}

