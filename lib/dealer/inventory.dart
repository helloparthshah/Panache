import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panache/dealer/paintInventory.dart';
import 'package:panache/models/dealerTypes.dart';
import 'package:panache/models/paintColor.dart';
import 'package:panache/themes/colors.dart';
import 'package:panache/themes/config.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key key}) : super(key: key);

  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Inventory",
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.w100),
              ),
              IconButton(
                icon: Icon(currentTheme.isDarkTheme()
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: () {
                  currentTheme.toggleTheme();
                },
              ),
              Column(
                children: dealerTypes.map((d) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaintInventory(
                                    type: d,
                                  )),
                        );
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: CustomColors.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.type,
                                style: TextStyle(
                                  fontSize: 35,
                                  color: CustomColors.white,
                                  // fontWeight: FontWeight.w100,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(d.stock.toString(),
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: CustomColors.white,
                                            fontWeight: FontWeight.w100,
                                          )),
                                      Text('Paints in stock',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: CustomColors.white,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(d.sold.toString(),
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: CustomColors.white,
                                            fontWeight: FontWeight.w100,
                                          )),
                                      Text('Paints sold',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: CustomColors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              /* ListView.builder(
                  itemCount: types.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: CustomColors.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                types[index],
                                style: TextStyle(
                                  fontSize: 35,
                                  color: CustomColors.white,
                                  // fontWeight: FontWeight.w100,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(Random().nextInt(10000).toString(),
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: CustomColors.white,
                                            fontWeight: FontWeight.w100,
                                          )),
                                      Text('Paints in stock',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: CustomColors.white,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(Random().nextInt(10000).toString(),
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: CustomColors.white,
                                            fontWeight: FontWeight.w100,
                                          )),
                                      Text('Paints sold',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: CustomColors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }), */
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text('Order paints'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
