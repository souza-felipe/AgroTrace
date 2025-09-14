import 'package:flutter/material.dart';

class AnimalSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const AnimalSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Digite o nome ou parte do animal!',
          hintStyle: TextStyle(color: Color.fromARGB(153, 0, 0, 0), fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Color.fromARGB(153, 0, 0, 0), size: 20),
          suffixIcon: Icon(Icons.filter_list, color: Color.fromARGB(153, 0, 0, 0), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
