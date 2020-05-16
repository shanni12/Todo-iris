import 'package:flutter/material.dart';
import './screens/edit_screen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args=settings.arguments;

    switch(settings.name){
      
      

      case '/edit_screen':
      if(args is String)
      {
        return MaterialPageRoute(builder: (_)=>EditToDo(args));
      }
      return _errorRoute();


      default:
      return _errorRoute();
    }

  }
static  Route<dynamic> _errorRoute(){
  return MaterialPageRoute(builder: (_){
    return Scaffold(
      appBar: AppBar(title: Text('Error'),
      ),
      body: Center(
        child:Text('Error'),
      ),
    );
  });
}
}