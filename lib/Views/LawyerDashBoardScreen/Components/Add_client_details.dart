import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import '../../../service/Userclass.dart';
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
  List<UserModel> clients = [];
  @override
  void initState() {
    super.initState();
    fetchClientData().then((clientData) {
      setState(() {
        clients = clientData;
      });
    });
  }
  String? _selectedClient;
  UserModel? selectedClientData;
  Future<List<UserModel>> fetchClientData() async {
    List<UserModel> clients = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('client').get();
      clients = querySnapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching client data: $e");
    }
    return clients;
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Add Client Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Client Full Name',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                value: _selectedClient,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedClient = newValue;
                    if (_selectedClient != null) {
                      // Find the selected client from the list
                      selectedClientData = clients.firstWhere(
                            (client) => '${client.firstName} ${client.lastName}' == _selectedClient,

                      );
                      // If a matching client is found, set the contact number
                      if (selectedClientData != null) {
                        _contactNumberController.text = selectedClientData!.phoneNumber ?? '';
                        _fullNameController.text=selectedClientData!.firstName!+" "+selectedClientData!.firstName!;
                      } else {
                        _contactNumberController.text = ''; // No client selected, clear the text field
                      }
                    } else {
                      _contactNumberController.text = ''; // No client selected, clear the text field
                    }
                  });
                },
                items: clients.map((client) {
                  return DropdownMenuItem<String>(
                    value: '${client.firstName} ${client.lastName}',
                    child: Text('${client.firstName} ${client.lastName}'),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select client',
                ),
              ),

              const SizedBox(height: 16.0),
              const Text(
                'Case Type',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _caseTypeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter case type',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Case Details',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _caseDetailsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter case details',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Contact Number',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter contact number',
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async {
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
                    if (fullName.isNotEmpty && caseType.isNotEmpty && caseDetails.isNotEmpty && contactNumber.isNotEmpty)
                    {
                      /// save client data
                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      String? email = FirebaseAuth.instance.currentUser!.email;

                      // Construct a map for the client data
                      Map<String, dynamic> clientData = {
                        'ClientfullName': fullName,
                        'ClientcaseType': caseType,
                        'ClientcaseDetails': caseDetails,
                        'ClientcontactNumber': contactNumber,
                        'lawerUID': uid,
                        'lawerEmail': email,
                      };
                      await FirebaseFirestore.instance.collection('ClientsData').add(clientData).then((value) =>
                      {
                        Get.back(),
                        Get.snackbar('Successfully', 'Client Add',
                            backgroundColor: AppColors.blue,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP),
                        _selectedClient=null,
                        setState(() {

                        }),
                        _fullNameController.clear(),
                        _caseTypeController.clear(),
                        _caseDetailsController.clear(),
                        _contactNumberController.clear(),
                      });





                      /*try {
                          DocumentReference docRef = await FirebaseFirestore.instance.collection('client').add({
                            'firstName': firstName,
                            'lastName': lastName,
                            'email': email,
                            'cnic': cnic,
                            'phoneNumber': phoneNumber,
                            'gender': gender,
                          });

                          // Show success snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registration successful! ID: ${docRef.id}'),
                            ),
                          );

                          // Clear text controllers
                          firstnameController.clear();
                          lastnameController.clear();
                          emailController.clear();
                          cnicController.clear();
                          fullPhoneNumber = '';
                          setState(() {
                            selectedGender = '';
                          });


                        } catch (e) {
                          // Show error snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to register your account: $e'),
                            ),
                          );
                        }*/
                    }
                    else
                    {
                      if (fullName.isEmpty) {
                        Get.snackbar('Error', 'Full Name Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                      }

                      else if (caseType.isEmpty) {
                        Get.snackbar('Error', 'Please Write case type',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);

                      }
                      else if (caseDetails.isEmpty) {
                        Get.snackbar('Error', 'Case Detail Required!',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                      }
                      else if(contactNumber.isEmpty){
                        Get.snackbar('Error', 'Mobile Number Required!',
                            colorText: AppColors.white,
                            backgroundColor: Colors.red,
                            borderRadius: 20.r,
                            icon: Icon(Icons.error_outline, color: AppColors.white,),
                            snackPosition: SnackPosition.TOP);
                      }
                    }


                    // Clear the text fields after saving

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tealB3,
                  ),
                  child: const Text(
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
