import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Alessandro Morales',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Hola, como estas?',
                  style: TextStyle(
                    color: Colors.black
                  ),),
                ),
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Bien, como estas?',
                    style: TextStyle(
                      color: Colors.black
                    ),),
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
