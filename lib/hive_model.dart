import 'package:hive/hive.dart';
part 'hive_model.g.dart';


@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0,defaultValue: "Null")
  late String name;

  @HiveField(1,defaultValue: 0)
  late int age;

  Person({required this.name , required this.age });
}