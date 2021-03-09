import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectDate;

  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );
    Navigator.of(context).pop();
  }

  void _persentDatePicker() {
    showDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now(),
            context: context)
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'balalalala' ,),
                  controller: titleController,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (val) {
                  //   titleInput = val;
                  // },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (val) => amountInput = val,
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                              _selectDate == null
                                  ? "لم يتم تحديد التاريخ"
                                  : DateFormat.yMEd("AR").format(_selectDate),
                              style: TextStyle(color: Colors.grey))),
                      Platform.isIOS
                          ? CupertinoButton(
                              child: Text("حدد التاريخ",
                                  style: Theme.of(context).textTheme.headline6),
                              onPressed: _persentDatePicker,
                            )
                          : FlatButton(
                              child: Text("حدد التاريخ",
                                  style: Theme.of(context).textTheme.headline6),
                              onPressed: _persentDatePicker,
                            )
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'اضافه',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  textColor: Colors.black,
                  splashColor: Colors.black12,
                  color: Theme.of(context).primaryColor,
                  onPressed: _submitData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
