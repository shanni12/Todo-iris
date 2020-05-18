
import 'package:flutter_driver/flutter_driver.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

void main() {
  group('flutter todo app test',() {
    FlutterDriver  driver;
    setUpAll(() async{
      driver=await FlutterDriver.connect();
    });

    tearDownAll(() {if(driver!=null)
    driver.close();});
    var floatingActionButton=find.byValueKey('addtodo');
    
    test('checking fab',() async{
      assert(floatingActionButton!=null);
      await driver.tap(floatingActionButton);});
      
    test('new todo route',() async{var textField=find.byValueKey('title');
      await driver.tap(textField);
      await driver.enterText('text1');
     var descriptionField=find.byValueKey('description');
     await driver.tap(descriptionField);
     await driver.enterText('text2');
     var buttonField=find.byValueKey('date');
     await driver.tap(buttonField);
     var text=find.text('OK');
     await driver.tap(text);
     var submit=find.byValueKey('submit');
     assert(submit!=null);
     await driver.tap(submit);});
     
     test('checking todo card',() async{ 
      var card=find.text('text1');
      var date=find.text(DateFormat.yMMMd().format(
                                            DateTime.now()));

      assert(card!=null);
      assert(date!=null);
      });
     test('detail route',() async{
       var card=find.text('text1');
       await driver.tap(card);
     var desc=find.text('text2');
     assert(desc!=null);});
     
     //await driver.tap(textField);
     //await driver.enterText('text1');
    

      
  });
}