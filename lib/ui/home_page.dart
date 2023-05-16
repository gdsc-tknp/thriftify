import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supro_vigilant/ui/donation_page.dart';
import 'package:supro_vigilant/ui/recycle_page.dart';
import 'package:supro_vigilant/ui/resale_page.dart';
import 'package:supro_vigilant/ui/setting_page.dart';
import 'package:supro_vigilant/widgets/upload_widget.dart';

import '../services/auth_service.dart';
import '../theme/theme.dart';
import '../widgets/pop_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logic = context.watch<AuthService>();
    final user = logic.user!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: const Text('Thriftify'),
        trailing: RoundCustomBtn(
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
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: 160),
                Column(
                  children: [
                    Text(
                      user.displayName!,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.8),
                    ),
                    Text(
                      user.email!,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
          SliverFillRemaining(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              children: [
                CupertinoButton(
                  color: r6,
                  borderRadius: BorderRadius.circular(8),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    Get.to(
                      () => const UploadPage(),
                      transition: Transition.cupertino,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(Icons.document_scanner),
                      SizedBox(width: 5),
                      Text('Add Items'),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // StreamBuilder<DocumentSnapshot>(
                //     stream: StorageService.getDataStream(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         final datas = snapshot.data;
                //         return ListView.builder(
                //           itemCount: datas?.id.length,
                //           itemBuilder: (context, index) {
                //             final data = datas![index];
                //             return ListTile(
                //               title: Text(data['productTitle']),
                //               subtitle: Text("Amount+ ${data['amount']}"),
                //               trailing: Text(data['title']),
                //               onTap: () {
                //                 Get.bottomSheet(
                //                   SizedBox(
                //                     height: 130,
                //                     child: Text(data['description']),
                //                   ),
                //                 );
                //               },
                //             );
                //           },
                //         );
                //       }
                //       if (snapshot.hasError) {
                //         return Center(child: Text('Error: ${snapshot.error}'));
                //       }
                //       return Container(
                //         decoration: BoxDecoration(
                //           color: Get.theme.brightness == Brightness.dark
                //               ? d0
                //               : Colors.white,
                //           border: Border.all(color: t1.withOpacity(.5)),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         height: 250,
                //         child: const Center(child: Text('No Data')),
                //       );
                //     })
              ],
            ),
          )
        ],
      ),
    );
  }
}
