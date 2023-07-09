import 'package:poni/model/todo_model.dart';

class TodoStorage {
  static int lastIndex = 2;
  static Map<int, TodoModel> storage = {
    1: TodoModel(id: 1, text: 'Заметка 1', deadLine: null, done: false),
    2: TodoModel(id: 2, text: 'Заметка 2', deadLine: DateTime.now(), done: true)
  };

  static TodoModel save(TodoModel todoModel) {
    lastIndex++;
    TodoModel model = todoModel.copyWith(id: lastIndex);
    storage[lastIndex] = model;
    return model;
  }

  static TodoModel? get(int id) {
    return storage[id];
  }

  static Iterable<TodoModel> getAll() {
    return storage.values;
  }

  static Iterable<TodoModel> getNotDone() {
    return storage.values.where((model) => !model.done);
  }

  static void remove(int id){
    storage.remove(id);
  }

  static TodoModel put(int id, TodoModel todoModel) {
    storage[id] = todoModel;
    return todoModel;
  }
}
