import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/dashboard/screens/product_view.dart';
import 'package:freshfood_app/module/product/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onPressProduct;

  const ProductCard(
      {Key? key, required this.product, required this.onPressProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
        onTap: () {
          onPressProduct(product);
        },
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Image.asset(
                              "assets/images/field.png",
                              width: 60,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  product.origin,
                                  style: const TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              ])
                        ]),
                    Container(
                      alignment: Alignment.center,
                      child: TextStatusBuild(
                        product.status ?? -1,
                      ),
                    )
                  ],
                )))));
  }
}

Text TextStatusBuild(int status) {
  switch (status) {
    case 0:
      return const Text(
        "Process",
        style: TextStyle(
            color: textBlueColor, fontWeight: FontWeight.normal, fontSize: 12),
        textAlign: TextAlign.center,
      );

    case 1:
      return const Text(
        "Delivery",
        style: TextStyle(
            color: textOrangeColor,
            fontWeight: FontWeight.normal,
            fontSize: 12),
        textAlign: TextAlign.center,
      );
    case 2:
      return const Text(
        "Done",
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.normal, fontSize: 12),
        textAlign: TextAlign.center,
      );
    case -1:
    default:
      return const Text(
        "No data",
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.normal, fontSize: 12),
        textAlign: TextAlign.center,
      );
  }
}
