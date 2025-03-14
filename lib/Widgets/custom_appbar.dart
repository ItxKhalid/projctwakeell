import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/colors.dart';

import '../Views/LawyerProfileScreen/Lawyer_profile_page.dart'; // Import your profile page

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String imageassets;
  final VoidCallback onPhonePressed;

  const CustomAppBar({
    Key? key,
    required this.name,
    required this.imageassets,
    required this.onPhonePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0), // Add a bottom border
        ),
      ),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LawyerProfileScreen()), // Navigate to the profile page
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imageassets), // Replace with your circular image URL
              ),
              SizedBox(width: 8.0),
              Text(name),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: AppColors.tealB3),
            onPressed: onPhonePressed,
          ),
        ],
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
