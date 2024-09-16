import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/header_about.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

// acerca de 
class AboutCompany extends StatelessWidget {
  const AboutCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // esto tiende toda la informacion del acerca de 
    return Scaffold(
      // diseño de dicho widget 
      body: CustomScrollView(
        slivers: <Widget>[
          const HeaderObout(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instituto Técnico Ricaldone',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: primaryColor),
                    child: Row(
                      children: [
                        const Text('ITR'),
                        const SizedBox(width: 8.0),
                        Container(
                          height: 5.0,
                          width: 5.0,
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Text('Familia'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 32.0,
                            width: 32.0,
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/house_01.jpg'),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Don Bosco',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 32.0,
                            width: 32.0,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Salesianos',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(color: primaryColor, height: 1.0),
                  const SizedBox(height: 16.0),
                  Text(
                    'Nuestra Misión',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Somos una comunidad de salesianos consagrados y laicos comprometidos que se dedican a educar y evangelizar a niños, adolescentes y jóvenes. Nuestra principal preocupación es brindar una educación que prepare a los menos favorecidos para integrarse con éxito en la sociedad y en el ámbito laboral, siguiendo el ejemplo educativo de Don Bosco.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(color: primaryColor, height: 1.0),
                  const SizedBox(height: 16.0),
                  Text(
                    'Valores',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16.0),
                  _buildIngredientItem(context, 'Amor y bondad'),
                  _buildIngredientItem(context, 'Educación integral'),
                  _buildIngredientItem(context, 'Optimismo y alegría'),
                  _buildIngredientItem(context, 'Familia y comunidad'),
                  const Divider(color: primaryColor, height: 1.0),
                  const SizedBox(height: 16.0),
                  Text(
                    'Nuestra Visión',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Para el año 2022, en Centroamérica, seremos reconocidos por nuestra visión evangélica y compromiso con las comunidades consagradas. Nuestras obras estarán centradas en atender las necesidades de niños, adolescentes y jóvenes, mediante programas de prevención, educación y evangelización. ',
                              style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: primaryColor),
                            ),
                            const SizedBox(height: 16.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'assets/images/house_01.jpg',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientItem(
    BuildContext context,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            height: 24.0,
            width: 24.0,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE3FFF8),
            ),
            child: Icon(
              Icons.check,
              color: primaryColor,
              size: 18.0,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
