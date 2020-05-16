import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/todo_event.dart';
class NewToDo extends StatefulWidget {
static const routeName='/newtodo';
  _NewToDoState createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  var _selectedDate;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now().add(Duration(days: 1)),
            firstDate: DateTime(2019),
            lastDate: DateTime.now().add(Duration(days: 365)))
        .then((pickedDate) {
      if (pickedDate == null) {
        print('null');
        return;
      }
      setState(() {
        print('picked');
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitToDo() {
    if (titleController.text == null) {
      return;
    }
    BlocProvider.of<TodoBloc>(context).add(AddTodo(titleController.text,descriptionController.text,_selectedDate));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New ToDo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate == null
                      ? 'No date chosen'
                      : 'Date Chosen: ' +
                          DateFormat.yMMMd().format(_selectedDate),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  color: Colors.blue,
                  child: FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                width: double.infinity,
                color: Colors.blue,
                child:
                    FlatButton(onPressed: _submitToDo, child: Text('submit'))),
          ],
        ),
      ),
    );
  }
}
