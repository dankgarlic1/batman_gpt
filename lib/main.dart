import 'package:bataman_gpt/chat_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main () async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Batman GPT",
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,//optional
      ),
      home:const chat_screen_layouts() ,
    );

  }
}
