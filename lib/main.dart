import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:ToDo_bloc/models/todo.dart';
import 'package:ToDo_bloc/route_generator.dart';
import 'package:ToDo_bloc/screens/complete_screen.dart';
import 'package:ToDo_bloc/screens/incomplete_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart' ;
import 'package:path_provider/path_provider.dart' as path_provider;
import './screens/home_screen.dart';
import './screens/newtodo.dart';
import './screens/todoView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory= await path_provider.getApplicationDocumentsDirectory();
   Hive.init(appDocumentDirectory.path);
   Hive.registerAdapter(TodoListAdapter());
  
  final todolistsBox=await Hive.openBox('todolist');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider.value(
            value:TodoBloc(),
            child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            
            primarySwatch: Colors.purple,
            
          ),
          initialRoute: '/',
          routes:{
            '/': (ctx)=>HomeScreen(),NewToDo.routeName:(ctx)=>NewToDo(),ToDoView.routeName:(ctx)=>ToDoView(),CompleteScreen.routeName:(ctx)=>CompleteScreen(),
            InCompleteScreen.routeName:(ctx)=>InCompleteScreen(),
          },
          onGenerateRoute:RouteGenerator.generateRoute ,
        ),
      
    );
  }
  void dispose(){
    Hive.close();
    super.dispose();
  }
}

