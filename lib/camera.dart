import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panache/paintpage.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraPage(this.cameras, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  // List<Uint8List> bytelist;
  // int height;
  // int width;
  bool t = false;
  String c = "#ff3a2b";
  Offset o = Offset(200, 200);

  Uint8List im;

  @override
  void initState() {
    super.initState();

    controller = CameraController(widget.cameras[0], ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        t = false;
      });
      controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      // setState(() {});
      controller.startImageStream((CameraImage img) async {
        // controller.stopImageStream();
        // print(img.planes[0].bytes);
        if (t) {
          print('test');
          setState(() {
            t = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaintPage(img)),
          );
        }
        /* setState(() {
           bytelist = img.planes.map((plane) {
            return plane.bytes;
          }).toList();
          height = img.height;
          width = img.width;
        }); */

        // image = img;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (!controller.value.isInitialized) {
      return Container();
    }
    var camera = controller.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: Transform.scale(
              scale: scale,
              child: Center(
                child: CameraPreview(controller),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.photo,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                t = true;
              });
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 8,
                ),
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Icon(
            Icons.photo,
            color: Colors.white,
          ),
        ],
      ), /* FloatingActionButton(
        onPressed: () {
          setState(() {
            t = true;
          });
        },
        child: Icon(Icons.camera),
      ), */
    );
  }
}
