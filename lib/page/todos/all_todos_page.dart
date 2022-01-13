import 'package:checklist_app/data/providers/todolist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(streamTodoList);
    return Scaffold(
      appBar: AppBar(title: 'Todo List'.text.make()),
      body: todoList.when(
        data: (data) {
          if (data != null) {
            return VStack(
              data.map((value) {
                return value.name.text.make();
              }).toList(),
            ).scrollVertical();
          } else {
            return 'no data available'.text.make();
          }
        },
        error: (e, s) => Text(e.toString()),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
