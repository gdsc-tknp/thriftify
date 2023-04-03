import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popover/popover.dart';
import 'package:supro_vigilant/ui/donation_page.dart';
import 'package:supro_vigilant/ui/recycle_page.dart';
import 'package:supro_vigilant/ui/resale_page.dart';
import 'package:supro_vigilant/ui/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? pickImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supro Vigilante'),
        automaticallyImplyLeading: false,
        actions: [
          RoundCustomBtn(
            children: [
              MItems(
                text: 'Recycle',
                onTap: () {
                  Get.back();
                  Get.to(() => const RecyclePage());
                },
                icon: FontAwesomeIcons.recycle,
              ),
              MItems(
                text: 'Donation',
                onTap: () {
                  Get.back();
                  Get.to(() => const DonationPage());
                },
                icon: FontAwesomeIcons.circleDollarToSlot,
              ),
              MItems(
                text: 'Resale',
                onTap: () {
                  Get.back();
                  Get.to(() => const ResalePage());
                },
                icon: FontAwesomeIcons.cartFlatbed,
              ),
              MItems(
                text: 'Settings',
                onTap: () {
                  Get.back();
                  Get.to(() => const SettingsPage());
                },
                icon: FontAwesomeIcons.gear,
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        children: [
          Image.asset('assets/images/logo.png'),
          Column(
            children: [
              Text(
                '{User_Name}',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.8),
              ),
              Text(
                '{User_email}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 25),
          TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.5),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              XFile? imageData = await picImage();
              if (imageData != null && imageData.path.isNotEmpty) {
                pickImage = await upload(imageData);
                setState(() {});
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(Icons.document_scanner),
                SizedBox(width: 5),
                Text('Scan to add Items'),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFC).withOpacity(.5),
              border:
                  Border.all(color: const Color(0xFFBAFAFC).withOpacity(.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 250,
            child: Column(
              children: [
                pickImage != null && pickImage!.isNotEmpty
                    ? Image.network(
                        pickImage!,
                        height: 50,
                        width: 50,
                      )
                    : const Center(child: Text('No Data'))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RoundCustomBtn extends StatelessWidget {
  final List<Widget>? children;
  final IconData? icon;

  const RoundCustomBtn({Key? key, this.icon, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
            width: 180,
            height: 260,
            context: context,
            bodyBuilder: (context) => ListItems(children: children));
      },
      splashRadius: 1,
      icon: const FaIcon(FontAwesomeIcons.ellipsis),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key, this.children}) : super(key: key);
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: children!,
      ),
    );
  }
}

class MItems extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final String? text;

  const MItems({Key? key, this.text, this.onTap, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        constraints: BoxConstraints(minHeight: height / 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [FaIcon(icon), const SizedBox(width: 5), Text(text!)],
        ),
      ),
    );
  }
}

Future<XFile?> picImage() async {
  return ImagePicker().pickImage(source: ImageSource.gallery);
}

Future<String> upload(XFile image) async {
  Reference ref = FirebaseStorage.instance.ref('images${imagePathName(image)}');
  await ref.putFile(File(image.path));
  return await ref.getDownloadURL();
}

String imagePathName(XFile image) {
  return image.path.split('/').last;
}
