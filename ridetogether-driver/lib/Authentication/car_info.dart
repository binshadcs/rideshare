import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ridetogether/Authentication/login.dart';
import 'package:ridetogether/Global/global.dart';
import 'package:ridetogether/SplashScreen/splash_screen.dart';


class CarInfo extends StatefulWidget {
  const CarInfo({Key? key}) : super(key: key);

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {


  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ["Uber-x", "Uber-go","bike"];
  String? selectedCarType;


  saveCarInfo() {
    Map driverCarInfoMap =
    {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child(
        "drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(
        driverCarInfoMap);

    Fluttertoast.showToast(msg: "Car Details Saved, congrates");
    Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 180,),

              const Icon(
                Icons.local_taxi_outlined,
                color: Colors.black,
                size: 100,
              ),

              const Text(
                "Vehicle Details",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30,),

              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle Model",
                  hintText: 'Ducati Panigale V4',
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
                controller: carNumberTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle Reg No",
                  hintText: 'KL 10 v 1000',
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
                controller: carColorTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle color",
                  hintText: 'Racing Red',
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
              DropdownButton(
                dropdownColor: Colors.white,
                hint: const Text(
                  "Choose Vehicle Type",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypesList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: const TextStyle(color: Colors.black),
                    ),
                    value: car,
                  );
                }).toList(),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () {
                  if (carColorTextEditingController.text.isNotEmpty
                      && carModelTextEditingController.text.isNotEmpty
                      && carNumberTextEditingController.text.isNotEmpty
                      && selectedCarType != null) {
                    saveCarInfo();
                  }

                  //Navigator.push(context, MaterialPageRoute(builder: (c)=> Login()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent,
                ),
                child: const Text(
                  "save",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
