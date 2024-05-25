import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Widgets/custome_button.dart';

import '../../Utils/colors.dart';
import '../../Widgets/custom_Container_button.dart';

class LawyerProfileScreen extends StatefulWidget {
  const LawyerProfileScreen({Key? key}) : super(key: key);

  @override
  _LawyerProfileScreenState createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
  File? _backgroundImage;
  File? _profileImage;
  static const Color teal400 = Color(0xff07BDB3);

  Future<void> _pickBackgroundImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.tealB3),
            onPressed: _pickBackgroundImage,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 130, // Adjust height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _backgroundImage != null
                        ? FileImage(_backgroundImage!)
                        : AssetImage(AppImages.image11) as ImageProvider, // Cast AssetImage to ImageProvider
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add other profile sections here
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 80, // Adjust top position of the profile image
            left: 16,
            child: GestureDetector(
              onTap: _pickProfileImage, // Open image picker on tap
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(
                  child: _profileImage != null
                      ? Image.file(
                    _profileImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    AppImages.image11, // Placeholder profile image
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 130, // Adjust top position of the contact icons
            right: 16,
            child: Row(
              children: [
                SizedBox(
                  width: 30, // Adjust the width as per your requirement
                  child: IconButton(
                    icon: Icon(Icons.phone, color: AppColors.tealB3, size: 16),
                    onPressed: () {
                      // Implement action when phone icon is pressed
                    },
                  ),
                ),
                SizedBox(
                  width: 30, // Adjust the width as per your requirement
                  child: IconButton(
                    icon: Icon(Icons.email, color: AppColors.tealB3, size: 16),
                    onPressed: () {
                      // Implement action when email icon is pressed
                    },
                  ),
                ),
                SizedBox(
                  width: 30, // Adjust the width as per your requirement
                  child: IconButton(
                    icon: Icon(Icons.facebook, color: AppColors.tealB3, size: 16),
                    onPressed: () {
                      // Implement action when Facebook icon is pressed
                    },
                  ),
                ),
                SizedBox(
                  width: 30, // Adjust the width as per your requirement
                  child: IconButton(
                    icon: Icon(Icons.share, color: AppColors.tealB3, size: 16),
                    onPressed: () {
                      // Implement action when Instagram icon is pressed
                    },
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 180, // Adjust top position of the user information
            left: 26,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maryam Jamil', // Replace with the user's name
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16), // Yellow star
                    Icon(Icons.star, color: Colors.yellow, size: 16), // Yellow star
                    Icon(Icons.star, color: Colors.yellow, size: 16), // Yellow star
                    Icon(Icons.star, color: Colors.yellow, size: 16), // Yellow star
                    Icon(Icons.star, color: Colors.grey, size: 16), // Yellow star
                    SizedBox(width: 4),
                    Text(
                      '4 (12)', // Replace with the user's rating
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '| Top Rated', // Additional information
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Attorney Defence Lawyer at High Court',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            top: 250, // Adjust top position of the user information
            left: 26,
            child: Container(
              height: MediaQuery.of(context).size.height - 360, // Set a fixed height or use constraints
              width: MediaQuery.of(context).size.width - 52, // Adjust width as needed
              child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Rawalpindi, Punjab, Pakistan', // Replace with the user's name
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1, // Adjust thickness as needed
                      height: 20, // Adjust height as needed
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'About',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: teal400), // Set the color to AppColors.tealB3
                          onPressed: handleEditButtonPressed, // Pass reference to the function
                        ),
                      ],
                    ),

                    SizedBox(height: 10), // Add some space between the text and the dummy text
                    Text(
                      'About Dummy Text Here',
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1, // Adjust thickness as needed
                      height: 20, // Adjust height as needed
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Experience',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: teal400),
                          onPressed: handleEditButtonPressed, // Pass reference to the function
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Add some space between the text and the dummy text
                    Text(
                      'Experience Dummy Text Here',
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1, // Adjust thickness as needed
                      height: 20, // Adjust height as needed
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Education',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: teal400),
                          onPressed: handleEditButtonPressed, // Pass reference to the function
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Add some space between the text and the dummy text
                    Text(
                      'Education Dummy Text Here',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 32.0),
                    CustomButtonTwo(
                      onPressed: saveData, // Call your save data function here
                      label: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Define a function to handle the onPressed event
void handleEditButtonPressed() {
  // Add your edit functionality here
}
void saveData() {
  // Implement your save data functionality here
  print('Saving data...');
}