import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supro_vigilant/ui/donation_page.dart';
import 'package:supro_vigilant/ui/recycle_page.dart';
import 'package:supro_vigilant/ui/resale_page.dart';
import 'package:supro_vigilant/ui/setting_page.dart';

import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../theme/theme.dart';
import '../widgets/pop_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? pickImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logic = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supro Vigilant'),
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        children: [
          Image.asset('assets/images/logo.png', height: 160),
          Column(
            children: [
              Text(
                logic.user!.displayName!,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.8),
              ),
              Text(
                logic.user!.email!,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 25),
          CupertinoButton(
            color: Colors.teal.withOpacity(.5),
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: () {
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
                          XFile? imageData = await StorageService()
                              .picImage(ImageSource.gallery);
                          if (imageData != null && imageData.path.isNotEmpty) {
                            pickImage =
                                await StorageService().upload(imageData);
                            setState(() {});
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
                          XFile? imageData = await StorageService()
                              .picImage(ImageSource.camera);
                          if (imageData != null && imageData.path.isNotEmpty) {
                            pickImage =
                                await StorageService().upload(imageData);
                            setState(() {});
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
              color:
                  Get.theme.brightness == Brightness.dark ? d0 : Colors.white,
              border: Border.all(color: t1.withOpacity(.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 250,
            child: Column(
              children: [
                pickImage != null && pickImage!.isNotEmpty
                    ? Image.network(pickImage!, height: 50, width: 50)
                    : const Center(child: Text('No Data'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
