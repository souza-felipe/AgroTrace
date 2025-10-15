import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

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
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        animalName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: onEdit,
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: onDelete,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
