import 'package:flutter/material.dart';
import './widgts/transaction_list.dart';
import './models/transaction.dart';
import './widgts/new_Transaction.dart';
import './widgts/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primaryColor: Colors.lime[600],
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20)))),
      home: BasicCardsViewDisplay(),
    );
  }
}

class BasicCardsViewDisplay extends StatefulWidget {
  @override
  _BasicCardsViewDisplayState createState() => _BasicCardsViewDisplayState();
}

class _BasicCardsViewDisplayState extends State<BasicCardsViewDisplay> {
  final List<Transaction> _userTransactions = [
    /*Transaction(
        id: 't1', title: 'Men\'s ware', amount: 290.00, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Women\'s ware',
        amount: 1390.90,
        date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Kid\'s ware', amount: 1190.00, date: DateTime.now()),
    Transaction(
        id: 't4',
        title: 'Home furniture',
        amount: 7290.00,
        date: DateTime.now()),*/
  ];

  List<Transaction> get _recentTransations {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTtitle, double txAmount, DateTime choosenDate) {
    final newTX = Transaction(
      title: txTtitle,
      amount: txAmount,
      date: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTX);
      print(_userTransactions);
    });
  }

  void _showBottomSheetPopUp(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
          //return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _removeAllTransactions() {
    setState(() {
      int length = _userTransactions.length;
      _userTransactions.removeRange(0, length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses',),
        actions: <Widget>[
          _userTransactions.length == 0
              ? Text('')
              : FlatButton(
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: Colors.white, //Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      //decoration: BorderRadius.all(radius),
                    ),
                  ),
                  onPressed: () {
                    _removeAllTransactions();
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransations),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            _showBottomSheetPopUp(context);
          }),
    );
  }
}
