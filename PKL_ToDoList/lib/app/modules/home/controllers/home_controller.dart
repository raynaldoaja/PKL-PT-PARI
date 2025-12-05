import 'package:get/get.dart';
class TodoItem {
  final String id;
  final String title;
  final String category;
  final DateTime? dueDate;
  bool isCompleted;

  TodoItem({
    required this.id,
    required this.title,
    required this.category,
    this.dueDate,
    this.isCompleted = false,
  });
}

class HomeController extends GetxController {
 var todos = <TodoItem>[].obs;

 final selectedCategory = Rxn<String>();
 final selectedDate = Rxn<DateTime>();

 final categories = ['Umum','Penting','Travel'].obs;

 void resetDialogData() {
  selectedCategory.value = null;
  selectedDate.value = null;
 }
  
   void addTodo(String title, {String category = 'Umum', DateTime? dueDate}) {
  final newTodo = TodoItem(
   id: DateTime.now().toIso8601String(),
   title: title,
   category: category,
   dueDate: dueDate,
  );
  todos.add(newTodo);
 }
  void deleteTodo(String id){
    todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTodoStatus(String id){
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1){
      todos[index].isCompleted = !todos[index].isCompleted;
      todos.refresh();
    }
  }
}