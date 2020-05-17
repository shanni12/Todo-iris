import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:ToDo_bloc/bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../drawer.dart';
import '../todocard.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          appBar: AppBar(title: Text('To-do-lists')),
          drawer: MainDrawer(),
          body:
         BlocBuilder(
                bloc: BlocProvider.of<TodoBloc>(context),
                builder: (BuildContext context, TodoState state) {
                 return  Container(
                   height:800,
                   child: state.todolists.length>0?ListView.builder(
                        itemBuilder: (context, index) {
                          return ToDoCard(state.todolists[index]);
                        },
                        itemCount: state.todolists.length):Container(child: Center(child: Text('Be Yourself Everyone Else is Already Taken'))),
                 );
                }),
          floatingActionButton: 
                    
                     FloatingActionButton(
            onPressed: () {Navigator.of(context).pushNamed('/newtodo');},
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add,color: Colors.white,),
        ),
          
          ),
    );
  }
}
