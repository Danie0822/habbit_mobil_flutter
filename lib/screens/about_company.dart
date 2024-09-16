import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/header_about.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class AboutCompany extends StatelessWidget {
  const AboutCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const HeaderObout(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(context, 'Conoce a Habit Inmobiliaria'),
                  const SizedBox(height: 16.0),
                  _buildTagline(context),
                  const SizedBox(height: 24.0),
                  _buildInfoSection(context),
                  const SizedBox(height: 24.0),
                  _buildMissionSection(context),
                  const SizedBox(height: 24.0),
                  _buildValuesSection(context),
                  const SizedBox(height: 24.0),
                  _buildVisionSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
      ),
    );
  }

  Widget _buildTagline(BuildContext context) {
    return Center(
      child: Text(
        'Líderes en soluciones inmobiliarias',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLocationInfo(context, 'Habit', 'assets/images/logo_amarillo.png'),
        _buildIconInfo(context, Icons.star, 'Excelencia'),
      ],
    );
  }

  Widget _buildLocationInfo(BuildContext context, String title, String imagePath) {
    return Row(
      children: [
        Container(
          height: 36.0,
          width: 36.0,
          margin: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildIconInfo(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Container(
          height: 36.0,
          width: 36.0,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildMissionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Nuestra Misión'),
        const SizedBox(height: 8.0),
        Text(
          'Proporcionar soluciones inmobiliarias integrales que satisfagan las necesidades de nuestros clientes mediante la venta y alquiler de propiedades, departamentos, terrenos y casas, con un compromiso inquebrantable con la calidad y el servicio personalizado.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildValuesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Nuestros Valores'),
        const SizedBox(height: 8.0),
        _buildValueItem(context, 'Amor y bondad'),
        _buildValueItem(context, 'Educación integral'),
        _buildValueItem(context, 'Optimismo y alegría'),
        _buildValueItem(context, 'Familia y comunidad'),
      ],
    );
  }

  Widget _buildVisionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Nuestra Visión'),
        const SizedBox(height: 8.0),
        Text(
          'Ser la empresa líder en el sector inmobiliario, reconocida por nuestra innovación, profesionalismo y excelencia en la gestión de propiedades, contribuyendo al desarrollo y crecimiento de nuestras comunidades.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
        ),
        const SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset('assets/images/house_01.jpg'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildValueItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            height: 24.0,
            width: 24.0,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color:  Color(0xFFE3FFF8),
            ),
            child: const Icon(
              Icons.check,
              color: primaryColor,
              size: 20.0,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
