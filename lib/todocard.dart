import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import './models/todo.dart';
import './screens/todoView.dart';
import 'bloc/todo_bloc.dart';

class ToDoCard extends StatefulWidget {
  final TodoList todoObject;
  ToDoCard(this.todoObject);

  @override
  _ToDoCardState createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  
  @override
  Widget build(BuildContext context) {
    print(widget.todoObject.isFavourite);
    return Container(
      margin:EdgeInsets.only(top: 10.0),
      
      child: Dismissible(
        
        key: ValueKey(widget.todoObject.id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(Icons.delete, color: Colors.white, size: 40),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
        
           BlocProvider.of<TodoBloc>(context)
               .add(RemoveTodo(widget.todoObject.id));
        },
        confirmDismiss: (DismissDirection direction) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text("Confirm"),
        content:  Text("Are you sure you wish to delete this item?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("DELETE")
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("CANCEL"),
          ),
        ],
      );
    },
  );
},
        child: Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          
          child: FlatButton(
            onPressed: () => Navigator.of(context).pushNamed(ToDoView.routeName,
                arguments: {'id': widget.todoObject.id}),
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(widget.todoObject.isCompleted
                        ? (Icons.check_box)
                        : (Icons.check_box_outline_blank)),
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context)
                          .add(ToggleComplete(widget.todoObject.id));
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.todoObject.title,style:TextStyle(fontSize:20)),
                      Text(DateFormat.MMMd().format(widget.todoObject.date),
                          style: TextStyle(fontWeight: FontWeight.w300))
                    ],
                  ),
                  SizedBox(width: 10),
                  widget.todoObject.isFavourite
                      ? Icon(Icons.star, size: 15.0)
                      : Icon(null)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
