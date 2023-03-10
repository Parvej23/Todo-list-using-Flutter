import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/provider/todo_provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final _textController= TextEditingController();
  Future<void> _showDialog() async{
    return showDialog(
      context:context,
      builder: (context){
        return AlertDialog(
          title: Text('Add todo List'),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(hintText:'Write to do item'),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text('Cancel')
            ),
            TextButton(onPressed: (){
              if(_textController.text.isEmpty){
                return;
              }
              context.read<TodoProvider>().addTodoList(
                new TodoModel(title: _textController.text,
                    isComplete: false),
              );
              _textController.clear();
              Navigator.pop(context);
            },
                child: Text('Submit')
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<TodoProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff502897),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(40,40),
                    //topLeft: Radius.elliptical(40,40)
                   // bottomLeft: Radius.circular(20),
                  )
                ),
                child: Center(child: Text('To DO List',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child:ListView.builder(
                  itemBuilder:(context, itemIndex){
                    return ListTile(
                      onTap: (){
                        provider.todoStatusChange(
                            provider.allTodoList[itemIndex]);
                      },
                      leading: MSHCheckbox(
                        size: 30,
                        value:provider.allTodoList[itemIndex].isComplete,
                        colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Color(0xff502897)
                        ),
                        style: MSHCheckboxStyle.stroke,
                        onChanged: (selected){
                          provider.todoStatusChange(
                            provider.allTodoList[itemIndex]
                          );
                        },
                      ),
                      title: Text(provider.allTodoList[itemIndex].title,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          decoration: provider.allTodoList[itemIndex].isComplete==
                            true? TextDecoration.lineThrough: null
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: (){
                          provider.removeTodoList(
                            provider.allTodoList[itemIndex]
                          );
                        },
                        icon: Icon(Icons.delete),

                      ),
                    );
                  },
                itemCount: provider.allTodoList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color(0xff502897) ,
        onPressed: (){
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
