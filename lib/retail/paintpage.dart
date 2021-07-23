import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:animated_check/animated_check.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:panache/themes/config.dart';

import '../models/paintColor.dart';

class PaintPage extends StatefulWidget {
  final CameraImage image;
  PaintPage(this.image, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> with TickerProviderStateMixin {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  // List<Uint8List> bytelist;
  // int height;
  // int width;
  // String c = "#000000";
  Offset o = Offset(200, 200);
  List<PaintColor> rec = List<PaintColor>.empty(growable: true);
  int _index = 0;
  // int selInd = 0;
  PaintColor _selectedColor;

  Offset pos = Offset(0, 0);

  var _animationController;
  Animation _animation;

  // Uint8List im;
  var im;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 6, vsync: this);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));

    for (int i = 0; i < 5; i++) {
      Color c =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      rec.add(PaintColor(c.toString(), c, "Recomended", 0, 0, 0, false,
          Random().nextDouble() * 10));
    }
    _selectedColor = rec[0];
    _animationController.forward();
    getImg(widget.image);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getImg(CameraImage img) async {
    /* List<Uint8List> bytelist = img.planes.map((plane) {
      return plane.bytes;
    }).toList(); */
    List<int> strides = new Int32List(img.planes.length * 2);
    int index = 0;
    // We need to transform the image to Uint8List so that the native code could
    // transform it to byte[]
    List<Uint8List> data = img.planes.map((plane) {
      strides[index] = (plane.bytesPerRow);
      index++;
      strides[index] = (plane.bytesPerPixel);
      index++;
      return plane.bytes;
    }).toList();
    // print(bytelist);
    int height = img.height;
    int width = img.width;
    try {
      final Uint8List result = await platform.invokeMethod('getBatteryLevel', {
        "bytelist": data,
        "height": height,
        "width": width,
        "strides": strides,
        "color":
            '#${(_selectedColor.color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}',
        "x": o.dx,
        "y": o.dy
      });
      setState(() {
        // t = true;
        im = result;
      });
      // print(im);
    } on PlatformException catch (e) {
      print(e.message);
    }

    /* setState(() {
      _batteryLevel = batteryLevel;
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (TapUpDetails tap) {
              setState(() {
                var test = Size(widget.image.width.toDouble(),
                    widget.image.height.toDouble());
                o = Offset(
                    tap.localPosition.dx * test.aspectRatio, //720
                    tap.localPosition.dy * test.aspectRatio);
                getImg(widget.image);
                // print(test.aspectRatio);
              });
              print(tap.globalPosition);
            },
            onTapDown: (TapDownDetails tap) {
              setState(() {
                pos = tap.localPosition;
              });
            },
            child: im != null
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.memory(
                        im,
                        width: double.infinity,
                        // height: 385,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: pos.dx - 50 / 2,
                        top: pos.dy - 50 / 2,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: new BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTabController(
                      length: 4,
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
                        tabs: [
                          Tab(
                            child: Text('Recommended for you'),
                          ),
                          for (var s in types)
                            Tab(
                              child: Text(s),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30,
                        ),
                        itemCount: _index == 0
                            ? rec.length
                            : paints[_index - 1].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          List<PaintColor> p =
                              _index == 0 ? rec : paints[_index - 1];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _animationController.reset();
                                _animationController.forward();
                                setState(() {
                                  // c = '#${(p[i].color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

                                  // selInd = i;
                                  _selectedColor = p[i];
                                  print(_selectedColor == p[i]);
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
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
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 2,
                                              ),
                                              child: p[i].bookmarked
                                                  ? Icon(Icons.bookmark)
                                                  : SizedBox(),
                                            ),
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
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedColor.toggleBookmark();
                                // paints[0][selInd].toggleBookmark();
                              });
                            },
                            icon: Icon(Icons.bookmark_add_rounded),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(
                                  150,
                                  50,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Done'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
