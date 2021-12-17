import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction({Key? key, required this.addTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((pickedDate) => {
          if (pickedDate != null)
            {
              setState(() {
                _selectedDate = pickedDate;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  onSubmitted: (_) => _submitData,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : DateFormat.yMMMd().format(_selectedDate),
                      ),
                    ),
                    MaterialButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Chose Date',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ))
                  ],
                ),
                ElevatedButton(
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.button!.color),
                  ),
                  onPressed: _submitData,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
