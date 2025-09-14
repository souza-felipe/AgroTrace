import 'package:flutter/material.dart';

class EmptyAnimalsWidget extends StatelessWidget {
  const EmptyAnimalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 64, color: Color.fromARGB(128, 0, 0, 0)),
          const SizedBox(height: 16),
          Text(
            'Nenhum animal encontrado',
            style: TextStyle(color: Color.fromARGB(179, 0, 0, 0), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
