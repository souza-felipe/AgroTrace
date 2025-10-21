import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final VoidCallback? onProfileTap; 
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.onProfileTap, 
    this.showBackButton = false,
    this.onBack,
    this.onBackTap,
    this.actions, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withAlpha(51),
            blurRadius: 12, 
            offset: const Offset(0, 4), 
          ),
        ],
      ),
      child: Container(
        height: 56 + MediaQuery.of(context).padding.top,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Row(
          children: [
            if (showBackButton)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onBack ?? onBackTap ?? () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(51, 255, 255, 255),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),

            Expanded(
              child: Center(
                child: Text(
                  title.toUpperCase(),
                  style: titleStyle ?? const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700, 
                    letterSpacing: 0.5, 
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            if (actions != null)
              ...actions!
            else if (onProfileTap != null)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onProfileTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(51, 255, 255, 255),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}