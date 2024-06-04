import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/images.dart';

class AddEventDialog extends StatefulWidget {
  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

  List<UserModel> clients = [];
  String? _selectedClient;
  UserModel? selectedClientData;

  @override
  void initState() {
    super.initState();
    fetchClientData();
  }

  Future<void> fetchClientData() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('client').get();
      List<UserModel> clientList = querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      setState(() {
        clients = clientList;
      });
    } catch (e) {
      print("Error fetching client data: $e");
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addEvent),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.title),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: startDateController,
              readOnly: true,
              onTap: () async {
                await _selectDate(context, startDateController);
              },
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.startDate),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: endDateController,
              readOnly: true,
              onTap: () async {
                await _selectDate(context, endDateController);
              },
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.endDate),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedClient,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedClient = newValue;
                  if (_selectedClient != null) {
                    selectedClientData = clients.firstWhere(
                          (client) =>
                      '${client.firstName} ${client.lastName}' ==
                          _selectedClient,
                    );
                    if (selectedClientData != null) {
                      _fullNameController.text =
                      '${selectedClientData!.firstName} ${selectedClientData!.lastName}';
                    }
                  }
                });
              },
              items: clients.map((client) {
                return DropdownMenuItem<String>(
                  value: '${client.firstName} ${client.lastName}',
                  child: Text('${client.firstName} ${client.lastName}'),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: AppLocalizations.of(context)!.selectClient,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                // Handle save logic here
                String fullName = _fullNameController.text;
                String startDate = startDateController.text;
                String endDate = endDateController.text;

                if (fullName.isNotEmpty &&
                    startDate.isNotEmpty &&
                    endDate.isNotEmpty &&
                    titleController.text.trim().isNotEmpty &&
                    _selectedClient != null) {
                  try {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(child: AppConst.spinKitWave());
                      },
                      barrierDismissible: false,
                    );
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    Map<String, dynamic> clientData = {
                      'clientName': fullName,
                      'startDate': startDate,
                      'endDate': endDate,
                      'title': titleController.text.trim(),
                      'lawyerId': uid,
                      'userId': selectedClientData!.userId,
                    };
                    await FirebaseFirestore.instance
                        .collection('appointments')
                        .add(clientData)
                        .then((value) {
                      Navigator.pop(context);
                      setState(() {});
                    });
                    Navigator.pop(context);
                    Get.snackbar(AppLocalizations.of(context)!.successfully, AppLocalizations.of(context)!.appointmentAdded,
                        backgroundColor: AppColors.blue,
                        colorText: AppColors.white,
                        borderRadius: 20.r,
                        icon: Icon(
                          Icons.check,
                          color: AppColors.white,
                        ),
                        snackPosition: SnackPosition.TOP);
                    _selectedClient = null;
                  } catch (e) {
                    Navigator.pop(context);
                    Get.snackbar(AppLocalizations.of(context)!.error, '${AppLocalizations.of(context)!.failedToAddAppointment}: $e',
                        backgroundColor: AppColors.red,
                        colorText: AppColors.white,
                        borderRadius: 20.r,
                        icon: Icon(
                          Icons.error_outline,
                          color: AppColors.white,
                        ),
                        snackPosition: SnackPosition.TOP);
                  }
                } else {
                  if (titleController.text.trim().isEmpty) {
                    Get.snackbar(AppLocalizations.of(context)!.error, 'Title Required!',
                        backgroundColor: AppColors.red,
                        colorText: AppColors.white,
                        borderRadius: 20.r,
                        icon: Icon(
                          Icons.error_outline,
                          color: AppColors.white,
                        ),
                        snackPosition: SnackPosition.TOP);
                  } else if (fullName.isEmpty) {
                    Get.snackbar(AppLocalizations.of(context)!.error, AppLocalizations.of(context)!.fullNameRequired,
                        backgroundColor: AppColors.red,
                        colorText: AppColors.white,
                        borderRadius: 20.r,
                        icon: Icon(
                          Icons.error_outline,
                          color: AppColors.white,
                        ),
                        snackPosition: SnackPosition.TOP);
                  } else if (startDate.isEmpty) {
                    Get.snackbar(AppLocalizations.of(context)!.error, AppLocalizations.of(context)!.pleaseSelectStartDate,
                        backgroundColor: AppColors.red,
                        colorText: AppColors.white,
                        borderRadius: 20.r,
                        icon: Icon(
                          Icons.error_outline,
                          color: AppColors.white,
                        ),
                        snackPosition: SnackPosition.TOP);
                  } else if (endDate.isEmpty) {
                    Get.snackbar(AppLocalizations.of(context)!.error, AppLocalizations.of(context)!.pleaseSelectEndDate,
                        backgroundColor: AppColors.red,
                        colorText: AppColors.white,
                        borderRadius: 20.r,
                        icon: Icon(
                          Icons.error_outline,
                          color: AppColors.white,
                        ),
                        snackPosition: SnackPosition.TOP);
                  } else if (_selectedClient == null) {
                    Get.snackbar(AppLocalizations.of(context)!.error, AppLocalizations.of(context)!.pleaseSelectClient,
                        backgroundColor: AppColors.red,
                        colorText: AppColors.white,
                        borderRadius: 20.r,
                        icon: Icon(
                          Icons.error_outline,
                          color: AppColors.white,
                        ),
                        snackPosition: SnackPosition.TOP);
                  }
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

// Dummy UserModel class for demonstration
class UserModel {
  String? firstName;
  String? lastName;
  String? userId;

  UserModel({this.firstName, this.lastName, this.userId});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      firstName: data['firstName'],
      lastName: data['lastName'],
      userId: data['userId'],
    );
  }
}
