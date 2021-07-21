import 'package:flutter/material.dart';
import 'package:panache/select.dart';
import 'package:panache/signup.dart';
import 'package:panache/themes/config.dart';
import 'package:panache/themes/config.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  String loginErr;

  @override
  void initState() {
    super.initState();
    // newUser();
    initAuth();
  }

  Future<void> checkNewUser() async {
    /* SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNew = prefs.getBool('isNew') ?? true;
    print('IsNew: ' + isNew.toString());
    if (!isNew) {
      runApp(MyHome());
    } else {
      runApp(LandingPage());
    } */
  }

  void initAuth() async {
    /* await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      print(user);

      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        await checkNewUser();
      }
    }); */
  }

  Future<String> _signIn() async {
    /* try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _pass.text,
      );
      print('Logged in');
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } */
    return 'success';
  }

  bool isEmail(String value) {
    String regex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(regex);

    return value.isNotEmpty && regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: secondary,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 30),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SelectPage()),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(
                          80,
                          20,
                        ),
                      ),
                    ),
                    child: Text('Skip'),
                  ),
                ),
              ),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 300,
              ),
              /* FlutterLogo(
                size: 300,
              ), */
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create Account',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            /* Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 30),
                              child: TextFormField(
                                controller: _email,
                                // style: TextStyle(color: textcolor),
                                keyboardType: TextInputType.emailAddress,
                                decoration: currentTheme.getInputDecoration(
                                    'Email',
                                    loginErr == 'No user found for that email.',
                                    loginErr),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  /* if (value.isEmpty) {
                                    return 'Email cannot be empty';
                                  }
                                  if (!isEmail(value)) {
                                    return 'Please enter a valid email';
                                  } */
                                  return null;
                                },
                              ),
                            ), */
                            TextFormField(
                              controller: _pass,
                              // style: TextStyle(color: textcolor),
                              keyboardType: TextInputType.phone,
                              autofillHints: [AutofillHints.telephoneNumber],
                              // obscureText: true,
                              decoration: currentTheme.getInputDecoration(
                                  'Mobile Number',
                                  loginErr ==
                                      'Wrong password provided for that user.',
                                  loginErr),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                /* if (value.isEmpty) {
                                  return 'Password cannot be empty';
                                } */
                                return null;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextButton(
                                onPressed: () async {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  setState(() {
                                    loginErr = null;
                                  });
                                  if (_formKey.currentState.validate()) {
                                    String x = await _signIn();
                                    if (x == 'success') checkNewUser();
                                    if (x == 'user-not-found') {
                                      setState(() {
                                        loginErr =
                                            'No user found for that email.';
                                      });
                                    } else if (x == 'wrong-password') {
                                      setState(() {
                                        loginErr =
                                            'Wrong password provided for that user.';
                                      });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUpPage()),
                                      );
                                    }
                                  }
                                },
                                child: Text('Continue'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* IconButton(
                        icon: const Icon(Icons.brightness_4),
                        onPressed: () => currentTheme.toggleTheme(),
                      ) */
                    ],
                  ),
                ),
              ),
              SizedBox(),
              /* Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                          // color: textcolor,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //Register
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SelectPage()),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          // color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
