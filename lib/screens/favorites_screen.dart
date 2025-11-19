import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoritados')),
      body: Center(
        child: Text('Favoritos'),
      ),




      backgroundColor: Color(0xFF0d253f),

    );
  }
}
