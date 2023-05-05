import 'package:flutter/material.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:freshfood_app/module/dashboard/screens/product_view.dart';
import 'package:freshfood_app/module/dashboard/widget/product_chart.dart';
import 'package:freshfood_app/module/dashboard/widget/dashboard_chart.dart';
import 'package:freshfood_app/constant.dart';
import 'package:provider/single_child_widget.dart';
import 'package:freshfood_app/module/product/models/product.dart';

import '../widget/product_card.dart';

List<Product> products = [
  Product(productId: '1', name: 'Apple', origin: 'DaLat', status: 0),
  Product(productId: '2', name: 'Orange', origin: 'DaLat', status: 1),
  Product(productId: '3', name: 'Banana', origin: 'DaLat', status: 2),
  Product(productId: '4', name: 'Grape', origin: 'DaLat'),
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int pageViewIndex = 0;
  final PageController _pageController = PageController();

  Product productPressed = Product(productId: '', name: '', origin: '');

  @override
  void initState() {
    super.initState();
    productPressed = products[0];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPressProduct(Product product) {
    setState(() {
      productPressed = product;
      pageViewIndex = 1;
    });

    if (_pageController.hasClients) {
      _pageController.animateToPage(pageViewIndex,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
    print("id: " + productPressed.productId);
    print("name: " + productPressed.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
            isBack: pageViewIndex == 0 ? false : true,
            onBackChanged: () {
              setState(() {
                pageViewIndex = 0;
              });
              if (_pageController.hasClients) {
                _pageController.animateToPage(pageViewIndex,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              }
            },
            isLogout: false,
            nameScreen: "Dashboard",
            descriptionScreen: "chart and analytics"),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              pageViewIndex = index;
            });
          },
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: AspectRatio(
                      aspectRatio: 1.23,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 16, left: 6),
                                  child: DashboardChart(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                      children: products
                          .map((e) => ProductCard(
                              product: e, onPressProduct: onPressProduct))
                          .toList()),
                ],
              ),
            ),
            ProductView(product: productPressed),
          ],
        ));
  }
}
