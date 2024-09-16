import 'dart:ui'; // Importa esto para usar BackdropFilter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class blogDetal extends StatefulWidget {
  const blogDetal({Key? key});

  @override
  State<blogDetal> createState() => _blogDetailMain();
}

class _blogDetailMain extends State<blogDetal> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  final List<dynamic> _movies = [
    {
      'title': 'Spider-Man',
      'image':
          'https://gpvivienda.com/blog/wp-content/uploads/2023/03/ralph-ravi-kayden-mR1CIDduGLc-unsplash-1-1.jpg',
      'description': 'Spider-Man'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size.width * 0.3), // Radio de esquina responsivo
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    context.go('/main', extra: 2);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen de fondo con gradiente en la parte inferior
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.5,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return FittedBox(
                        fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el contenedor
                        child: SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: Image.network(
                            _movies[_current]['image'],
                            fit: BoxFit.cover, // Asegura que la imagen cubra todo el contenedor
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.grey.shade50.withOpacity(0.1),
                        Colors.grey.shade50.withOpacity(0.3),
                        Colors.grey.shade50.withOpacity(0.5),
                        Colors.grey.shade50.withOpacity(0.7),
                        Colors.grey.shade50.withOpacity(1.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Gradiente o Espaciado si es necesario
            Container(
              width: size.width,
              color: Colors.grey.shade50,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _movies[_current]['title'],
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: size.width * 0.06),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        '4.5',
                        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: size.width * 0.05),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    'Lorem Lorem ipsum dolor sit amet, consectetuajdsifooijdiojajidafsiojfdjioasiojdfsaojidfsjoidaiodsjfioadsjoipadiosjjiodfsaijodfsaijadfsiojdfsjiodfsaiojpdosfjiaojidfsdjiosfafdsojifdasojhpfjio0ioasj0fsijodfsjioaijofdsaijodafsijjdifsaijdofasijodfasijodfasiojdifosjaoijdfasojidfsoijfdsjioadfjoiasijofdasijodfasjiodfasijofdasijoidfosjiofdijofdiojjfidoasjiodfgadsfhuiiadhsfihofdahoiiuhofdashuifdahuifahduioshuiuiashdaushiuihdsuhir adipiscing hadiufhiuahdfiuhadiosfhiouahdsfouihasdoihfoiuadshfoiuhadsoifhodiashfoiuadhsfouiha. Praesent vel diam ac nisl condimentum auctora',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: size.width * 0.045,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
