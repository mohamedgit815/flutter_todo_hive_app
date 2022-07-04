import 'package:flutter/material.dart';

class ShowPersonData extends StatelessWidget {
  final String name ;
  final int age;
  const ShowPersonData({Key? key , required this.name , required this.age}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name),centerTitle: true,),
      body: Column(
        children: [
          //Expanded(child: Text(name)),

          Expanded(child: Center(child: Text(age.toString(),style: const TextStyle(fontSize: 25.0),)))
        ],
      ),
    );
  }
}
