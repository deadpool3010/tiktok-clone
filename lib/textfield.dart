import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class textfield extends StatelessWidget {
  late String lebal;
  late TextEditingController controller;

  textfield(String lebal, TextEditingController controller) {
    this.lebal = lebal;
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: lebal),
      controller: controller,
    );
  }
}
