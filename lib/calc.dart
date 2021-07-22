import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:panache/models/paintColor.dart';
import 'package:panache/themes/colors.dart';
import 'package:panache/themes/config.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({Key key}) : super(key: key);

  @override
  _CalcPageState createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> with TickerProviderStateMixin {
  int _index = 0;
  // int selInd = 0;
  PaintColor _selectedColor;

  AnimationController _animationController;
  Animation _animation;

  TabController _tabController;

  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: types.length, vsync: this);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));

    _animationController.forward();

    _selectedColor = paints[0][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 30,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Calculator",
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.w100),
                ),
                Text(
                  "Estimate the cost for your home",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
                IconButton(
                  icon: Icon(currentTheme.isDarkTheme()
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  onPressed: () {
                    currentTheme.toggleTheme();
                  },
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Estimated cost",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
                Text(
                  "Rs. " +
                      (_height * _width * _selectedColor.costPerSqft)
                          .toStringAsFixed(2),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Height: " + _height.toStringAsFixed(0) + ' ft',
                    style: TextStyle(fontSize: 20),
                  ),
                  Slider(
                    activeColor: CustomColors.primary,
                    inactiveColor: CustomColors.primary.withAlpha(100),
                    min: 0,
                    max: 50,
                    divisions: 50,
                    value: _height,
                    onChanged: (value) {
                      setState(() {
                        _height = value;
                      });
                    },
                  ),
                  Text(
                    "Width: " + _width.toStringAsFixed(0) + ' ft',
                    style: TextStyle(fontSize: 20),
                  ),
                  Slider(
                    activeColor: CustomColors.primary,
                    inactiveColor: CustomColors.primary.withAlpha(100),
                    value: _width,
                    min: 0,
                    max: 50,
                    divisions: 50,
                    onChanged: (value) {
                      setState(() {
                        _width = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              width: double.infinity,
              /*  decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ), */
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultTabController(
                    length: types.length,
                    initialIndex: 0,
                    child: TabBar(
                      onTap: (i) {
                        setState(() {
                          _index = i;
                        });
                      },
                      isScrollable: true,
                      controller: _tabController,
                      unselectedLabelColor:
                          Theme.of(context).textTheme.bodyText1.color,
                      labelColor: Theme.of(context).primaryColor,
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: types
                          .map((s) => Tab(
                                child: Text(s),
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        // horizontal: 30,
                      ),
                      itemCount: paints[_index].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        List<PaintColor> p = paints[_index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                onTap: () {
                                  _animationController.reset();
                                  _animationController.forward();
                                  setState(() {
                                    _selectedColor = p[i];
                                    print(_selectedColor == p[i]);
                                  });
                                },
                                child: PhysicalModel(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromWidth(100.0),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: /* selInd == i */ _selectedColor ==
                                                    p[i]
                                                ? AnimatedCheck(
                                                    progress: _animation,
                                                    size: 50,
                                                    color: Colors.black,
                                                  ) /* Icon(Icons.check) */
                                                : Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  shape: BoxShape.rectangle,
                                  elevation: currentTheme.isDarkTheme() ? 0 : 7,
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: p[i].color,
                                  shadowColor: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
