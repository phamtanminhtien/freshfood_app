import 'package:flutter/material.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:freshfood_app/module/product/widgets/tab_create.dart';
import 'package:freshfood_app/module/product/widgets/tab_update.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freshfood_app/constant.dart';
import 'package:provider/single_child_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> tabs = [
    "Create",
    "Update",
  ];

  Widget changeEvent(BuildContext context, int index) {
    switch (index) {
      case 1:
        return const TabUpdateProduct();
      case 0:
      default:
        return const TabCreateProduct();
    }
  }

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(
            isBack: true,
            isLogout: true,
            nameScreen: "Create",
            descriptionScreen: "or update a product"),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        //text under line
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: current == index
                                        ? primaryColor
                                        : Colors.transparent,
                                    width: 3))),

                        child: Text(
                          tabs[index],
                          style: GoogleFonts.poppins(
                              color: current == index ? textColor : grayColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }),
            ),
            SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: changeEvent(context, current)),
          ],
        )));
  }
}
