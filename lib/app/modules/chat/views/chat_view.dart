import 'package:bapenda_getx2_admin/app/modules/chat/models/model_chat.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/nodata.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onTap: () => dismissKeyboard(),
      child: Scaffold(
        appBar: CustomAppBar(
            title: "${controller.sender_name}", leading: true, isLogin: true),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: Get.height * 0.85, // Adjust the height as needed
              child: GetBuilder<ChatController>(
                init: ChatController(),
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
                      physics: PageScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: controller.datalist.length,
                      itemBuilder: (context, index) {
                        var datatitem = controller.datalist[index];

                        if (datatitem.senderId ==
                            controller.authModel.idUserwp) {
                          return ChatFrom(data_chat: datatitem);
                        } else {
                          return ChatTo(data_chat: datatitem);
                        }
                      });
                },
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AnimatedOpacity(
          duration: Duration(microseconds: 0),
          opacity: 1,
          child: Padding(
            padding: isKeyboardOpen
                ? EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 0.0,
                    right: 0.0)
                : const EdgeInsets.only(bottom: 0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.r),
              child: SizedBox(
                child: TextFormField(
                  controller: controller.textController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.words,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    suffixIcon: SizedBox(
                      width: 0,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5, right: 4.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Image.asset("assets/images/home_icon/mic.png"),
                            Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: lightColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.send_outlined,
                                ),
                                tooltip: "Kirim Pesan",
                                onPressed: () {
                                  easyThrottle(
                                    handler: () {
                                      controller.send_Chat();
                                    },
                                  );
                                },
                              ),
                            ),
                            // Image.asset("assets/images/home_icon/send.png"),
                          ],
                        ),
                      ),
                    ),
                    prefixIcon: keyboard_chat(controller.authModel),
                    hintText: 'Tambahkan Pesan',
                    hintStyle: TextStyle(color: SecMainColor),
                    // hintStyle: NewStyles.textValueGreyR14,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SecMainColor, width: 1),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SecMainColor, width: 1),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).errorColor),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget keyboard_chat(AuthModel authModel) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: RichText(
          text: TextSpan(children: [
        WidgetSpan(
          child: SizedBox(
            height: 43.h,
            width: 43.w,
            child: Container(
              width: 40.w,
              child: Stack(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFF39D2C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0.00001, 0.00001, 0.00001, 0.00001),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'assets/icon/${authModel.foto}',
                          height: 35.h,
                          width: 35.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ])),
    );
  }
}

class ChatTo extends StatelessWidget {
  const ChatTo({
    super.key,
    required this.data_chat,
  });

  final ModelChat data_chat;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    child: Stack(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFF39D2C0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.00001, 0.00001, 0.00001, 0.00001),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                'assets/icon/${data_chat.foto}', //${data_chat['foto']}
                                height: 35.h,
                                width: 35.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 10.w, maxWidth: 300.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Texts.captionSm("${data_chat.senderName}",
                                      color: Colors.grey),
                                  Texts.subtitle2(
                                      "${timeago.format(data_chat.sentAt, locale: 'en_short')}",
                                      color: Colors.grey),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 10.w, maxWidth: 240.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 217, 233, 236),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "${data_chat.messageText}",
                                      style: TextStyle(
                                        fontSize: 13
                                            .sp, // Sesuaikan ukuran font sesuai kebutuhan
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          );
        });
  }
}

class ChatFrom extends StatelessWidget {
  const ChatFrom({
    super.key,
    required this.data_chat,
  });

  final ModelChat data_chat;

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 10.w, maxWidth: 300.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Texts.subtitle2(
                                      "${timeago.format(data_chat.sentAt, locale: 'en_short')}",
                                      color: Colors.grey),
                                  Texts.captionSm("${data_chat.senderName}",
                                      color: Colors.grey),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 10.w, maxWidth: 240.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 233, 233, 233),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "${data_chat.messageText}",
                                  style: TextStyle(
                                    fontSize: 13
                                        .sp, // Sesuaikan ukuran font sesuai kebutuhan
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40.w,
                    child: Stack(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFF39D2C0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.00001, 0.00001, 0.00001, 0.00001),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                'assets/icon/${data_chat.foto}',
                                height: 35.h,
                                width: 35.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          );
        });
  }
}
