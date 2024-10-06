import 'package:flutter/material.dart';

class PokeFloatingButton extends StatelessWidget {
  const PokeFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){},
      backgroundColor: Colors.cyan,
      child: const Icon(Icons.favorite, color: Colors.white,),
    );
  }
}