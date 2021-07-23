import 'package:flutter/material.dart';
import 'package:panache/retail/dashboard.dart';
import 'package:panache/dealer/dealerHome.dart';
import 'package:panache/themes/colors.dart';
import 'package:panache/themes/config.dart';

class SelectPage extends StatefulWidget {
  SelectPage({Key key}) : super(key: key);

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  int selectedIndex = -1;
  List<String> types = [
    'Home Owner',
    'Architect / Designer',
    'Dealer',
    'Contractor / Painter'
  ];
  String loginErr;

  @override
  void initState() {
    super.initState();
    // newUser();
    // initAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: secondary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tell us who you are?',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Column(
                children: new List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedIndex == index
                                ? Theme.of(context).primaryColor
                                : currentTheme.isDarkTheme()
                                    ? CustomColors.white
                                    : CustomColors.black,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(types[index]),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  onPressed: () async {
                    if (selectedIndex == 2)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DealerHome()),
                      );
                    else
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DashPage()),
                      );
                  },
                  child: Text('Continue'),
                ),
              ),
              /*  IconButton(
                icon: const Icon(Icons.brightness_4),
                onPressed: () => currentTheme.toggleTheme(),
              ) */
            ],
          ),
        ),
      ),
    );
  }
}
