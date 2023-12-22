import 'package:flutter/material.dart';
import 'package:todo_app/model/taskModel.dart';

class TaskList extends ChangeNotifier {
  List<Task> lsTask = [];
  onAdd(String title) {
    lsTask.add(Task(title, false));
    notifyListeners();
  }

  onFinish(int index) {
    lsTask[index].isFinish = !lsTask[index].isFinish;
  }

  onDelete(int index) {
    lsTask.removeAt(index);
    notifyListeners();
  }
}
