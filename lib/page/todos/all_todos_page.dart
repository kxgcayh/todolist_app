import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: 'Todo List'.text.make()),
      body: VStack([
        //
      ]).scrollVertical(),
    );
  }
}
