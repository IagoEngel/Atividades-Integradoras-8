import 'package:atividadeintegradora8/telas/etapa1.dart';
import 'package:atividadeintegradora8/telas/telalogin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividades Integradoras 8',
      debugShowCheckedModeBanner: false,
      home: TelaLogin(),
    );
  }
}