import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
