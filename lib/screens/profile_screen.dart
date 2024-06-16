import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/constants/const.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: kSpacingUnit.w * 7),
          _buildProfileHeader(),
          SizedBox(height: kSpacingUnit.w * 2),
          Text('Usuario:', style: kCaptionTextStyle),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text('Fernando Gómez', style: kTitleTextStyle),
          SizedBox(height: kSpacingUnit.w * 2),
          _buildEditProfileButton(),
          SizedBox(height: kSpacingUnit.w * 3),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 4),
              children: <Widget>[
                _buildProfileListItem(context,
                    text: 'Editar Preferencias', icon: Icons.settings),
                _buildProfileListItem(context,
                    text: 'Modo Oscuro', icon: Icons.dark_mode),
                _buildProfileListItem(context,
                    text: 'Cerrar sesión', icon: Icons.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }



Widget _buildProfileHeader() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: kSpacingUnit * 3),
      CircleAvatar(
        radius: kSpacingUnit * 5,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.person,
          size: kSpacingUnit * 10, 
          color: primaryColor, 
        ),
      ),
      SizedBox(width: kSpacingUnit * 3),
    ],
  );
}

  Widget _buildEditProfileButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF000000),
        backgroundColor: const Color(0xFFFFBF3E),
        elevation: 2,
        padding: EdgeInsets.symmetric(
          vertical: kSpacingUnit.w * 1.2,
          horizontal: kSpacingUnit.w * 6,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kSpacingUnit.w * 2),
            side: const BorderSide(color: Colors.transparent)),
      ),
      onPressed: () {
        // Acción al presionar el botón
      },
      child: Text(
        'Editar perfil',
        style: kButtonTextStyle.copyWith(
          fontSize: kSpacingUnit.w * 1.8, 
          fontWeight: FontWeight.w600, 
        ),
      ),
    );
  }

  Widget _buildProfileListItem(BuildContext context,
      {required String text, required IconData icon}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kSpacingUnit.w * 1.5),
      child: Material(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        child: InkWell(
          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          onTap: () {
            // Acción al presionar el elemento
          },
          child: ListTile(
            leading: Icon(icon, color: Colors.grey),
            title: Text(
              text,
              style: kTitleTextStyle,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
