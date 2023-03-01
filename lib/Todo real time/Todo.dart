import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("mybox");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Todo(),
  ));
}

class Todo extends StatefulWidget {
  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Map<String, dynamic>> taskbox = [];
  final box = Hive.box('mybox');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        backgroundColor: Colors.red,
      ),
      body: taskbox.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : ListView.builder(itemBuilder: (context, index) {
              return Card();
            }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
