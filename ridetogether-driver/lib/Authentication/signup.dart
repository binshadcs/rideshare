import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ridetogether/Authentication/car_info.dart';
import 'package:ridetogether/Authentication/login.dart';
import 'package:ridetogether/Global/global.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Widgets/progress_dialog.dart';


class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
      {
        Fluttertoast.showToast(msg: "Enter atleast 3 charactors");
      }
    else if(!emailTextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Enter valid Email address");
      }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Enter phone number");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be atleast 6 characters");
    }
    else
      {
        saveDriverInfoNow();
      }
  }

  saveDriverInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return Progress(message: "Processing please wait",);
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error" + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
      {
      Map driverMap =
          {
            "id": firebaseUser.uid,
            "name": nameTextEditingController.text.trim(),
            "email": emailTextEditingController.text.trim(),
            "phone": phoneTextEditingController.text.trim(),
          };

        DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
        driversRef.child(firebaseUser.uid).set(driverMap);

        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Account Created.");
        Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfo()));

      }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account Not Created.");
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:  [

              const SizedBox(height:150,),
              const Icon(
                Icons.person_rounded,
                color: Colors.black,
                size: 100,
              ),
              const Text(
                "Register as Driver",
                style: TextStyle(
                  fontSize: 25,
                  color:Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30,),

              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(
                  color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: 'Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: 'abcd@gmail.com',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),

              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: '9878987865',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: 'password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: ()
                  {
                    validateForm();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfo()));
                  },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent,
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),

              TextButton(
                child: const Text(
                    "Already hava Account?  Login Here",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: ()
                {
                  Navigator.push(context,MaterialPageRoute(builder: (c) =>Login()));
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}
