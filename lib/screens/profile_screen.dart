import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/constants/const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final Size screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.04;
    final double avatarRadius = screenSize.width * 0.1;
    final double fontSize = screenSize.width * 0.04;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: screenSize.width * 0.12),
            _buildProfileHeader(avatarRadius),
            SizedBox(height: screenSize.width * 0.02),
            Center(
              child: Text('Usuario:',
                  style: kCaptionTextStyle.copyWith(fontSize: fontSize)),
            ),
            SizedBox(height: screenSize.width * 0.005),
            Center(
              child: Text('Fernando Gómez',
                  style: kTitleTextStyle.copyWith(fontSize: fontSize * 1.2)),
            ),
            SizedBox(height: screenSize.width * 0.02),
            Center(
              child: _buildEditProfileButton(fontSize),
            ),
            _buildProfileList(fontSize),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(double avatarRadius) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.person,
            size: avatarRadius * 2,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfileButton(double fontSize) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF000000),
        backgroundColor: const Color(0xFFFFBF3E),
        splashFactory: NoSplash.splashFactory,
        elevation: 2,
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: fontSize * 2.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
      onPressed: () {
        context.push('/registar');
      },
      child: Text(
        'Editar perfil',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProfileList(double fontSize) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _buildProfileListItem(context,
            text: 'Ajustes',
            icon: Icons.settings,
            fontSize: fontSize,
            ruta: 'darkMode'),
        _buildProfileListItem(context,
            text: 'Editar preferencias',
            icon: Icons.widgets,
            fontSize: fontSize,
            ruta: '/editPreferences'),
        _buildProfileListItem(context,
            text: 'Cerrar sesión',
            icon: Icons.logout,
            fontSize: fontSize,
            ruta: '/login'),
      ],
    );
  }

  Widget _buildProfileListItem(BuildContext context,
      {required String text,
      required IconData icon,
      required double fontSize,
      required String ruta}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(24.0),
        child: GestureDetector(
          onTap: () {
            context.push(ruta);
          },
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            leading: Icon(icon, color: Colors.grey, size: fontSize * 1.5),
            title: Text(
              text,
              style: TextStyle(fontSize: fontSize),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
