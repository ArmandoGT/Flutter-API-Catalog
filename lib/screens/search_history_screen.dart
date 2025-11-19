import 'package:flutter/material.dart';

class SearchHistoryScreen extends StatelessWidget {
  const SearchHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico de Pesquisa')),
      body: Center(
        child: Text('Conteúdo do histórico aqui'),
      ),




      backgroundColor: Color(0xFF0d253f),

    );
  }
}
