import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/product/widgets/input_element.dart';

class TabCreateProduct extends StatefulWidget {
  const TabCreateProduct({Key? key}) : super(key: key);

  @override
  State<TabCreateProduct> createState() => _TabCreateProductState();
}

class _TabCreateProductState extends State<TabCreateProduct> {
  bool isSelected = false;
  bool isSubmit = false;
  String name = "";
  String origin = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      child: Column(
        children: [
          InputElement(
            icon: Icons.title,
            label: "Product name",
            onChange: (value) => {
              name = value,
              setState(() {
                isSubmit = false;
              })
            },
          ),
          InputElement(
              icon: Icons.location_on,
              label: "Origin",
              onChange: (value) => {
                    origin = value,
                    setState(() {
                      isSubmit = false;
                    })
                  }),
          isSubmit
              ? const Text(
                  "Please enter fullfill",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                )
              : const SizedBox(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (name == "" || origin == "") {
                  setState(() {
                    isSubmit = true;
                  });
                } else
                  print(name + "-----" + origin);
              },
              child: const Text("Save"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          )
        ],
      ),
    ));
  }
}
