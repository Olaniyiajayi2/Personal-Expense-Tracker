import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';
import './models/transaction.dart';


main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white, decorationColor: Colors.white)
            ),

        ),


      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {

  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [
//    Transaction(
//      id: 't1',
//      title: 'New shoes',
//      amount: 100,
//      date: DateTime.now(),),
//    Transaction(
//      id: 't2',
//      title: 'New shirt',
//      amount: 20.78,
//      date: DateTime.now(),
//    ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString()
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
      );
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          color: Colors.amber,
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),

      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Show Chart'),
              Switch(value: _showChart, onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              },),
            ],
          ),
          Container(
            height:(
                    MediaQuery.of(context).size.height -
                    appBar.preferredSize.height) * 0.4,
            child: Chart(_recentTransactions),
          ),
          Container(
            height: (
                MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) * 0.6,
              child: TransactionList(_userTransaction, _deleteTransaction)),
        ],
      ),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );

  }
}
