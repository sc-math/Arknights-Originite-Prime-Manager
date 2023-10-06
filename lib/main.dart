import 'package:arknights_gerenciador/screens/initial_screen.dart';
import 'package:flutter/material.dart';

void main(){

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arknights Gerenciador',
      theme: ThemeData.dark(),
      home:  InitialScreen(),
    );
  }
}