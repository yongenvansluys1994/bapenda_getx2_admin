import 'package:bapenda_getx2_admin/widgets/utils/helper/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';

import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class MainDrawer extends StatelessWidget {
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('asdasdas'),
                    accountEmail: Text('asd'),
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                  ListTile(
                    title: Text('Home'),
                    tileColor: Get.currentRoute == Routes.DASHBOARD
                        ? Colors.grey[300]
                        : null,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

buildDrawer() {
  DashboardController controller = Get.find();
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120.h,
              width: Get.width.w,
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                color: appBarColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        border: Border.all(color: shadowColor, width: 2),
                      ),
                      child: ClipRRect(
                          child: Image.asset(
                        "assets/icon/${controller.authModel.foto}",
                        height: ResponsiveHelper.isTablet() ? 25.h : 40.h,
                        width: ResponsiveHelper.isTablet() ? 25.h : 40.w,
                        fit: BoxFit.cover,
                      )),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ResponsiveHelper.isTablet()
                              ? Texts.captionXs(
                                  '${controller.authModel.nama}',
                                  textAlign: TextAlign.left,
                                )
                              : Texts.body2(
                                  '${controller.authModel.nama}',
                                  textAlign: TextAlign.left,
                                ),
                          ResponsiveHelper.isTablet()
                              ? Texts.captionXs(
                                  '${controller.authModel.nik}',
                                  textAlign: TextAlign.left,
                                )
                              : Texts.caption(
                                  '${controller.authModel.nik}',
                                  textAlign: TextAlign.left,
                                  color: shadowColor,
                                )
                        ],
                      ),
                    ),
                    ResponsiveHelper.isTablet()
                        ? InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 20.sp,
                              height: 20.sp,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x2B202529),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Icon(
                                Icons.close,
                                color: MainColor,
                                size: 15.sp,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 30.sp,
                              height: 30.sp,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x2B202529),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Icon(
                                Icons.close,
                                color: MainColor,
                                size: 22.sp,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5.sp),
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //     ),
            //     color: primaryColor,
            //     child: ListTile(
            //       onTap: () {},
            //       leading: Container(
            //         height: 30.h,
            //         width: 30.w,
            //         decoration: BoxDecoration(
            //           color: appBarColor,
            //           borderRadius: BorderRadius.circular(8.r),
            //         ),
            //         child: Center(
            //           child: FaIcon(
            //             FontAwesomeIcons.user,
            //             color: primaryColor,
            //             size: 15,
            //           ),
            //         ),
            //       ),
            //       trailing: const FaIcon(
            //         FontAwesomeIcons.chevronRight,
            //         color: primaryColor,
            //         size: 15,
            //       ),
            //       title: Texts.caption(
            //         'Profil',
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5.sp),
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //     ),
            //     color: primaryColor,
            //     child: ListTile(
            //       onTap: () {},
            //       leading: Container(
            //         height: 30.h,
            //         width: 30.w,
            //         decoration: BoxDecoration(
            //           color: appBarColor,
            //           borderRadius: BorderRadius.circular(8.r),
            //         ),
            //         child: Center(
            //           child: FaIcon(
            //             FontAwesomeIcons.shop,
            //             color: primaryColor,
            //             size: 15,
            //           ),
            //         ),
            //       ),
            //       trailing: const FaIcon(
            //         FontAwesomeIcons.chevronRight,
            //         color: primaryColor,
            //         size: 15,
            //       ),
            //       title: Texts.caption(
            //         'Promosi & Iklan',
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5.sp),
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //     ),
            //     color: primaryColor,
            //     child: ListTile(
            //       onTap: () {
            //         Get.toNamed(Routes.PPID, arguments: controller.authModel);
            //       },
            //       leading: Container(
            //         height: 30.h,
            //         width: 30.w,
            //         decoration: BoxDecoration(
            //           color: appBarColor,
            //           borderRadius: BorderRadius.circular(8.r),
            //         ),
            //         child: Center(
            //           child: FaIcon(
            //             FontAwesomeIcons.newspaper,
            //             color: primaryColor,
            //             size: 15,
            //           ),
            //         ),
            //       ),
            //       trailing: const FaIcon(
            //         FontAwesomeIcons.chevronRight,
            //         color: primaryColor,
            //         size: 15,
            //       ),
            //       title: Texts.caption(
            //         'PPID',
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: primaryColor,
                child: ListTile(
                  onTap: () {
                    Get.toNamed(Routes.PUSH_NOTIFICATION,
                        arguments: controller.authModel);
                  },
                  leading: Container(
                    height: ResponsiveHelper.isTablet() ? 15.h : 30.h,
                    width: ResponsiveHelper.isTablet() ? 15.w : 30.w,
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(
                          ResponsiveHelper.isTablet() ? 2.r : 8.r),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.message,
                        color: primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: primaryColor,
                    size: 15,
                  ),
                  title: ResponsiveHelper.isTablet()
                      ? Texts.captionXs(
                          'Pesan Broadcast',
                          color: primaryColor,
                        )
                      : Texts.caption(
                          'Pesan Broadcast',
                          color: primaryColor,
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: primaryColor,
                child: Stack(
                  children: [
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.NOTIF_JATUHTEMPO,
                            arguments: controller.authModel);
                      },
                      leading: Container(
                        height: ResponsiveHelper.isTablet() ? 15.h : 30.h,
                        width: ResponsiveHelper.isTablet() ? 15.w : 30.w,
                        decoration: BoxDecoration(
                          color: appBarColor,
                          borderRadius: BorderRadius.circular(
                              ResponsiveHelper.isTablet() ? 2.r : 8.r),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.facebookMessenger,
                            color: primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: primaryColor,
                        size: 15,
                      ),
                      title: ResponsiveHelper.isTablet()
                          ? Texts.captionXs('Notif Jatuh Tempo',
                              color: primaryColor, maxLines: 2)
                          : Texts.caption(
                              'Notif Jatuh Tempo',
                              color: primaryColor,
                            ),
                    ),
                    Positioned(
                      right: 8.r,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.square,
                            badgeColor: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        badgeContent: Text(' Baru ',
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.5.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: primaryColor,
                child: ListTile(
                  onTap: () {
                    Get.toNamed(Routes.AKTIVITAS,
                        arguments: controller.authModel);
                  },
                  leading: Container(
                    height: ResponsiveHelper.isTablet() ? 15.h : 30.h,
                    width: ResponsiveHelper.isTablet() ? 15.w : 30.w,
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(
                          ResponsiveHelper.isTablet() ? 2.r : 8.r),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.comments,
                        color: primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: primaryColor,
                    size: 15,
                  ),
                  title: ResponsiveHelper.isTablet()
                      ? Texts.captionXs(
                          'Aktivitas',
                          color: primaryColor,
                        )
                      : Texts.caption(
                          'Aktivitas',
                          color: primaryColor,
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Stack(
                  children: [
                    ExpansionTile(
                      leading: Container(
                        height: ResponsiveHelper.isTablet() ? 15.h : 30.h,
                        width: ResponsiveHelper.isTablet() ? 15.w : 30.w,
                        decoration: BoxDecoration(
                          color: appBarColor,
                          borderRadius: BorderRadius.circular(
                              ResponsiveHelper.isTablet() ? 2.r : 8.r),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.file,
                            color: primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronDown,
                        color: primaryColor,
                        size: 15,
                      ),
                      title: ResponsiveHelper.isTablet()
                          ? Texts.captionXs(
                              'Laporan',
                              color: primaryColor,
                            )
                          : Texts.caption(
                              'Laporan',
                              color: primaryColor,
                            ),
                      children: <Widget>[
                        ListTile(
                          title: ResponsiveHelper.isTablet()
                              ? Texts.captionXs(
                                  'Lap. Transaksi VA',
                                  color: primaryColor,
                                )
                              : Texts.caption(
                                  'Lap. Transaksi VA',
                                  color: primaryColor,
                                ),
                          onTap: () {
                            Get.toNamed(Routes.LAPORAN_VA,
                                arguments: controller.authModel);
                          },
                        ),
                        Divider(height: 0.0),
                        ListTile(
                          title: ResponsiveHelper.isTablet()
                              ? Texts.captionXs(
                                  'Lap. Transaksi QRIS',
                                  color: primaryColor,
                                )
                              : Texts.caption(
                                  'Lap. Transaksi QRIS',
                                  color: primaryColor,
                                ),
                          onTap: () {
                            Get.toNamed(Routes.LAP_DETAIL_QRIS);
                            // getDefaultDialog().onFix(
                            //     title: "Mohon Maaf",
                            //     desc:
                            //         "Riwayat Transaksi QRIS hanya bisa melalui Aplikasi DG QRIS Bankaltimtara",
                            //     kategori: "error");
                          },
                        ),
                        Divider(height: 0.0),
                        Stack(
                          children: [
                            ListTile(
                              title: ResponsiveHelper.isTablet()
                                  ? Texts.captionXs(
                                      'Lap. Realisasi 1',
                                      color: primaryColor,
                                    )
                                  : Texts.caption(
                                      'Lap. Realisasi 1',
                                      color: primaryColor,
                                    ),
                              onTap: () {
                                Get.toNamed(Routes.LAPORAN_1,
                                    arguments: controller.authModel);
                              },
                            ),
                             
                          ],
                        ),
                        Divider(height: 0.0),
                        Stack(
                          children: [
                            ListTile(
                              title: ResponsiveHelper.isTablet()
                                  ? Texts.captionXs(
                                      'Lap. Realisasi 2',
                                      color: primaryColor,
                                    )
                                  : Texts.caption(
                                      'Lap. Realisasi 2',
                                      color: primaryColor,
                                    ),
                              onTap: () {
                                Get.toNamed(Routes.LAPORAN_2,
                                    arguments: controller.authModel);
                              },
                            ),
                             
                          ],
                        ),
                        Divider(height: 0.0),
                        Stack(
                          children: [
                            ListTile(
                              title: ResponsiveHelper.isTablet()
                                  ? Texts.captionXs(
                                      'Lap. WP Termuktahir',
                                      color: primaryColor,
                                    )
                                  : Texts.caption(
                                      'Lap. WP Termuktahir',
                                      color: primaryColor,
                                    ),
                              onTap: () {
                                Get.toNamed(Routes.LAPORAN_DAFTARUSER,
                                    arguments: controller.authModel);
                              },
                            ),
                             
                          ],
                        ),
                        Divider(height: 0.0),
                        Stack(
                          children: [
                            ListTile(
                              title: ResponsiveHelper.isTablet()
                                  ? Texts.captionXs(
                                      'Lap. WP Blm Muktahir',
                                      color: primaryColor,
                                    )
                                  : Texts.caption(
                                      'Lap. WP Blm Muktahir',
                                      color: primaryColor,
                                    ),
                              onTap: () {
                                Get.toNamed(Routes.LAPORAN_DAFTARUSER_OLD,
                                    arguments: controller.authModel);
                              },
                            ),
                             
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 8.r,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.square,
                            badgeColor: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        badgeContent: Text(' Baru ',
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.5.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.sp),
              child: const Divider(),
            ),
            Padding(
              padding: EdgeInsets.all(5.sp),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  leading: Container(
                    height: ResponsiveHelper.isTablet() ? 15.h : 30.h,
                    width: ResponsiveHelper.isTablet() ? 15.w : 30.w,
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(
                          ResponsiveHelper.isTablet() ? 2.r : 8.r),
                    ),
                    child: Center(
                      child: Transform.scale(
                        scaleX: -1,
                        child: const Icon(
                          FontAwesomeIcons.rightFromBracket,
                          color: primaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: primaryColor,
                    size: 15,
                  ),
                  title: ResponsiveHelper.isTablet()
                      ? Texts.captionXs(
                          "Log Out",
                          color: primaryColor,
                        )
                      : Texts.caption(
                          "Log Out",
                          color: primaryColor,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
