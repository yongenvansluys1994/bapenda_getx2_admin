import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerHover extends StatelessWidget {
  final bool showbadge;
  const ContainerHover({Key? key, required this.showbadge}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Ink(
      height: Get.height * 0.070,
      child: InkWell(
        splashColor: lightBlueColor,
        onTap: () {},
      ),
    );
  }
}
