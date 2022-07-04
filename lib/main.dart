import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_app/hive_model.dart';
import 'package:flutter_hive_app/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //final Directory _path = await getApplicationDocumentsDirectory();

  //Hive.init(_path.path);
  await Hive.initFlutter();


  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox<Person>('person');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

