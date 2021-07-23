import 'package:flutter/material.dart';
import 'package:panache/models/dealerTypes.dart';
import 'package:panache/themes/colors.dart';

class PaintInventory extends StatefulWidget {
  final DealerTypes type;
  const PaintInventory({Key key, this.type}) : super(key: key);

  @override
  _PaintInventoryState createState() => _PaintInventoryState();
}

class _PaintInventoryState extends State<PaintInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200)),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Center(
              child: Text(
                widget.type.type,
                style: TextStyle(fontSize: 50),
              ),
            ),
          )),
          Container(
            height: 250,
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.pie_chart,
                                    // color: CustomColors.white,
                                  ),
                                  Text(widget.type.stock.toString(),
                                      style: TextStyle(
                                        fontSize: 40,
                                        // color: CustomColors.white,
                                        fontWeight: FontWeight.w100,
                                      )),
                                  Text('Paints in stock',
                                      style: TextStyle(
                                        fontSize: 20,
                                        // color: CustomColors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.pie_chart,
                                    // color: CustomColors.white,
                                  ),
                                  Text(widget.type.sold.toString(),
                                      style: TextStyle(
                                        fontSize: 40,
                                        // color: CustomColors.white,
                                        fontWeight: FontWeight.w100,
                                      )),
                                  Text('Paints sold yet',
                                      style: TextStyle(
                                        fontSize: 20,
                                        // color: CustomColors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
