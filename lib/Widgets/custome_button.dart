import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/colors.dart';

class CustomButtonTwo extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CustomButtonTwo({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tealB3,
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
