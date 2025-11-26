import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d253f),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: const Text('Sobre Nós'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF01b4e4),
                Color(0xFF90cea1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Textos
            const Text(
              "Good morning, good afternoon, and good evening!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF01b4e4),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Permita-me apresentar, Armando me chamo, sou estudante do IFRO do curso de Análise e Desenvolvimento de Sistemas.\n\n"
                  "Esse aplicativo é uma solução acadêmica desenvolvida para a disciplina de Programação Mobile I.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Usando a API REST da The Movie Database (TMDB), com as vantagens dela ser pública, gratuita e ainda conter pôsteres de filmes.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Instituição & Tecnologia",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 80,
              child: Row(
                children: [
                  // Logo IFRO (PNG)
                  _buildLogoContainer(
                    child: Image.asset(
                      'images/IFLogo.png',
                      fit: BoxFit.contain,
                    ),
                    label: "IFRO",
                  ),

                  const SizedBox(width: 15),

                  // Logo TMDB (SVG)
                  _buildLogoContainer(
                    child: SvgPicture.asset(
                      'images/TMDB.svg',
                      fit: BoxFit.contain,
                    ),
                    label: "TMDB",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoContainer({required Widget child, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: child,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
