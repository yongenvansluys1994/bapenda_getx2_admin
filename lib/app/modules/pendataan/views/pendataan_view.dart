import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_all.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_hiburan.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_hotel.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_katering.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_parkir.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_ppj.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/views/tab_pendataan/pendataan_restoran.dart';

import 'package:bapenda_getx2_admin/widgets/custtombottombar.dart';

import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
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
              elevation: 1,
              automaticallyImplyLeading: false,
              title: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/appbar-bapenda.png",
                    height: 68,
                  ),
                ],
              ),
              bottom: TabBar(
                labelColor: textLink,
                unselectedLabelColor: MainColor,
                indicatorColor: textLink,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "SEMUA",
                  ),
                  Tab(
                    text: "HOTEL",
                  ),
                  Tab(
                    text: "RESTORAN",
                  ),
                  Tab(
                    text: "KATERING",
                  ),
                  Tab(
                    text: "HIBURAN",
                  ),
                  Tab(
                    text: "PARKIR",
                  ),
                  Tab(
                    text: "PPJ",
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