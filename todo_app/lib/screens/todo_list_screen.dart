import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/todo_list_notifier.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final notifier = ref.read(todoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: todoList.isEmpty
          ? const Center(
              child: Text('No todos yet! Add a new one.'),
            )
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: todo.description != null && todo.description!.isNotEmpty
                        ? Text(todo.description!)
                        : null,
                    leading: IconButton(
                      icon: Icon(
                        todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                        color: todo.isCompleted ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => notifier.toggleCompleted(todo.id),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            todo.isFavorite ? Icons.star : Icons.star_border,
                            color: todo.isFavorite ? Colors.amber : Colors.grey,
                          ),
                          onPressed: () => notifier.toggleFavorite(todo.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => notifier.removeTodo(todo.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Implement navigation to TodoDetailScreen or edit functionality
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // For now, let's add a dummy todo directly
          notifier.addTodo('New Todo ${todoList.length + 1}', description: 'This is a description for todo ${todoList.length + 1}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}