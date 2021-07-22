import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:panache/login.dart';
import 'package:panache/themes/config.dart';
import 'package:panache/themes/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    currentTheme.addListener(() {
      setState(() {});
    });
    /* currentTheme.setTheme(
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark);
 */
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panache',
      debugShowCheckedModeBanner: false,
      /* theme: ThemeData(
        primarySwatch: Colors.blue,
      ), */
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      // themeMode: ThemeMode.system,
      themeMode: currentTheme.currentTheme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image(
            image: AssetImage('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}
