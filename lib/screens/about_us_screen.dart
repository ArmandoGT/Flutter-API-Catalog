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
            // Texto
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

            const SizedBox(height: 25),

            // --- SEÇÃO INSTITUIÇÃO & TECNOLOGIA---
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

            const SizedBox(height: 25),

            // --- SEÇÃO DESENVOLVEDOR ---
            const Text(
              "Desenvolvedor",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Logo GT
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('images/ByGT.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Git-Linkedin
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContactRow(Icons.code, "github.com/ArmandoGT"),
                        const SizedBox(height: 8),
                        _buildContactRow(Icons.link, "linkedin.com/in/armandogt"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget-auxiliar logos simples
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

  // Widget-auxiliar para o Git-Linkedin
  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF01b4e4), size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
