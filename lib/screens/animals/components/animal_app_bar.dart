import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../stores/animal_store.dart';
import '../../../components/custom_app_bar.dart';

class AnimalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onFilterTap;
  
  const AnimalAppBar({super.key, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'Animais',
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.white),
          onPressed: onFilterTap,
          tooltip: 'Filtrar Animais',
        ),
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
          tooltip: 'Atualizar Lista',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
