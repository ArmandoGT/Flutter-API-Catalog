import 'package:flutter/material.dart';

// BOTÃO "ASSISTIR DEPOIS"
class WatchLaterButton extends StatefulWidget {
  const WatchLaterButton({super.key});
  @override
  State<WatchLaterButton> createState() => _WatchLaterButtonState();
}

class _WatchLaterButtonState extends State<WatchLaterButton> {
  bool added = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() => added = !added);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                added
                    ? 'Adicionado à lista Assistir Depois'
                    : 'Removido de Assistir Depois'
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: Icon(
        added ? Icons.pending_rounded : Icons.pending_outlined,
        color: Colors.white,
      ),
      label: const Text('Pendente', style: TextStyle(fontSize: 13),),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF01b4e4),
        foregroundColor: Colors.white,
      ),
    );
  }
}

// BOTÃO "JÁ ASSISTIDO"
class WatchedButton extends StatefulWidget {
  const WatchedButton({super.key});
  @override
  State<WatchedButton> createState() => _WatchedButtonState();
}

class _WatchedButtonState extends State<WatchedButton> {
  bool marked = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() => marked = !marked);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                marked
                    ? 'Marcado como já assistido'
                    : 'Desmarcado como assistido'
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: Icon(
        marked ? Icons.visibility : Icons.visibility_outlined,
        color: Colors.white,
      ),
      label: const Text('Assistido', style: TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF90cea1),
        foregroundColor: Colors.white,
      ),
    );
  }
}

// BOTÃO "FAVORITAR"
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() => favorite = !favorite);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                favorite ? 'Adicionado aos favoritos' : 'Removido dos favoritos'
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: Icon(
        favorite ? Icons.star : Icons.star_border,
        color: Colors.white,
      ),
      label: const Text('Favoritar', style: TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
    );
  }
}
