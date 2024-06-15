import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habbit_mobil_flutter/utils/constants/const.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: kSpacingUnit.w * 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: kSpacingUnit.w * 3),
              Stack(
                children: [
                  CircleAvatar(
                    radius: kSpacingUnit.w * 5,
                    backgroundImage: AssetImage('assets/images/IconUser.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(width: kSpacingUnit.w * 3),
            ],
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text('Usuario:', style: kCaptionTextStyle),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text('Fernando Gómez', style: kTitleTextStyle),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Color.fromRGBO(255, 191, 62, 1),
            ),
            child: Center(
              child: Text(
                'Editar perfil',
                style: kButtonTextStyle,
              ),
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 3),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 4), 
              children: <Widget>[
                _buildProfileListItem(context, text: 'Editar Preferencias'),
                _buildProfileListItem(context, text: 'Modo Oscuro'),
                _buildProfileListItem(context, text: 'Cerrar sesión'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileListItem(BuildContext context, {required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kSpacingUnit.w * 1.5), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: Theme.of(context).backgroundColor,
      ),
      child: ListTile(
        title: Text(
          text,
          style: kTitleTextStyle,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Acción al presionar el ítem
        },
      ),
    );
  }
}
