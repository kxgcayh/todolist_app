import 'package:checklist_app/data/models/todo_list_model.dart';
import 'package:checklist_app/data/providers/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoList extends ApiProvider {
  TodoList(
    Ref ref, {
    this.cancelToken,
    required this.apiToken,
  }) : super(ref);

  final CancelToken? cancelToken;
  final String apiToken;

  Future<dynamic> fetch() async {
    response = await postConnect(
      '',
      data: {},
      cancel: cancelToken,
    );
    return response;
  }

  Stream<List<TodoData>?> fetchAll() async* {
    TodoListModel todoListModel;
    response = await getConnect(
      '/checklist',
      cancelToken: cancelToken,
      apiToken: apiToken,
    );
    todoListModel = TodoListModel.fromJson(response.data);
    if (todoListModel.statusCode != 2100) yield null;
    yield todoListModel.data;
  }
}
