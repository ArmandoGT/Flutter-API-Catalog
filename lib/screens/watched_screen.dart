import 'package:flutter/material.dart';

class WatchedScreen extends StatelessWidget {
  const WatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
        title: const Text('Assistir Depois'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors:[
                Color(0xFF01b4e4),
                Color(0xFF90cea1),
              ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,)
          ),
        ),),
      body: Center(
        child: Text('Assistir Depois'),
      ),




      backgroundColor: Color(0xFF0d253f),

    );
  }
}
