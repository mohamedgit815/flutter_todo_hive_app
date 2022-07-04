import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_app/hive_model.dart';
import 'package:flutter_hive_app/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class UpdatePersonPage extends StatefulWidget {
  final String name , age;
  final int index;
  const UpdatePersonPage({Key? key,required this.name , required this.age ,required this.index}) : super(key: key);

  @override
  _UpdatePersonPageState createState() => _UpdatePersonPageState();
}

class _UpdatePersonPageState extends State<UpdatePersonPage> {
  final TextEditingController _nameUpdate = TextEditingController();
  final TextEditingController _ageUpdate = TextEditingController();

  late Box _person;

  @override
  void initState() {
    super.initState();
    _person = Hive.box<Person>('person');
    _nameUpdate.text = widget.name;
    _ageUpdate.text = widget.age;
  }

  @override
  void dispose() {
    super.dispose();
    //_nameUpdate.dispose();
    //_ageUpdate.dispose();
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
            controller: _nameUpdate ,
            keyboardType: TextInputType.name ,
            decoration: const InputDecoration(
                hintText: 'Name'
            ),
          ) ,
          TextField(
            controller: _ageUpdate ,
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
                if(_ageUpdate.text.isEmpty || _nameUpdate.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Name and Age")));
                } else {
                  final Person _personJson = Person(name: _nameUpdate.text, age: int.parse(_ageUpdate.text));
                  await _person.put(widget.index,_personJson);
                  Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => const HomePage()), (route) => false);
                }
              },child: const Text('Updated'),),
          )
        ],
      ),
    );
  }
}
