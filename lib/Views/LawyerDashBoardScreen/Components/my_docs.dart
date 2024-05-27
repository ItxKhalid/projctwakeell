import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_filex/open_filex.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Widgets/custom_appbar.dart';

class MyDocument extends StatefulWidget {
  const MyDocument({super.key});

  @override
  State<MyDocument> createState() => _MyDocumentState();
}

class _MyDocumentState extends State<MyDocument> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<PlatformFile> _files = [];

  List<PlatformFile> get files => _files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(name: 'My Documents'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await pickDocument(context);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('myDocs')
            .where('userId', isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppConst.spinKitWave();
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading documents'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No documents found'));
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
              List mediaFiles = data['mediaFiles'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mediaFiles.map<Widget>((fileData) {
                  return ListTile(
                    leading: _getIconForFileType(fileData['type']),
                    title: Text(fileData['name']),
                    subtitle: Text(fileData['type']),
                    onTap: () => _openFile(fileData['url'], fileData['type']),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Icon _getIconForFileType(String fileType) {
    switch (fileType) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf);
      case 'doc':
      case 'docx':
        return const Icon(Icons.description);
      default:
        return const Icon(Icons.insert_drive_file);
    }
  }

  Future<void> pickDocument(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      setState(() {
        _files.addAll(result.files);
      });
      await myDocs(context); // Start upload after picking files
    }
  }

  Future<void> myDocs(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AppConst.spinKitWave();
      },
      barrierDismissible: false,
    );

    try {
      // Get the current user
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw 'No user is currently signed in';
      }

      String userId = currentUser.uid;
      List<Map<String, String>> mediaFiles = await uploadMediaFiles();

      // Prepare the data to be saved in Firestore
      Map<String, dynamic> documentData = {
        'userId': userId,
        'mediaFiles': mediaFiles,
      };

      // Save the document data to Firestore
      DocumentReference docRef = await _firestore.collection('myDocs').add(documentData);
      String documentId = docRef.id;

      // Optionally, update the document with the ID if you want to keep a reference within the document itself
      await docRef.update({'id': documentId});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Documents Uploaded.'),
      ));
      setState(() {
        _files.clear();
      });
    } catch (error) {
      print('Error uploading documents: $error');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to upload documents. Please try again later.'),
      ));
    } finally {
      Navigator.pop(context); // Close the loading dialog
    }
  }

  Future<List<Map<String, String>>> uploadMediaFiles() async {
    if (_files.isEmpty) return [];

    List<Map<String, String>> mediaFiles = [];
    for (PlatformFile file in _files) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('leaveRequests/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(file.path!));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      String fileType = file.extension == 'pdf' || file.extension == 'doc' || file.extension == 'docx' ? 'document' : 'file';
      mediaFiles.add({
        'url': downloadUrl,
        'type': fileType,
        'name': file.name,
      });
    }

    return mediaFiles;
  }

  Future<void> _openFile(String url, String type) async {
    if (type == 'pdf') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewPage(url: url),
        ),
      );
    } else {
      await OpenFilex.open(url);
    }
  }
}

class PDFViewPage extends StatelessWidget {
  final String url;

  const PDFViewPage({required this.url, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: PDFView(
        filePath: url,
      ),
    );
  }
}
