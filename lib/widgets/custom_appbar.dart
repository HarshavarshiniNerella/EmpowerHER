import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  
  const CustomAppBar({
    required this.title,
    this.actions,
    this.showBackButton = true,
  });
  
  @override
  Size get preferredSize => Size.fromHeight(60);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.burgundy,
      elevation: 4,
      automaticallyImplyLeading: showBackButton,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      actions: actions,
    );
  }
}
