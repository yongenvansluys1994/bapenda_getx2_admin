import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/nodata.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/aktivitas_controller.dart';

class AktivitasView extends GetView<AktivitasController> {
  const AktivitasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Aktivitas", leading: true, isLogin: true),
      body: GetBuilder<AktivitasController>(
        init: AktivitasController(Get.find<Api>()),
        builder: (controller) {
          if (controller.isEmpty) {
            return NoData(); //menampilkan lotties no data
          }

          if (controller.isLoading) {
            return ShimmerWidget.Items1();
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.r),
            child: ListView.builder(
                itemCount: controller.datalist.length + 1,
                controller: controller.controllerScroll,
                itemBuilder: (context, index) {
                  if (index < controller.datalist.length) {
                    var dataitem = controller.datalist[index];
                    return // Generated code for this userActivity_3 Widget...
                        Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE0E3E7),
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Wrap(
                                        spacing: 0,
                                        runSpacing: 4,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 4, 0),
                                            child: Text(
                                              '${dataitem.nama}',
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 4, 0),
                                            child: Text(
                                              '${dataitem.kegiatan}',
                                              style: TextStyle(fontSize: 13.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 32,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F4F8),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Text(
                                        '${DateFormat('dd-MM-yyyy HH:mm:ss').format(dataitem.date)}',
                                        style: TextStyle(fontSize: 11.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                }),
          );
        },
      ),
    );
  }
}
