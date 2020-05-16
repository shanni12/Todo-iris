import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:ToDo_bloc/screens/edit_screen.dart';
import '../bloc/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/todo_state.dart';
class ToDoView extends StatelessWidget {
  static const routeName = '/todoView';
  
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final todoObject =
        BlocProvider.of<TodoBloc>(context).findById(routeArgs['id']);
    void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text("Are You Sure ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
              FlatButton(
              child: Text("Delete"),
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(RemoveTodo(routeArgs['id']));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
    
    return Scaffold(
        appBar: AppBar(title: Text('NewPage')),
        body: Center(
          child:BlocBuilder(bloc:BlocProvider.of<TodoBloc>(context),builder:(BuildContext context,TodoState state) {return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(children: [
                Text(todoObject.title),
                Text(DateFormat.MMMd().format(todoObject.date),
                    style: TextStyle(fontWeight: FontWeight.w300)),
                Text(todoObject.description)
              ]),
              Container(
                  color: Colors.purpleAccent,
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(todoObject.isFavourite?Icons.star:Icons.star_border),color: Colors.white,
                        onPressed: () {BlocProvider.of<TodoBloc>(context).add(ToggleFavourite(routeArgs['id']));})
                      ,
                      IconButton(
                        icon: Icon(Icons.delete),
                        color:Colors.white,
                        onPressed: () { _showDialog();},
                        // onPressed: () {BlocProvider.of<TodoBloc>(context).add(RemoveTodo(routeArgs['id']));
                        // Navigator.of(context).pop();},
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        color:Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/edit_screen',arguments:routeArgs['id']);}
                        
                      ),
                      IconButton(
                        color:Colors.white,
                  icon: Icon(todoObject.isCompleted
                      ? (Icons.check_circle)
                      : (Icons.check_circle_outline)),
                  onPressed: () {
                    BlocProvider.of<TodoBloc>(context)
                        .add(ToggleComplete(todoObject.id));
                  },
                ),
                    ],
                  ))]);
            
          }
        )));
  }
}
