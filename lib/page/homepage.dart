import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/page/loginpage.dart';
import 'package:todo_app/model/todoModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = "";
  String password = "";
  TextEditingController content = TextEditingController();
  TextEditingController title = TextEditingController();

  List<TodoModel> lsToDo = [];

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? "";
    password = prefs.getString('password') ?? "";
  }

  onAdd(TodoModel todoModel) {
    setState(() {
      lsToDo.add(todoModel);
    });
  }

  onUpdate(TodoModel todoModel, int index) {
    setState(() {
      lsToDo.replaceRange(index, index + 1, [todoModel]);
    });
  }

  onDelete(int index) {
    setState(() {
      lsToDo.removeAt(index);
    });
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
        title: const Text('HomePage'),
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
                      showDiaglog(context, title, content, onAdd);
                    },
                  )),
            ],
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: lsToDo.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      border: Border.all(
                        width: 1.0,
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      //  showListTitle(context, onUpdate(lsToDo[index], index))
                      onTap: () {
                        // showDiaglog(context, title, content, onAdd);
                        showListTitle(context, onUpdate, lsToDo, index);
                      },
                      title: Text(lsToDo[index].title.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(lsToDo[index].content.toString(), style: const TextStyle(fontSize: 16)),
                      trailing: IconButton(onPressed: () => onDelete(index), icon: const Icon(Icons.delete)),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}

showListTitle(BuildContext context, Function onUpdate, List<TodoModel> todo, int index) => showDialog(
    context: context,
    builder: (context) {
      TextEditingController title = TextEditingController();
      TextEditingController content = TextEditingController();
      return AlertDialog(
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: todo[index].title.toString(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: content,
              decoration: InputDecoration(
                hintText: todo[index].content.toString(),
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
                    String title1 = title.text.toString();
                    String content1 = content.text.toString();
                    onUpdate(TodoModel(title: title1, content: content1), index);
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
            ],
          )
        ],
      );
    });

showDiaglog(BuildContext context, TextEditingController title, TextEditingController content, Function onAdd) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: content,
              decoration: const InputDecoration(
                label: Text('Content'),
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
                    if (title.text.isEmpty || content.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('field cannot be left blank')));
                      return;
                    } else {
                      String title1 = title.text.toString();
                      String content1 = content.text.toString();
                      onAdd(TodoModel(title: title1, content: content1));
                      title.clear();
                      content.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add')),
            ],
          )
        ],
      ),
    );
