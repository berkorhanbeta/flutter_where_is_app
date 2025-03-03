import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whereis/utils/images.dart';
import 'package:whereis/utils/page_navigation.dart';


const List<String> scopes = <String>[
  'email',
];

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
  forceCodeForRefreshToken: true
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var credential;

  @override
  void initState() {
    super.initState();
    if(kIsWeb){
      _googleSignIn.signInSilently();
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
        await _googleSignIn.canAccessScopes(scopes);
        setState(()  {
          Get.offNamed(PageNavigation.home);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image(image: AssetImage('${Images.app_logo}')),
                ),
                Text(
                  'Where Is Application',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox()
              ],
            ),
          ],
        ),
      ),
    );

  }
}

/*

    final GoogleSignInAccount? user = _currentUser;
    if(user != null) {
      return Text('${user.email}');
    } else {
      return web.renderButton();
    }


 */