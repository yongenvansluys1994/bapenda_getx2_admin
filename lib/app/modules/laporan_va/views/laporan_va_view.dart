import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/laporan_va_controller.dart';

class LaporanVaView extends GetView<LaporanVaController> {
  const LaporanVaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Laporan Transaksi VA", leading: true, isLogin: true),
      body: SingleChildScrollView(
        child: Center(
          child: GetBuilder<LaporanVaController>(
            init: LaporanVaController(),
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
                            Get.toNamed(Routes.LAP_DETAIL_VA,
                                parameters: {"bulan": "$monthName"});
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
