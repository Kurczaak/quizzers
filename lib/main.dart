import 'package:flutter/material.dart';
import 'package:quizzers/di/injection.config.dart';
import 'package:quizzers/di/injection.dart';
import 'package:quizzers/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.init();
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
      home: const HomePage(),
    );
  }
}
