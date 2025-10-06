import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../stores/animal_store.dart';

class AnimalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnimalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'ANIMAIS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () async {
            try {
              final store = await AnimalStore.getInstance();
              await store.loadAnimals();
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erro ao atualizar: $e'),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            }
          },
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Color.fromARGB(51, 255, 255, 255),
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
