import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/colors.dart';

import '../Views/ClientDashboardScreen/Components/client_profile_screen.dart';
import '../service/Userclass.dart';

class CustomAppBarClient extends StatelessWidget implements PreferredSizeWidget {

  final String name;
  final String imageassets;
  final VoidCallback onPhonePressed;

  const CustomAppBarClient({
    Key? key,
    required this.name,
    required this.imageassets,
    required this.onPhonePressed, required String subtitle,
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
              MaterialPageRoute(builder: (context) => ClientProfileScreen()), // Navigate to the profile page
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
