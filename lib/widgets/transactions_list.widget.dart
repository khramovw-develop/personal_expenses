import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.model.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionsList({
    Key? key,
    required this.transactions,
    required this.deleteTx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              reverse: false,
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 14.0),
                  child: buildListTile(index, context),
                );
              },
            ),
    );
  }

  ListTile buildListTile(int index, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text(
              '\$${transactions[index].amount.toStringAsFixed(2)}',
            ),
          ),
        ),
      ),
      title: Text(
        transactions[index].title.toUpperCase(),
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        DateFormat('yy MMMdd HH:mm').format(transactions[index].date),
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).errorColor,
        ),
        onPressed: () => deleteTx(transactions[index].id),
      ),
    );
  }

  // Card buildCard(BuildContext context, int index) {
  //   return Card(
  //     elevation: 5,
  //     child: Row(
  //       children: <Widget>[
  //         Container(
  //           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //           decoration: BoxDecoration(
  //               border: Border.all(
  //                   color: Theme.of(context).primaryColor, width: 2)),
  //           child: Text(
  //             '\$${transactions[index].amount.toStringAsFixed(2)}',
  //             style: Theme.of(context).textTheme.headline1,
  //           ),
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   transactions[index].title.toUpperCase(),
  //                   style: Theme.of(context).textTheme.headline6,
  //                 ),
  //                 Text(
  //                   transactions[index].id,
  //                   style: Theme.of(context).textTheme.headline2,
  //                 ),
  //               ],
  //             ),
  //             Text(
  //               DateFormat('yy MMMdd HH:mm').format(transactions[index].date),
  //               style: const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                   color: Colors.grey),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
