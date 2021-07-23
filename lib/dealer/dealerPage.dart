import 'package:flutter/material.dart';
import 'package:panache/themes/colors.dart';
import 'package:panache/themes/config.dart';

class DealerPage extends StatefulWidget {
  const DealerPage({Key key}) : super(key: key);

  @override
  _DealerPageState createState() => _DealerPageState();
}

class _DealerPageState extends State<DealerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Panache",
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.w100),
            ),
            Text(
              "Greens",
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.normal),
            ),
            IconButton(
              icon: Icon(currentTheme.isDarkTheme()
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: () {
                currentTheme.toggleTheme();
              },
            ),
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
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: CustomColors.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.pie_chart,
                                color: CustomColors.white,
                              ),
                              Text('4243',
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
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                              Icon(
                                Icons.pie_chart,
                                color: CustomColors.white,
                              ),
                              Text('1234',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.w100,
                                  )),
                              Text('Paints sold yet',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.white,
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
    );
  }
}
