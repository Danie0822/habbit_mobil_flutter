import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/buildFilter.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_search.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 16),
            child: TextFieldSearch(),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, right: 24, left: 24, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Stack(
                      children: [
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            buildFilter('Inmuebles', true, Icons.home),
                            buildFilter('Proyectos', false, Icons.work),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 28,
                            decoration: BoxDecoration(
                             gradient: LinearGradient(
                              begin: Alignment.centerRight, 
                              end: Alignment.centerLeft, 
                              stops: const [0.0, 1.0],
                              colors: [
                                Theme.of(context).scaffoldBackgroundColor,
                                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0)
                              ]
                             )
                            ),
                            
                          ),
                        )
                      ],
                    ),
                   
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 16, right: 24),
                    child: Text(
                      'Filtros',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.only( right: 24, left: 24, bottom: 12),
            child: Row(
              children: [
                
              ],
            ),
          )  
        ],
      ),
    );
  }
}
