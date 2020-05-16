abstract class TodoEvent {}
class AddTodo extends TodoEvent{
  final String title;
  final String description;
  final DateTime date;

  AddTodo(this.title, this.description, this.date);

}
class RemoveTodo extends TodoEvent{
  final String id;
  RemoveTodo(this.id);
}
class ToggleFavourite extends TodoEvent{
  final String id;
  ToggleFavourite(this.id);
}
class ToggleComplete extends TodoEvent{
  final String id;
  ToggleComplete(this.id);
}
class EditTodoItem extends TodoEvent{
  final String id;
  final String title;
  final String description;
  final DateTime date;
  EditTodoItem(this.id,this.title,this.description,this.date);
}