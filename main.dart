
import 'package:flutter/material.dart';


void main() => runApp(new TodoApp());
//bool _value = false;


class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Todo List',
        home: new TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];
  List<String> _completeItems = [];

  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if(task.length > 0) {
     
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),                    
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  void changedWithButton(int index){setState(() {
    _promptRemoveTodoItem(index);
  });}

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {        
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildCompleteList() {
    return new ListView.builder(
      itemBuilder: (context, index)
        if(index < _completeItems.length) {
          return _buildTodoItem(_completeItems[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
       bool alreadyComplete = _completeItems.contains(todoText);
    return new ListTile(
        title: new Text(todoText),
        leading: new Icon(
          alreadyComplete ? Icons.favorite : Icons.favorite_border,
          color: alreadyComplete? Colors.red:null,

        ),



//        onTap: () => _promptRemoveTodoItem(index),
      onTap: () {
        setState(() {
          if (alreadyComplete) {
            _completeItems.removeAt(index);

          } else {
            _completeItems.add(todoText);

          }
        });
      },

    );
  }
  bool valueChanged(bool value) => value = !value;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Todo List')
      ),
      body:
      _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter something to do...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }


}
