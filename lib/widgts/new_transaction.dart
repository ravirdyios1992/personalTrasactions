import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTX;

  NewTransaction(this._addTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleStringController = TextEditingController();
  final _amountStringController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {

if(_amountStringController.text.isEmpty) {
  return;
}

    final enteredTitle = _titleStringController.text;
    final enteredAmount = double.parse(_amountStringController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget._addTX(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      //color: Colors.red,
      height: 300,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            cursorColor: Colors.orange,
            // onChanged: (value) {
            //  titleString = value;
            //},
            controller: _titleStringController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'amount'),
            cursorColor: Colors.orange,
            //onChanged: (value) => amountString = value,
            keyboardType: TextInputType.number,
            controller: _amountStringController,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(child: Text(_selectedDate == null
                      ? 'No date choosen!'
                      : 'Picked Date: ${DateFormat.yMEd().format(_selectedDate)}'),
                ),
                FlatButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      //decoration: BorderRadius.all(radius),
                    ),
                  ),
                  onPressed: () {
                    _presentDatePicker();
                  },
                )
              ],
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(25),
            ),
            child: FlatButton(
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  //decoration: BorderRadius.all(20),
                ),
              ),
              onPressed: () {
                _submitData();
              },
            ),
          )
        ],
      ),
    ));
  }
}
