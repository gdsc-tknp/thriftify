import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../theme/theme.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  late final TextEditingController? titleControl,
      descriptionControl,
      amount,
      dateControl;
  final ImagePicker _picker = ImagePicker();
  final FocusNode title = FocusNode();
  final FocusNode description = FocusNode();
  final FocusNode date = FocusNode();
  final formKey = GlobalKey<FormState>();
  File? _image;
  late String url;
  var uuid = 'Uuid';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Upload Data')),
      child: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          children: [
            Image.asset('assets/images/logo.png', height: 160),
            CupertinoTextField(controller: titleControl, placeholder: 'Title'),
            CupertinoTextField(
              controller: amount,
              placeholder: 'Amount',
              keyboardType: TextInputType.number,
            ),
            CupertinoTextField(
              controller: descriptionControl,
              placeholder: 'Description',
              maxLines: 4,
            ),
            CupertinoTextField(
              suffix: const FaIcon(CupertinoIcons.calendar),
              keyboardType: TextInputType.datetime,
              controller: dateControl,
              placeholder: 'Date',
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: Get.theme.brightness == Brightness.dark
                          ? d0
                          : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            Get.back();
                            await Permission.photos.request();
                            var status = await Permission.photos.status;
                            if (status.isGranted) {
                              _getImage(ImageSource.gallery);
                            } else {
                              Get.snackbar(
                                  'Error.', 'Grant permission to continue');
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Gallery'),
                              FaIcon(FontAwesomeIcons.rectangleList),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            Get.back();
                            await Permission.camera.request();
                            var status = await Permission.camera.status;
                            if (status.isGranted) {
                              _getImage(ImageSource.camera);
                            } else {
                              Get.snackbar(
                                  'Error.', 'Grant permission to continue');
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Camera'),
                              FaIcon(FontAwesomeIcons.camera),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const FaIcon(
                        CupertinoIcons.photo_on_rectangle,
                        size: 80.0,
                        color: CupertinoColors.systemGrey,
                      ),
              ),
            ),
            const SizedBox(height: 25),
            CupertinoButton(
              onPressed: () {
                _uploadData();
              },
              color: r6,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(FontAwesomeIcons.solidFloppyDisk),
                  SizedBox(width: 10),
                  Text('Save Data', style: TextStyle(fontFamily: 'Poppins')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _getImage(ImageSource src) async {
    final pickedFile = await _picker.pickImage(source: src);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Get.snackbar('No image selected.', 'Please select image');
      }
    });
  }

  Future<void> _uploadData() async {
    final logic = context.watch<AuthService>();
    final valid = formKey.currentState!.validate();
    final uid = logic.user!.uid;
    if (valid) {
      formKey.currentState!.save();
      if (_image == null) {
        Get.snackbar('Error', 'Please select an image.');
        return;
      }
      final imageUrl =
          await StorageService.uploadImage(_image!, titleControl!.text);
      await StorageService.saveData(
        descriptionControl!.text,
        imageUrl,
        double.parse(amount!.text),
        titleControl!.text,
        dateControl!.text, // Timestamp.now()
        uid,
      );

      titleControl!.clear();
      amount!.clear();
      descriptionControl!.clear();
      dateControl!.clear();
      setState(() {
        _image = null;
      });
      Get.snackbar('Success', 'Your Data uploaded successfully.');
    }
  }
}
