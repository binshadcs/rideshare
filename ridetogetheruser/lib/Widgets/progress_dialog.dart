import 'package:flutter/material.dart';


class Progress extends StatelessWidget {

  String? message;
  Progress({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              const SizedBox(width: 10,),

              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),

              const SizedBox(width: 20,),

              Text(
                message!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

