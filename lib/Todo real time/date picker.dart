import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Datetime(),));
}

class Datetime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("pick date &time"),),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.height*0.3,
          )
        ],
      ),
    );
  }
}