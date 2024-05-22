// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:thecodystoreadminpanel/controllers/MenuController.dart';
import 'package:thecodystoreadminpanel/responsive.dart';
import 'package:thecodystoreadminpanel/services/utils.dart';
import 'package:thecodystoreadminpanel/widgets/banner_widget.dart';
import 'package:thecodystoreadminpanel/widgets/header.dart';
import 'package:thecodystoreadminpanel/widgets/side_menu.dart';
import 'package:thecodystoreadminpanel/widgets/text_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  const UploadBannerScreen({super.key});

  static const String routeName = "/UploadBannerScreen";

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _image;

  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  _uploadBannersToStorage(dynamic image) async {
    Reference ref = _storage.ref().child("banners").child(fileName!);

    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFirebaseStore() async {
    EasyLoading.show();
    if (_image != null) {
      String imageUrl = await _uploadBannersToStorage(_image);

      await _firestore
          .collection("banners")
          .doc(fileName)
          .set({"image": imageUrl}).whenComplete(() {
        EasyLoading.dismiss();

        setState(() {
          _image = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<CustomMenuController>().getUploadBannersscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Header(
                      title: 'Upload Banners',
                      fct: () {
                        context
                            .read<CustomMenuController>()
                            .controlUploadBannersMenu();
                      },
                    ),
                    const SizedBox(
                      height: 10, // Add some spacing above the Divider
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Divider(
                        color: Colors.black38,
                        thickness: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 10, // Add some spacing below the Divider
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              Container(
                                height: 500,
                                width: 500,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade500,
                                    border:
                                        Border.all(color: Colors.grey.shade800),
                                    borderRadius: BorderRadius.circular(10)),
                                child: _image != null
                                    ? Image.memory(
                                        _image,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: TextWidget(
                                          text: "Banners",
                                          color: Colors.black38,
                                        ),
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  pickImage();
                                },
                                child: TextWidget(
                                    text: "Upload Banner", color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            uploadToFirebaseStore();
                          },
                          child: TextWidget(text: "Save", color: Colors.black),
                        ),
                      ],
                    ),
                     const SizedBox(
                      height: 10, // Add some spacing above the Divider
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Divider(
                        color: Colors.black38,
                        thickness: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 10, // Add some spacing below the Divider
                    ),
                    Container(
                      child: TextWidget(text: "Banners", color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: BannerWidget(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
