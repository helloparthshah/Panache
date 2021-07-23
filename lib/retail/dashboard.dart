import 'package:camera/camera.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:panache/retail/calc.dart';
import 'package:panache/retail/camera.dart';
import 'package:panache/retail/home.dart';
import 'package:panache/themes/colors.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key key}) : super(key: key);

  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  PageController _controller = PageController(initialPage: 0);
  int _selectedIndex = 0;

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
          HomePage(),
          CalcPage(),
          Container(
            color: Colors.black,
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: _selectedIndex == 0 ? 1 : 0,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            WidgetsFlutterBinding.ensureInitialized();
            List<CameraDescription> cameras = await availableCameras();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage(cameras)),
            );
          },
          child: Icon(
            Icons.camera,
            color: Colors.white,
          ),
          tooltip: 'Visualizer',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: CustomColors.primary,
            // unselectedItemColor: CustomColors.grey,
            unselectedItemColor: CustomColors.aquagreen,
            currentIndex: _selectedIndex,
            // selectedItemColor: CustomColors.primary,
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
                label: 'Home',
                icon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Calculator',
                icon: Icon(Icons.calculate),
              ),
              BottomNavigationBarItem(
                label: 'Library',
                icon: Icon(Icons.folder_open_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
