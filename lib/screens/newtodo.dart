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
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)))
        .then((pickedDate) {
      if (pickedDate == null) {
        
        return;
      }
      setState(() {
        
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitToDo() {
    if (titleController.text.isEmpty) {
      return;
    }
    BlocProvider.of<TodoBloc>(context).add(AddTodo(titleController.text,descriptionController.text,_selectedDate));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
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
                minLines: 2,
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
                        : 'Finish By: ' +
                            DateFormat.yMMMd().format(_selectedDate),
                  style:TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
                  child:
                      FlatButton(onPressed: _submitToDo, child: Text('submit'))),
            ],
          ),
        ),
      ),
    );
  }
}
