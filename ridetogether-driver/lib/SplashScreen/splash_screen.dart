import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ridetogether/Authentication/login.dart';
import 'package:ridetogether/Authentication/signup.dart';
import 'package:ridetogether/Global/global.dart';
import 'package:ridetogether/MainScreen/main_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  startTimer()
  {
    Timer(const Duration(seconds:3), () async{

      if(await fAuth.currentUser != null)
        {
          currentFirebaseUser = fAuth.currentUser;
          Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
        }
      else
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUp()));
        }

    });
  }
  @override
  void initState() {
    super.initState();

    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.drive_eta_rounded,
                color: Colors.yellow,
                size: 60,
              ),
              Text(style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
                  'RideTogether'
              ),
            ],
          ),
        ),
      ),
    );
  }
}
