import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/laporan_qris_controller.dart';

class LaporanQrisView extends GetView<LaporanQrisController> {
  const LaporanQrisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Laporan Transaksi QRIS", leading: true, isLogin: true),
      body: SingleChildScrollView(
        child: Center(
          child: GetBuilder<LaporanQrisController>(
            init: LaporanQrisController(),
            builder: (controller) {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.months.length,
                  itemBuilder: (context, index) {
                    var monthName = controller.months[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        color: primaryColor,
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(Routes.LAP_DETAIL_QRIS,
                                parameters: {"bulan": "$monthName"});
                            // getDefaultDialog().onFix(
                            //     title:
                            //         "Riwayat Transaksi QRIS hanya bisa melalui Aplikasi DG QRIS Bankaltimtara",
                            //     desc:
                            //         "Data ini adalah data Integrasi Realtime dari Bankaltimtara dengan Bapenda Etam",
                            //     kategori: "error");
                          },
                          leading: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: appBarColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.calendar,
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
                          title: Texts.caption(
                            '${monthName}',
                            color: primaryColor,
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
