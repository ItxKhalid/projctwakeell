import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({Key? key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _caseTypeController = TextEditingController();
  final TextEditingController _caseDetailsController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Add Client Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Client Full Name',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter client full name',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Case Type',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _caseTypeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter case type',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Case Details',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _caseDetailsController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter case details',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Contact Number',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter contact number',
                ),
              ),
              SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save logic here
                    String fullName = _fullNameController.text;
                    String caseType = _caseTypeController.text;
                    String caseDetails = _caseDetailsController.text;
                    String contactNumber = _contactNumberController.text;

                    // Print the values for demonstration
                    print('Full Name: $fullName');
                    print('Case Type: $caseType');
                    print('Case Details: $caseDetails');
                    print('Contact Number: $contactNumber');

                    // Clear the text fields after saving
                    _fullNameController.clear();
                    _caseTypeController.clear();
                    _caseDetailsController.clear();
                    _contactNumberController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tealB3,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white), // Set text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

