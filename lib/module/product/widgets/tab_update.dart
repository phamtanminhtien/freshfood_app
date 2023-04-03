import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/product/widgets/input_element.dart';

class TabUpdateProduct extends StatefulWidget {
  const TabUpdateProduct({Key? key}) : super(key: key);

  @override
  State<TabUpdateProduct> createState() => _TabUpdateProductState();
}

class _TabUpdateProductState extends State<TabUpdateProduct> {
  bool isSelected = false;
  String name = "";
  String origin = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: const Text("TabUpdateProduct"));
  }
}
