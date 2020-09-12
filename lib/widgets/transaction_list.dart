import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty ? Column(children: <Widget>[
          Text('No transactions added yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Image.asset('assets/images/waiting.png', height: 200,),
        ],
        ) : Column(
      children: transactions.map((tx) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal:  15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2),
                      shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    '\#${tx.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tx.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),),
                  Text(
                    DateFormat().format(tx.date),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black26),),
                  IconButton(
                    alignment: Alignment.center,
                    icon: Icon(Icons.delete,),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(tx.id),),
                ],
              ),
            ],),);
      },
      ).toList(),
    ),);
  }
}