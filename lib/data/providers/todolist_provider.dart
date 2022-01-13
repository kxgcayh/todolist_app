import 'package:checklist_app/data/models/todo_list_model.dart';
import 'package:checklist_app/data/providers/api_provider.dart';
import 'package:checklist_app/data/repositories/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final streamTodoList = StreamProvider((ref) {
  final api = ref.read(todoListProvider);
  return api.fetchAll();
});

final todoListProvider = Provider.autoDispose((ref) {
  final user = ref.read(authenticationRepository).user;
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  ref.maintainState = true;
  return TodoList(ref, apiToken: user.token!, cancelToken: cancelToken);
});

class TodoList extends ApiProvider {
  TodoList(
    Ref ref, {
    this.cancelToken,
    required this.apiToken,
  }) : super(ref);

  final CancelToken? cancelToken;
  final String apiToken;

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
