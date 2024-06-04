import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_all.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_hiburan.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_hotel.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_katering.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_parkir.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_ppj.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_restoran.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';

import 'package:bapenda_getx2_admin/widgets/custtombottombar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';

import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2_admin/widgets/utils/helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/pendataan_controller.dart';

class PendataanView extends GetView<PendataanController> {
  const PendataanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendataanController>(
      init: PendataanController(),
      builder: (controller) {
        return DefaultTabController(
          length: 7,
          child: Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: MainColor //change your color here
                  ),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 1,
              automaticallyImplyLeading: false,
              title:
                  Texts.appBarText("Pendataan/Pelaporan WP", color: MainColor),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: ResponsiveHelper.isTablet()
                        ? null
                        : BoxDecoration(
                            color: lightColor,
                            border: Border.all(width: 2.w, color: shadowColor2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: primaryColor,
                        size: ResponsiveHelper.isTablet() ? 30 : null,
                      ),
                      tooltip: "Open notifications menu",
                      onPressed: () {
                        Get.toNamed(Routes.PENDATAAN_SEARCH,
                            arguments: controller.authModel);
                      },
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                labelColor: textLink,
                unselectedLabelColor: MainColor,
                indicatorColor: textLink,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      "SEMUA",
                      style: TextStyle(
                          fontSize: 11.sp), // Ubah ukuran font di sini
                    ),
                  ),
                  Tab(
                    child: Text(
                      "HOTEL",
                      style: TextStyle(
                          fontSize: 11.sp), // Ubah ukuran font di sini
                    ),
                  ),
                  Tab(
                    child: Text(
                      "RESTORAN",
                      style: TextStyle(
                          fontSize: 11.sp), // Ubah ukuran font di sini
                    ),
                  ),
                  Tab(
                    child: Text(
                      "KATERING",
                      style: TextStyle(
                          fontSize: 11.sp), // Ubah ukuran font di sini
                    ),
                  ),
                  Tab(
                    child: Text(
                      "HIBURAN",
                      style: TextStyle(
                          fontSize: 11.sp), // Ubah ukuran font di sini
                    ),
                  ),
                  Tab(
                    child: Text(
                      "PARKIR",
                      style: TextStyle(
                          fontSize: 11.sp), // Ubah ukuran font di sini
                    ),
                  ),
                  Tab(
                    child: Text(
                      "PPJ",
                      style: TextStyle(
                          fontSize: 11.sp), // Ubah ukuran font di sini
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              Pendataan_all(),
              Pendataan_hotel(),
              Pendataan_restoran(),
              Pendataan_katering(),
              Pendataan_hiburan(),
              Pendataan_parkir(),
              Pendataan_ppj(),
            ]),
            floatingActionButton: FloatingActionButton(
              child: Container(
                width: 60.w,
                height: 60.h,
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: gradientColor)),
              ),
              onPressed: () {},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: customButtomBar(),
          ),
        );
      },
    );
  }
}
