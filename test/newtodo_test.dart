
import 'package:ToDo_bloc/screens/newtodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
class TestWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:NewToDo()
    );
  }
}
void main(){
    testWidgets('finding two test fields ',(WidgetTester tester) 
    async {
      await tester.pumpWidget(TestWidget());
      var textField=find.byType(TextField);
      
      var buttonField=find.byType(FlatButton);
      expect(textField,findsNWidgets(2));
      await tester.enterText(textField.at(0),'test1');
      await tester.enterText(textField.at(1),'test2');
      expect(find.text('test1'),findsOneWidget);
      expect(find.text('test2'),findsOneWidget);
      expect(buttonField,findsNWidgets(2));
    });  
}