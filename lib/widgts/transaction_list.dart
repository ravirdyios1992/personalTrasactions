import 'package:basicCardsDispaly/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import './amountWidget.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTransactio;
  final List<Transaction> transactions;
  TransactionList(this.transactions, this.deleteTransactio);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      height: 600,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'You have not traded yet! Please add any new trasaction from your end.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    height: 100,
                    child: Image.asset(
                      'assets/fonts/images/welcomeImg.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  //elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}', style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                          //fontSize: 16,
                          color: Theme.of(context).primaryColor),
                               //Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey, fontSize: 12),//Theme.of(context).textTheme.subtitle1,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.grey, //Theme.of(context).errorColor,
                      onPressed: () => deleteTransactio(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
