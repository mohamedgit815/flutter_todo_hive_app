import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_app/add_person_page.dart';
import 'package:flutter_hive_app/hive_model.dart';
import 'package:flutter_hive_app/show_data.dart';
import 'package:flutter_hive_app/update_data.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box _person;

  @override
  void initState() {
    super.initState();
    _person = Hive.box<Person>('person');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Main"),centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.add),onPressed: (){
          if(kDebugMode){
            print(_person.length);
          }
        },),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> const AddPersonPage()));
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: _person.length  ,
            itemBuilder: (BuildContext context,int i) {
              final Person _personModel = _person.get(i) as Person;
              return ListTile(
                key: ValueKey('${_personModel.name}${_personModel.age}'),
                  title: Text(_personModel.name),
                  subtitle: Text(_personModel.age.toString()),
                leading: IconButton(
                  key: ValueKey('${_personModel.name}${_personModel.age}'),
                  icon: const Icon(Icons.update,color: Colors.red),
                  onPressed: ()  {
                       Navigator.push(context, CupertinoPageRoute(builder: (context)=>UpdatePersonPage(
                         index: i,
                         name: _personModel.name,age: _personModel.age.toString(),)));
                  },
                ),
                trailing: IconButton(
                  key: ValueKey('${_personModel.name}${_personModel.age}'),
                  icon: const Icon(Icons.delete,color: Colors.red),
                  onPressed: () {
                       setState(() {
                         _person.delete(i);
                       });
                  },
                ),
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(
                      builder: (context)=>ShowPersonData(name: _personModel.name, age: _personModel.age)));
                },
              );
            })
    );
  }
}