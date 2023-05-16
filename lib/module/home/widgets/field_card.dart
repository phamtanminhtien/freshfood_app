import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/home/models/field.dart';
import 'package:freshfood_app/module/home/screens/home.dart';
import 'package:freshfood_app/module/product/models/product.dart';

class FieldCard extends StatelessWidget {
  final Product product;

  final imageDefault =
      "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg";

  const FieldCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      product.image ?? imageDefault,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size.fromHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "#${product.productId} - ${product.name}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 15,
                              ),
                              Text(
                                product.origin,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: const BoxDecoration(
                            color: homeBackgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: const Text(
                          "30 Ngày",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
