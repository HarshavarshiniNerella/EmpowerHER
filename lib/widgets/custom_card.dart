import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  
  const CustomCard({
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: padding ?? EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.burgundy.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
