import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColorAzul, // Fondo azul oscuro
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visita en casa de Apopa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFF8585), // Color del estado "Cancelada"
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Cancelada',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.arrow_right_circle_fill,
                color: Colors.blue, // Color del ícono de flecha
                size: 28.0,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Colors.white,
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                '10 de agosto 9 a.m.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
