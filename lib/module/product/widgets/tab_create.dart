import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/product/widgets/input_element.dart';
import 'package:freshfood_app/module/providers/walletconnect.dart';
import 'package:provider/provider.dart';

class TabCreateProduct extends StatefulWidget {
  const TabCreateProduct({Key? key}) : super(key: key);

  @override
  State<TabCreateProduct> createState() => _TabCreateProductState();
}

class _TabCreateProductState extends State<TabCreateProduct> {
  bool isSelected = false;
  bool isSubmit = false;
  String productName = "";
  String productOrigin = "";
  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    return GestureDetector(
        child: Container(
      child: Column(
        children: [
          InputElement(
            icon: Icons.title,
            label: "Product name",
            onChange: (value) => {
              productName = value,
              setState(() {
                isSubmit = false;
              })
            },
          ),
          InputElement(
              icon: Icons.location_on,
              label: "Origin",
              onChange: (value) => {
                    productOrigin = value,
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
              onPressed: () async {
                if (productName == "" || productOrigin == "") {
                  setState(() {
                    isSubmit = true;
                  });
                } else {
                  await walletProvider
                      .addProduct(productName, productOrigin)
                      .then((result) =>
                          {walletProvider.showAlertDialog(context, result)})
                      .catchError((err) => {
                            walletProvider.showAlertDialog(
                                context, err.toString())
                          });
                }
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
