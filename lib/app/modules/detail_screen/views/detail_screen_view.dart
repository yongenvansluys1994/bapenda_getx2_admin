import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/detail_screen_controller.dart';

class DetailScreenView extends GetView<DetailScreenController> {
  const DetailScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: "Detail Screen", leading: true, isLogin: true),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: GestureDetector(
            child: GetBuilder<DetailScreenController>(
              init: DetailScreenController(),
              builder: (controller) {
                return Center(
                    child: Container(
                        child: PhotoView(
                  imageProvider:
                      NetworkImage("${URL_APP}/upload/${controller.url_image}"),
                )));
              },
            ),
            onTap: () {
              //Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
