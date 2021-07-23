import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:panache/dealer/dealerPage.dart';
import 'package:panache/dealer/inventory.dart';
import 'package:panache/models/dealerTypes.dart';
import 'package:panache/themes/colors.dart';

class DealerHome extends StatefulWidget {
  const DealerHome({Key key}) : super(key: key);

  @override
  _DealerHomeState createState() => _DealerHomeState();
}

class _DealerHomeState extends State<DealerHome> {
  PageController _controller = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initDealerTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          DealerPage(),
          Inventory(),
          Scaffold(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                CustomColors.aquagreen,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(
                  150,
                  50,
                ),
              ),
            ),
            onPressed: () {},
            child: Text('Purchase'),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                CustomColors.aquagreen,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(
                  150,
                  50,
                ),
              ),
            ),
            onPressed: () {},
            child: Text('Sale'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            backgroundColor: CustomColors.primary,
            unselectedItemColor: CustomColors.aquagreen,
            currentIndex: _selectedIndex,
            selectedItemColor: CustomColors.white,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;

                _controller.animateToPage(index,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              });
            },
            items: [
              BottomNavigationBarItem(
                label: 'Dashboard',
                icon: Icon(Icons.dashboard),
              ),
              BottomNavigationBarItem(
                label: 'View Inventory',
                icon: Icon(Icons.inventory),
              ),
              BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
