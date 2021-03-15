import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  final double amount;
  AmountWidget(this.amount);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
        Container(
          //width: double.infinity,
          //alignment: Alignment.topRight,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          /*decoration: BoxDecoration(
            border: Border.all(
              color: Colors.lime[700],
              width: 1,
            ),
          ),*/
          padding: EdgeInsets.all(6),
          child: Text(
            '\$${amount.toStringAsFixed(2)}',
            //tx.amount.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
