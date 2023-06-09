import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/dashboard/screens/product_view.dart';
import 'package:freshfood_app/module/product/models/product.dart';
import 'package:freshfood_app/module/providers/restapi.dart';
import 'package:freshfood_app/module/utils/hash-object.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onPressProduct;

  final imageDefault =
      "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg";

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
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                width: MediaQuery.of(context).size.width,
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
                            child: Image.network(
                              product.image != ""
                                  ? product.image!
                                  : imageDefault,
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
                                Container(
                                    width: 200,
                                    child: Text(
                                      '#${product.productId} - ${product.name}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  product.origin,
                                  overflow: TextOverflow.ellipsis,
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
