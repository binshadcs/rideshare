import 'package:flutter/material.dart';
import 'package:ridetogether/Authentication/login.dart';
import 'package:ridetogether/SplashScreen/splash_screen.dart';

import '../Global/global.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          child: const Text(
            "Sign Out",
          ),
          onPressed: ()
          {
            fAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c)=> Login()));
          },
        ),
    );
  }
}

