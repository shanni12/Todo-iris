import 'package:hive/hive.dart';
part 'todo.g.dart';
@HiveType(typeId: 0)
class TodoList{
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
   DateTime date;
   @HiveField(4)
   bool isCompleted=false;
   @HiveField(5)
   bool isFavourite=false;
  TodoList({this.id,this.title,this.description,this.date});
}