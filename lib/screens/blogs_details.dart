import 'dart:ui'; // Importa esto para usar BackdropFilter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/models/blogs_main.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class BlogDetail extends StatefulWidget {
  final BlogsResponse blogsResponse;
  const BlogDetail({Key? key, required this.blogsResponse});

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _data = widget.blogsResponse;
    
    return Scaffold(
      appBar: _buildAppBar(size),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageBackground(size, _data.imageUrl),
            _buildContent(size, _data),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(Size size) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.width * 0.3),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
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
    );
  }

  Widget _buildImageBackground(Size size, String? imageUrl) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.5,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(
              '${Config.imagen}${imageUrl}', 
              width: size.width,
              height: size.height * 0.5,
              fit: BoxFit.cover,
            ),
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
    );
  }

  Widget _buildContent(Size size, BlogsResponse _data) {
    return Container(
      width: size.width,
      color: Colors.grey.shade50,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _data.title ?? 'No se encontró título',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: size.width * 0.06),
              SizedBox(width: size.width * 0.02),
              Text(
                '4.5',
                style: TextStyle(color: Colors.black, fontSize: size.width * 0.05),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            _data.description ?? 'No se encontró descripción',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.045,
            ),
          ),
        ],
      ),
    );
  }
}
