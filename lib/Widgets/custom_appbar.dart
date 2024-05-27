import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/colors.dart';

import '../Views/LawyerProfileScreen/Lawyer_profile_page.dart'; // Import your profile page

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? name;
  final String? imageassets;
  final VoidCallback? onPhonePressed;

  const CustomAppBar({
    Key? key,
     this.name,
     this.imageassets,
     this.onPhonePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0), // Add a bottom border
        ),
      ),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LawyerProfileScreen()), // Navigate to the profile page
            );
          },
          child: Row(
            children: [
              imageassets == null ? const SizedBox.shrink() : CircleAvatar(
                backgroundImage: AssetImage(imageassets!), // Replace with your circular image URL
              ),
              const SizedBox(width: 8.0),
              Text(name!),
            ],
          ),
        ),
        actions: [
          onPhonePressed == null ? const SizedBox.shrink() : IconButton(
            icon: Icon(Icons.phone, color: AppColors.tealB3),
            onPressed: onPhonePressed,
          ),
        ],
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
