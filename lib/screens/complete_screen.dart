import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:ToDo_bloc/bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../drawer.dart';
import '../todocard.dart';
class CompleteScreen extends StatelessWidget {
  static const routeName='/completed';
  @override
  Widget build(BuildContext context) {
    final todoBloc=BlocProvider.of<TodoBloc>(context);
    return SafeArea(
          child: Scaffold(
          appBar: AppBar(title: Text('Completed Tasks')),
          drawer: MainDrawer(),
          body:
         BlocBuilder(
                bloc:todoBloc ,
                builder: (BuildContext context, TodoState state) {
                 return  todoBloc.completed().length>0?ListView.builder(
                      itemBuilder: (context, index) {
                        return ToDoCard(todoBloc.completed()[index]);
                      },
                      itemCount: todoBloc.completed().length):Container(child: Center(child: Text('No Completed Tasks',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold))));
                }),
         
          ),
    );
  }
}
