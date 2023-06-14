import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:freshfood_app/module/dashboard/screens/product_view.dart';
import 'package:freshfood_app/module/dashboard/widget/dashboard_chart.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/providers/walletconnect.dart';
import 'package:provider/provider.dart';
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
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    var productFuture =
        walletProvider.getProductByOwner(walletProvider.account);
    return Scaffold(
        appBar: AppBarCustom(
            isBack: pageViewIndex == 0 ? false : true,
            onBackChanged: () {
              setState(() {
                pageViewIndex = 0;
              });
              if (_pageController.hasClients) {
                _pageController.animateToPage(pageViewIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
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
                              FutureBuilder(
                                  future: productFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      // print(snapshot.data);
                                      final data = snapshot.data;

                                      // print(data?[0]);
                                      var listLabelsChart = [];
                                      var listDataChart = [];
                                      var listDataProcessChart = [];
                                      var listDataDeliveryChart = [];

                                      int timestamp = 0;
                                      int timestampCreate = 0;
                                      int timeProcess = 0;
                                      int timeProcessTemp = 0;
                                      int timeDelivery = 0;
                                      int timeDeliveryTemp = 0;

                                      data?[0].forEach((d) => {
                                            listDataChart = d[4],
                                            print(listDataChart),
                                            listDataChart.forEachIndexed((index,
                                                    dc) =>
                                                {
                                                  timestamp = int.parse(
                                                      dc[3].toString()),
                                                  if (dc[0] == "create")
                                                    {
                                                      timestampCreate =
                                                          timestamp
                                                    }
                                                  else if (dc[0] == "delivery")
                                                    {
                                                      timeDelivery = 1 +
                                                          (timestamp -
                                                                  timestampCreate) ~/
                                                              86400,
                                                      if (timeDelivery ==
                                                          timeProcess)
                                                        timeDelivery =
                                                            timeDelivery + 1,
                                                      // if (timeDelivery < 0)
                                                      //   timeDelivery = 0,
                                                    }
                                                  else
                                                    {
                                                      timeProcessTemp = 1 +
                                                          (timestamp -
                                                                  timestampCreate) ~/
                                                              86400,
                                                      if (timeProcessTemp > 0)
                                                        timeProcess =
                                                            timeProcessTemp,
                                                      // if (timeProcess < 0)
                                                      //   timeProcess = 0,
                                                      // print("hi"),
                                                      // print(dc[3]),

                                                      // listDataDeliveryChart
                                                      //     .add(0)
                                                    }
                                                  //check element last
                                                  ,
                                                  if (index ==
                                                      listDataChart.length - 1)
                                                    {
                                                      if (timeDelivery == 0 &&
                                                          timeProcess != 0)
                                                        timeDelivery =
                                                            timeProcess,
                                                      listDataProcessChart
                                                          .add(timeProcess),
                                                      listDataDeliveryChart
                                                          .add(timeDelivery),
                                                      timeProcess = 0,
                                                      timeDelivery = 0,
                                                    }
                                                }),
                                            listLabelsChart
                                                .add("#${d[0]} - ${d[1]}"),
                                          });

                                      print("listLabelsChart: ");
                                      print(listLabelsChart);
                                      print("dataChart: ");
                                      print(listDataProcessChart);
                                      print("deliveryChart: ");
                                      print(listDataDeliveryChart);

                                      var apiChart = {
                                        "labels": listLabelsChart,
                                        "data": {
                                          "process": listDataProcessChart,
                                          "delivery": listDataDeliveryChart
                                        },
                                      };

                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, left: 6),
                                          child: DashboardChart(
                                            apiChart: apiChart,
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder<List<dynamic>>(
                      future: productFuture,
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          List<Product> products = [];
                          int status = -1;
                          data?[0]
                                  ?.map((e) => {
                                        e[4].forEach((el) => {
                                              if (el[0] == 'done')
                                                status = 2
                                              else if (el[0] == 'delivery')
                                                status = 1
                                              else if (el[0] == 'create')
                                                status = 0
                                            }),
                                        products.add(Product(
                                          productId: e[0].toString(),
                                          name: e[1],
                                          origin: e[2],
                                          log: e[4],
                                          image: e[6],
                                          status: status,
                                        ))
                                      })
                                  .toList() ??
                              [];
                          if (products.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "No data",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Please add product to view in here")
                                ],
                              ),
                            );
                          }
                          // productPressed = products[0];

                          return Column(
                              children: products
                                  .map((e) => ProductCard(
                                      product: e,
                                      onPressProduct: onPressProduct))
                                  .toList());
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ),
            ProductView(product: productPressed),
          ],
        ));
  }
}
