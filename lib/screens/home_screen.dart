import 'package:catalogmovie/screens/search_history_screen.dart';
import 'package:catalogmovie/screens/watched_screen.dart';
import 'package:flutter/material.dart';
import 'package:catalogmovie/widgets/menu_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Image.asset('images/logo.png', height: 100,),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF01b4e4),
                      Color(0xFF90cea1),
                    ],
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Procure por seu filme/série',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                )
              ),
              SizedBox(height: 15,),
              MenuButton(
                icon: Icons.history,
                text: "Histórico de Pesquisa",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchHistoryScreen()),
                  );
                },
              ),
              SizedBox(height: 5,),
              MenuButton(icon: Icons.watch_later, text: "Assistir depois", onPressed:  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WatchedScreen()),
                );
              },),
              SizedBox(height: 5,),
              MenuButton(icon: Icons., text: text, onPressed: onPressed)
            ],
          ),
        ),
      ),

      backgroundColor: Color(0xFF0d253f),
    );
  }
}
