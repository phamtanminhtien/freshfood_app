import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshfood_app/constant.dart';

class InputElement extends StatefulWidget {
  const InputElement(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onChange})
      : super(key: key);
  final IconData icon;
  final String label;
  final Function onChange;

  @override
  State<InputElement> createState() => _InputElementState();
}

class _InputElementState extends State<InputElement> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Icon(
                    widget.icon,
                    color: isSelected ? primaryColor : grayColor,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  //screen width - 100
                  width: MediaQuery.of(context).size.width - 160,
                  child: TextField(
                    onTapOutside: (e) => {
                      setState(() {
                        isSelected = false;
                      })
                    },
                    onTap: () => {
                      setState(() {
                        isSelected = true;
                      })
                    },
                    onChanged: (value) {
                      widget.onChange(value);
                    },
                    decoration: InputDecoration(
                        labelText: widget.label, border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(height: 10),
      ],
    ));
  }
}
