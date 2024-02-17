import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/myprofil_controller.dart';

class MyprofilView extends GetView<MyprofilController> {
  const MyprofilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profil",
        leading: false,
        isLogin: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 8),
                    child: Texts.body1("Pengaturan profil")),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0x4C4B39EF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFF4B39EF),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/icon-user.png',
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Texts.caption(
                              '${controller.authModel.nama}',
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Texts.caption(
                                '${controller.authModel.noHp}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider(
                //   thickness: 1,
                //   color: Color(0xFFE0E3E7),
                // ),
                Card(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: InkWell(
                      child: ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Color(0xFF14181B),
                                  size: 20,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Texts.body2("Profil Saya")),
                            ],
                          ),
                          dense: true,
                          visualDensity: VisualDensity(vertical: 1),
                          trailing: Icon(Icons.arrow_forward_ios)),
                      onTap: () {},
                    )),
                Card(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: InkWell(
                      child: ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Icon(
                                  Icons.storefront_sharp,
                                  color: Color(0xFF14181B),
                                  size: 20,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Texts.body2("Promosi & Iklan")),
                            ],
                          ),
                          dense: true,
                          visualDensity: VisualDensity(vertical: 1),
                          trailing: Icon(Icons.arrow_forward_ios)),
                      onTap: () {},
                    )),
                Card(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: InkWell(
                      child: ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Icon(
                                  Icons.storefront_sharp,
                                  color: Color(0xFF14181B),
                                  size: 20,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Texts.body2("Data Lainnya")),
                            ],
                          ),
                          dense: true,
                          visualDensity: VisualDensity(vertical: 1),
                          trailing: Icon(Icons.arrow_forward_ios)),
                      onTap: () {},
                    )),
                // Divider(
                //   thickness: 1,
                //   color: Color(0xFFE0E3E7),
                // ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 220.w,
                                child: Texts.caption(
                                    "Permintaan Penghapusan Account",
                                    maxLines: 2))
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // Warna latar belakang tombol
                          onPrimary: Colors.white, // Warna teks tombol
                        ),
                        onPressed: () async {
                          await controller.FetchlaunchUrl();
                        },
                        child: Text('Ajukan', style: TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFE0E3E7),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Icon(
                              Icons.login_rounded,
                              color: Color(0xFF14181B),
                              size: 20,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.dashboardController.logout();
                            },
                            child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Texts.caption("Logout")),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Get.offAndToNamed(Routes.DASHBOARD);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: Get.currentRoute == Routes.DASHBOARD
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        Text(
                          'Beranda',
                          style: TextStyle(
                            color: Get.currentRoute == Routes.DASHBOARD
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.quick_contacts_mail_rounded,
                            color: Get.currentRoute == Routes.DASHBOARD
                                ? Colors.blue
                                : Colors.grey),
                        Text(
                          "Kartu NPWPD",
                          style: TextStyle(
                              color: Get.currentRoute == Routes.DASHBOARD
                                  ? Colors.blue
                                  : Colors.grey,
                              fontSize: 11.sp),
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
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: Get.currentRoute == Routes.DASHBOARD
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                            color: Get.currentRoute == Routes.DASHBOARD
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Get.offAndToNamed(Routes.DASHBOARD,
                          arguments: controller.authModel);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: Get.currentRoute == Routes.DASHBOARD
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        Text(
                          'Objek-Ku',
                          style: TextStyle(
                            color: Get.currentRoute == Routes.DASHBOARD
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
