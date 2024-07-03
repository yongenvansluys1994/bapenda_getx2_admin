import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/controllers/pendaftaran_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_hiburan.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_hotel.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_katering.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_parkir.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_restoran.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/utils/helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class customButtomBar extends StatelessWidget {
  const customButtomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: ResponsiveHelper.isTablet() ? Get.height * 0.065 : 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: ResponsiveHelper.isTablet() ? Get.width * 0.20 : Get.width * 0.20,
                  onPressed: () {
                    Get.currentRoute == Routes.DASHBOARD
                        ? null
                        : Get.toNamed(Routes.DASHBOARD);
                    Get.delete<PendaftaranController>();
                    Get.delete<PendataanController>();
                    Get.delete<PendataanController_hiburan>();
                    Get.delete<PendataanController_hotel>();
                    Get.delete<PendataanController_katering>();
                    Get.delete<PendataanController_parkir>();
                    Get.delete<PendataanController_restoran>();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ResponsiveHelper.isTablet()
                          ? Icon(
                              Icons.dashboard,
                              size: Get.width * 0.05,
                              color: Get.currentRoute == Routes.DASHBOARD
                                  ? Colors.blue
                                  : Colors.grey,
                            )
                          : Icon(
                              Icons.dashboard,
                              color: Get.currentRoute == Routes.DASHBOARD
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                      Text(
                        'Beranda',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.isTablet() ? 11.sp : null,
                          color: Get.currentRoute == Routes.DASHBOARD
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: ResponsiveHelper.isTablet() ? Get.width * 0.20 : Get.width * 0.20,
                  onPressed: () {
                    Get.currentRoute == Routes.PENDAFTARAN
                        ? null
                        : Get.toNamed(Routes.PENDAFTARAN,
                            arguments: controller.authModel);
                    controller.stopProcess();
                    Get.delete<PendataanController>();
                    Get.delete<PendataanController_hiburan>();
                    Get.delete<PendataanController_hotel>();
                    Get.delete<PendataanController_katering>();
                    Get.delete<PendataanController_parkir>();
                    Get.delete<PendataanController_restoran>();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      badges.Badge(
                        showBadge: controller.value_admindaftar.value == "0"
                            ? false
                            : true,
                        position:
                            badges.BadgePosition.topEnd(top: -13, end: -10),
                        badgeContent: Text(
                          '${controller.value_admindaftar}',
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                        badgeAnimation: badges.BadgeAnimation.rotation(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Color.fromARGB(255, 226, 55, 55),
                          padding: EdgeInsets.all(6),
                          elevation: 0,
                        ),
                        child: ResponsiveHelper.isTablet()
                            ? Icon(Icons.quick_contacts_mail_rounded,
                                size: Get.width * 0.05,
                                color: Get.currentRoute == Routes.PENDAFTARAN
                                    ? Colors.blue
                                    : Colors.grey)
                            : Icon(Icons.quick_contacts_mail_rounded,
                                color: Get.currentRoute == Routes.PENDAFTARAN
                                    ? Colors.blue
                                    : Colors.grey),
                      ),
                      Text(
                        "Pendaftaran",
                        style: TextStyle(
                            fontSize:
                                ResponsiveHelper.isTablet() ? 11.sp : null,
                            color: Get.currentRoute == Routes.PENDAFTARAN
                                ? Colors.blue
                                : Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: ResponsiveHelper.isTablet() ? Get.width * 0.20 : Get.width * 0.20,
                  onPressed: () {
                    Get.currentRoute == Routes.PENDATAAN
                        ? null
                        : Get.toNamed(Routes.PENDATAAN,
                            arguments: controller.authModel);
                    Get.delete<PendaftaranController>();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      badges.Badge(
                        showBadge: controller.value_adminpelaporan.value == 0
                            ? false
                            : true,
                        position:
                            badges.BadgePosition.topEnd(top: -13, end: -10),
                        badgeContent: Text(
                          '${controller.value_adminpelaporan}',
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                        badgeAnimation: badges.BadgeAnimation.rotation(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Color.fromARGB(255, 226, 55, 55),
                          padding: EdgeInsets.all(6),
                          elevation: 0,
                        ),
                        child: ResponsiveHelper.isTablet()
                            ? Icon(
                                Icons.my_library_books_outlined,
                                size: Get.width * 0.05,
                                color: Get.currentRoute == Routes.PENDATAAN
                                    ? Colors.blue
                                    : Colors.grey,
                              )
                            : Icon(
                                Icons.my_library_books_outlined,
                                color: Get.currentRoute == Routes.PENDATAAN
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                      ),
                      Text(
                        'Pendataan',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.isTablet() ? 11.sp : null,
                          color: Get.currentRoute == Routes.PENDATAAN
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: ResponsiveHelper.isTablet() ? Get.width * 0.20 : Get.width * 0.20,
                  onPressed: () {
                    Get.currentRoute == Routes.CHAT_ROOM
                        ? null
                        : Get.toNamed(Routes.CHAT_ROOM,
                            arguments: controller.authModel);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      badges.Badge(
                        showBadge: controller.unread_chat_count != "0" ? true : false,
                        position:
                            badges.BadgePosition.topEnd(top: -13, end: -10),
                        badgeContent: Text(
                          '${controller.unread_chat_count}',
                          style: TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                        badgeAnimation: badges.BadgeAnimation.rotation(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Color.fromARGB(255, 226, 55, 55),
                          padding: EdgeInsets.all(6),
                          elevation: 0,
                        ),
                        child: ResponsiveHelper.isTablet()
                            ? Icon(
                                Icons.feed_outlined,
                                size: Get.width * 0.05,
                                color: Get.currentRoute == Routes.CHAT_ROOM
                                    ? Colors.blue
                                    : Colors.grey,
                              )
                            : Icon(
                                Icons.feed_outlined,
                                color: Get.currentRoute == Routes.CHAT_ROOM
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.isTablet() ? 11.sp : null,
                          color: Get.currentRoute == Routes.CHAT_ROOM
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
