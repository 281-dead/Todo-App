import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/page/loginpage.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:provider/provider.dart';
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

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String email = "";
  String password = "";
  TextEditingController title = TextEditingController();
  bool isChecked = false;

  List<TodoModel> lsToDo = [];

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? "";
    password = prefs.getString('password') ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState/
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF764ABC),
        title: const Text('StudentPage'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      'LOGOUT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(15),
                  height: 50,
                  width: 150,
                  child: GestureDetector(
                    child: const Text(
                      'ADD TO DO',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController title = TextEditingController();
                            return AlertDialog(
                              actions: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextField(
                                    controller: title,
                                    decoration: const InputDecoration(
                                      label: Text('Title'),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Canced')),
                                    OutlinedButton(
                                        onPressed: () {
                                          if (title.text.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('field cannot be left blank')));
                                            return;
                                          } else {
                                            final tasklist = Provider.of<TaskList>(context, listen: false);
                                            tasklist.onAdd(title.text);
                                            title.clear();
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('Add')),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                  )),
            ],
          ),
          Expanded(
            flex: 1,
            child: Consumer<TaskList>(
              builder: (context, TaskList, child) => ListView.builder(
                  itemCount: TaskList.lsTask.length,
                  itemBuilder: ((context, index) {
                    final Task = TaskList.lsTask[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Task.isFinish ? Colors.grey : Colors.amber[200],
                        border: Border.all(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 100,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(Task.title.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        trailing: Checkbox(
                            value: Task.isFinish,
                            checkColor: Colors.red,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                TaskList.onFinish(index);
                                Task.isFinish = value!;
                              });
                              print(Task.isFinish.toString());
                            }),
                        onLongPress: () {
                          TaskList.onDelete(index);
                        },
                      ),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
