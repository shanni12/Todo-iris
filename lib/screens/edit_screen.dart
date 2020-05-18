import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/todo_event.dart';
class EditToDo extends StatefulWidget {
final String id;
EditToDo(this.id);
  _EditToDoState createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  var flag=0;
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
        
        flag=1;
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitToDo() {
    if (titleController.text .isEmpty) {
      
      return;
    }
    
    BlocProvider.of<TodoBloc>(context).add(EditTodoItem(widget.id,titleController.text,descriptionController.text,_selectedDate));
     Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    
    final todoObject =
        BlocProvider.of<TodoBloc>(context).findById(widget.id);
    if(flag==0){
    titleController.text=todoObject.title;
    descriptionController.text=todoObject.description;
    _selectedDate=todoObject.date;
    }
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Edit ToDo'),
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
                        : 'Finish By: ' +
                            DateFormat.yMMMd().format(_selectedDate),
                  ),
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
