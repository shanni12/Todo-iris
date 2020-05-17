import 'package:ToDo_bloc/bloc/todo_bloc.dart';
import 'package:ToDo_bloc/bloc/todo_state.dart';
import 'package:ToDo_bloc/drawer.dart';
import 'package:ToDo_bloc/todocard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  CalendarController controller;
  @override
  void initState() {
    super.initState();
    controller = CalendarController();
  }
  
  var selected_date = DateTime.now();
  var complete=false;
  var availableCalendarFormats={CalendarFormat.week};
  @override
  Widget build(BuildContext context) {
    print(selected_date);
    final todoBloc=BlocProvider.of<TodoBloc>(context);
    print(todoBloc.getall(selected_date).length);
    return BlocBuilder(bloc:todoBloc,builder: (BuildContext context,TodoState state) { return SafeArea(
          child: Scaffold(
        appBar: AppBar(title: Text('Todo!')),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(initialCalendarFormat:CalendarFormat.week,calendarStyle: CalendarStyle(selectedColor:Theme.of(context).primaryColor,todayStyle:TextStyle(fontSize:18.0,fontWeight:FontWeight.bold)),
                calendarController: controller,headerStyle: HeaderStyle(formatButtonShowsNext:false),onDaySelected: (date,events) {
                  setState(() {selected_date=date;
                  complete=false;});
                },),
                todoBloc.getall(selected_date).length>0?Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pending tasks'),
                        Switch.adaptive(value:complete,onChanged:(val) {
                        setState(() {
                            complete=val;
                        });
                      }),
                      Text('Completed Tasks')
                      ],
                    ),
                  
               
                
              !complete?(todoBloc.getincomplete(selected_date).length>0?SingleChildScrollView(
                            child: (Container(height:500,
                  child: ListView.builder(itemBuilder: (context,index) {return ToDoCard(todoBloc.getincomplete(selected_date)[index]);},
                  itemCount:todoBloc.getincomplete(selected_date).length ,),
                 )),
              ):Column(mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('No Pending Tasks',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold)),
                   
                 ],
               )):(todoBloc.getcompleted(selected_date).length>0? Container(height:500,
                child: ListView.builder(itemBuilder: (context,index) {return ToDoCard(todoBloc.getcompleted(selected_date)[index]);},
                itemCount:todoBloc.getcompleted(selected_date).length ,)):Column(
                 children: [
                   Text('No Completed Tasks',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold)),
                   
                 ])
               ),]
          ): 
                    Container(child: Center(child: Text('No Tasks',style:TextStyle(fontSize:20.0,fontWeight:FontWeight.bold)))),
                    ],
                  
          ),
            
        
      ),floatingActionButton: 
                    
                     FloatingActionButton(
            onPressed: () {Navigator.of(context).pushNamed('/newtodo');},
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add,color:Colors.white),)),
    );});
  }
}
