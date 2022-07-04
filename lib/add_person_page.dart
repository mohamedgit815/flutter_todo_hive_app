import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_app/hive_model.dart';
import 'package:flutter_hive_app/home_page.dart';
import 'package:hive/hive.dart';


class AddPersonPage extends StatefulWidget {
  const AddPersonPage({Key? key}) : super(key: key);

  @override
  _AddPersonPageState createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();

  late Box _person;

  @override
  void initState() {
    super.initState();
    _person = Hive.box<Person>('person');
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _age.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Person'),
        centerTitle: true ,
      ),
      body: Column(
        children: [
          TextField(
            controller: _name ,
            keyboardType: TextInputType.name ,
            decoration: const InputDecoration(
              hintText: 'Name'
            ),
          ) ,
          TextField(
           controller: _age ,
            keyboardType: TextInputType.number ,
            decoration: const InputDecoration(
                hintText: 'Age'
            ),
          ) ,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () async {
              if(_age.text.isEmpty || _name.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Name and Age")));
              } else {
                final Person _personJson = Person(name: _name.text, age: int.parse(_age.text));
                await _person.add(_personJson);
                Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => const HomePage()), (route) => false);
              }
            },child: const Text('Add'),),
          )
        ],
      ),
    );
  }
}
