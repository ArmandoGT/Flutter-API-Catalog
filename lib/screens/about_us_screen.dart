import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sobre Nós')),
      body: Center(
        child: Text('Sobre'),
      ),




      backgroundColor: Color(0xFF0d253f),

    );
  }
}
