import 'package:flockergym/NewBackend/RouterBack/RouterMethods.dart';
import 'package:flutter/material.dart';

class RouterScreen extends StatefulWidget {
  RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {

  @override
  Widget build(BuildContext context) {
    return RouterMethods().start(context);
  }
}
