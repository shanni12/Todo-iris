import 'package:ToDo_bloc/drawer.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  TextStyle questionStyle() {
    return TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  }

  TextStyle answerStyle() {
    return TextStyle(fontSize: 18.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About')),
        drawer: MainDrawer(),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            children: <Widget>[
              Text('Hey there !',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    'Keep track of all your tasks and prioritize on what is important.',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          Text('Want to see all the task in one glance? ',
              style: questionStyle()),
          Text('Easy.  Click on All tasks on sidebar.', style: answerStyle()),
          Text('Want to see all completed tasks in one glance ?',
              style: questionStyle()),
          Text('Easy.  Click on Completed on sidebar.', style: answerStyle()),
          Text('Want to see all pending tasks in one glance ?',
              style: questionStyle()),
          Text('Easy. Click on Incomplete on sidebar.', style: answerStyle()),
          Text('Want to see all the tasks on a particular day ?',
              style: questionStyle()),
          Text('Easy. Go to calendar view from sidebar.', style: answerStyle()),
          Text('Want a task to be highlighted ?', style: questionStyle()),
          Text('Easy. Mark it as favorite.', style: answerStyle()),
          SizedBox(
            height: 4.0,
          )
        ]));
  }
}
