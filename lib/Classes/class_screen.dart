import 'package:flockergym/NewBackend/ClassesBack/ClassesMethods.dart';
import 'package:flutter/material.dart';


class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  Widget build(BuildContext context) {
    return ClassesMethods().start("Main", context);
  }
}
