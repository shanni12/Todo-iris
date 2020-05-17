import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:ToDo_bloc/bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../drawer.dart';
import '../todocard.dart';
class InCompleteScreen extends StatelessWidget {
  static const routeName='/incomplete';
  @override
  Widget build(BuildContext context) {
    final todoBloc=BlocProvider.of<TodoBloc>(context);
    return Scaffold(
        appBar: AppBar(title: Text('In Complete Tasks')),
        drawer: MainDrawer(),
        body:
       BlocBuilder(
              bloc:todoBloc ,
              builder: (BuildContext context, TodoState state) {
               return todoBloc.incomplete().length>0? ListView.builder(
                    itemBuilder: (context, index) {
                      return ToDoCard(todoBloc.incomplete()[index]);
                    },
                    itemCount: todoBloc.incomplete().length):Container(child: Center(child: Text('No Pending Tasks',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold))));
              }),
       
        );
  }
}
