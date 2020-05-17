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
                  BlocProvider.of<TodoBloc>(context)
                      .add(RemoveTodo(routeArgs['id']));
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return BlocBuilder(
        bloc: BlocProvider.of<TodoBloc>(context),
        builder: (BuildContext context, TodoState state) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Text(todoObject.title, style: TextStyle(fontSize: 25)),
                ),
                body: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('Title:',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(todoObject.title,
                            style: TextStyle(fontSize: 20.0)),
                        SizedBox(height: 10),
                        //  Row(mainAxisAlignment: MainAxisAlignment.end,
                        //    children: [
                        //      Text(DateFormat.yMMMd().format(todoObject.date),
                        //          style: TextStyle(fontWeight: FontWeight.w300)),
                        //          SizedBox(width:3)
                        //    ],
                        //  ),
                        SizedBox(height: 30),
                        Text('Description:',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Expanded(
                            flex: 2,
                            child: Text(todoObject.description,
                                style: TextStyle(fontSize: 18))),
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Center(
                                    child: Text('Created On: ' +
                                        DateFormat.yMMMd().format(
                                            DateTime.parse(todoObject.id)))),
                                SizedBox(
                                  height: 7,
                                ),
                                Text('Finish By: ' +
                                    DateFormat.yMMMd()
                                        .format((todoObject.date))),
                              ],
                            )),

                        SafeArea(
                          child: Container(
                              color: Theme.of(context).primaryColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      icon: Icon(todoObject.isFavourite
                                          ? Icons.star
                                          : Icons.star_border),
                                      color: Colors.white,
                                      onPressed: () {
                                        BlocProvider.of<TodoBloc>(context).add(
                                            ToggleFavourite(routeArgs['id']));
                                      }),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      _showDialog();
                                    },
                                    // onPressed: () {BlocProvider.of<TodoBloc>(context).add(RemoveTodo(routeArgs['id']));
                                    // Navigator.of(context).pop();},
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            '/edit_screen',
                                            arguments: routeArgs['id']);
                                      }),
                                  IconButton(
                                    color: Colors.white,
                                    icon: Icon(todoObject.isCompleted
                                        ? (Icons.check_circle)
                                        : (Icons.check_circle_outline)),
                                    onPressed: () {
                                      BlocProvider.of<TodoBloc>(context)
                                          .add(ToggleComplete(todoObject.id));
                                    },
                                  ),
                                ],
                              )),
                        )
                      ]),
                )),
          );
        });
  }
}
