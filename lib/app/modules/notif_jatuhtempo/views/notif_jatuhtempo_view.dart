import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/notif_jatuhtempo_controller.dart';

class NotifJatuhtempoView extends GetView<NotifJatuhtempoController> {
  const NotifJatuhtempoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notifikasi Jatuh Tempo",
        leading: true,
        isLogin: true,
      ),
      body: GetBuilder<NotifJatuhtempoController>(
        init: NotifJatuhtempoController(),
        builder: (controller) {
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
                                              '${dataitem.name}',
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
                                              'Telah terkirim Notifikasi Peringatan Jatuh Tempo kepada WP\nJatuh Tempo : ${DateFormat('dd-MM-yyyy').format(dataitem.jatuhTempo)}',
                                              style: TextStyle(fontSize: 11.sp),
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
                                        '${DateFormat('dd-MM-yyyy HH:mm:ss').format(dataitem.dateKirim)}',
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
