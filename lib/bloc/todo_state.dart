import 'package:hive/hive.dart';

import '../models/todo.dart';

class TodoState {
  List<dynamic> todolists;
  TodoState(this.todolists);
}

class TodoInitial extends TodoState {
  static var todolistsBox=Hive.box('todolist');
  TodoInitial()
      : super(todolistsBox.values.toList());
  
}
