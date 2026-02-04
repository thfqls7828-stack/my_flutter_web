import 'package:riverpod/riverpod.dart';
import 'package:todo_app/domain/entities/todo.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String title, {String? description}) {
    state = [
      ...state,
      Todo(
        id: DateTime.now().toIso8601String(),
        title: title,
        description: description,
      ),
    ];
  }

  void toggleCompleted(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  void toggleFavorite(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isFavorite: !todo.isFavorite)
        else
          todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});