import 'dart:async';
import 'package:ToDo_bloc/models/todo.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import './todo_state.dart';
import './todo_event.dart';
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  
  @override
  TodoState get initialState => TodoInitial();
  
  TodoList findById(String id) {
    return state.todolists.firstWhere((element) => element.id == id);
  }

  List<dynamic> completed() {
    return state.todolists.where((element) => element.isCompleted).toList();
  }

  List<dynamic> incomplete() {
    return state.todolists.where((element) => !(element.isCompleted)).toList();
  }
  List<dynamic> getincomplete(DateTime date){
    var formatter=new DateFormat('yyyy-MM-dd');
    return state.todolists.where((element) =>(formatter.format(element.date)==formatter.format(date)&&(!element.isCompleted))).toList();
  }
  List<dynamic> getall(DateTime date){
    var formatter=new DateFormat('yyyy-MM-dd');
    return state.todolists.where((element) =>(formatter.format(element.date)==formatter.format(date))).toList();
  }
  List<dynamic> getcompleted(DateTime date){
    var formatter=new DateFormat('yyyy-MM-dd');
    return state.todolists.where((element) =>(formatter.format(element.date)==formatter.format(date)&&(element.isCompleted))).toList();
  }
  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is AddTodo) {
      var todolistsBox=Hive.box('todolist');
      
      todolistsBox.add(TodoList(
          id: DateTime.now().toString(),
          title: event.title,
          description: event.description,
          date: event.date));
      state.todolists=todolistsBox.values.toList();
      print(todolistsBox.values.toList()[0].id);
      print(state.todolists);
      yield (TodoState(state.todolists));
    }
    
     else if (event is RemoveTodo) {
      var todolistsBox=Hive.box('todolist');
       var values=todolistsBox.values.toList();
      final index=values.indexWhere((element) => element.id==event.id);
      todolistsBox.deleteAt(index);
      print(todolistsBox.values);
      state.todolists=todolistsBox.values.toList();
      //state.todolists.removeWhere((element) => element.id == event.id);
      yield (TodoState(state.todolists));
    } 
    
    
    else if (event is ToggleFavourite) {
      var todolistBox=Hive.box('todolist');
      var values=todolistBox.values.toList();
      var index=values.indexWhere((element) => element.id==event.id);
      var todoObject=todolistBox.values.toList()[index];
      
      todoObject.isFavourite = !todoObject.isFavourite;
      todolistBox.putAt(index,todoObject);
      yield (TodoState(todolistBox.values.toList()));
    } 
    
    else if (event is ToggleComplete) {
      var todolistBox=Hive.box('todolist');
      var values=todolistBox.values.toList();
      var index=values.indexWhere((element) => element.id==event.id);
      var todoObject=todolistBox.values.toList()[index];
      todoObject.isCompleted = !todoObject.isCompleted; 
      
      
      todolistBox.putAt(index,todoObject);
     
      yield (TodoState(todolistBox.values.toList()));
    }
    
    else if (event is EditTodoItem) {
    
      // final todoObject = findById(event.id);
      var todolistBox=Hive.box('todolist');
      var values=todolistBox.values.toList();
      var index=values.indexWhere((element) => element.id==event.id);
      var todoObject=todolistBox.values.toList()[index];
      todoObject.title=event.title;
      todoObject.description=event.description;
      todoObject.date=event.date;
      
      todolistBox.putAt(index, todoObject);
      //state.todolists=todolistBox.values.toList();
      print(todolistBox.values.toList()[index].title);
      yield (TodoState(todolistBox.values.toList()));
    }
  }
}
