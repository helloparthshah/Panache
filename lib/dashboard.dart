import 'package:camera/camera.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:panache/camera.dart';
import 'package:panache/home.dart';
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
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
        tooltip: 'Paint',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Library',
              icon: Icon(Icons.folder_open_outlined),
            ),
          ],
        ),
      ),
    );
  }
}