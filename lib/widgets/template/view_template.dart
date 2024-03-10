import 'package:bapenda_getx2_admin/app/modules/pendaftaran/controllers/pendaftaran_controller.dart';

import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/nodata.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LaporPajakView extends GetView<PendaftaranController> {
  const LaporPajakView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Pelaporan Pajak",
        leading: true,
        isLogin: true,
      ),
      body: GetBuilder<PendaftaranController>(
        init: PendaftaranController(),
        builder: (controller) {
          if (controller.isFailed) {
            return ShimmerWidget.Items1();
          }

          if (controller.isEmpty) {
            return NoData(); //menampilkan lotties no data
          }

          if (controller.isLoading) {
            return ShimmerWidget.Items1();
          }
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.datalist.length,
              itemBuilder: (context, index) {
                var datatitem = controller.datalist[index];

                return Text("${datatitem.namaUsaha}");
              });
        },
      ),
    );
  }
}
