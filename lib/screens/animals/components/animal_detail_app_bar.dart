import 'package:flutter/material.dart';
import '../../../components/custom_app_bar.dart';

class AnimalDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String animalName;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AnimalDetailAppBar({
    super.key,
    required this.animalName,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: animalName,
      showBackButton: true,
      actions: [
        if (onEdit != null)
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: onEdit,
            tooltip: 'Editar Animal',
          ),
        if (onDelete != null)
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: onDelete,
            tooltip: 'Excluir Animal',
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
