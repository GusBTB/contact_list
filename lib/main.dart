import 'package:contact_list/models/user_hive.dart';
import 'package:contact_list/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = 'NCTtNQ88ycNFbHPtZf9X68Tlz2qlWDePfqhRJYmp';
  const keyClientKey = 'IeJKJ0bOqlwdHT3VjaYwXenfT3MhfmzWOorP7p7s';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveAdapter());
  userBox = await Hive.openBox<UserHive>('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const RegisterPage();
  }
}
