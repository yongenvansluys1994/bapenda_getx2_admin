import 'package:bapenda_getx2_admin/app/modules/chats/controllers/chats_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onTap: () => dismissKeyboard(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "${Get.parameters['namaTo']}",
          leading: true,
          isLogin: true,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Obx(() {
                  if (controller.documents.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * 0.35),
                          CircularProgressIndicator(),
                          SizedBox(height: 10.h),
                          Texts.caption("Sedang memuat chat, Mohon Menunggu..")
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: controller.documents.length,
                        physics: PageScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          var data_livechat = controller.documents[index];
                          //mengatasi error null timestamp saat sendchat
                          final currentTime =
                              Timestamp.fromMicrosecondsSinceEpoch(
                                  DateTime.now().millisecondsSinceEpoch);
                          Timestamp t = data_livechat['createdAt'] == null
                              ? currentTime
                              : data_livechat['createdAt'] as Timestamp;
                          late DateTime date = t.toDate();
                          // end mengatasi error null timestamp saat sendchat
                          if (data_livechat['nikFrom'] ==
                              controller.authModel.nik) {
                            return ChatFrom(
                                data_livechat: data_livechat, date: date);
                          } else {
                            return ChatTo(
                                data_livechat: data_livechat, date: date);
                          }
                        });
                  }
                }),
                SizedBox(height: 40.h),
              ],
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
                                      controller.sendChat();
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
    required this.data_livechat,
    required this.date,
  });

  final Map<String, dynamic> data_livechat;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatsController>();
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
                          'assets/icon/${data_livechat['foto']}', //${data_livechat['foto']}
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Texts.captionSm(
                                "${data_livechat['participantsInfo'][0]['participant'] == controller.authModel.nik ? data_livechat['participantsInfo'][1]['nama'] : data_livechat['participantsInfo'][0]['nama']}",
                                color: Colors.grey),
                            Texts.subtitle2("${timeago.format(date)}",
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
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.square,
                            badgeColor: Color.fromARGB(255, 217, 233, 236),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          badgeContent: Text("${data_livechat['text']}"),
                        ),
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
  }
}

class ChatFrom extends StatelessWidget {
  const ChatFrom({
    super.key,
    required this.date,
    required this.data_livechat,
  });

  final DateTime date;
  final Map<String, dynamic> data_livechat;

  @override
  Widget build(BuildContext context) {
    final ChatsController controller = Get.find();
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Texts.subtitle2("${timeago.format(date)}",
                                color: Colors.grey),
                            Texts.captionSm("${controller.authModel.nama}",
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
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.square,
                            badgeColor: Color.fromARGB(255, 233, 233, 233),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          badgeContent: Text("${data_livechat['text']}"),
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
                          'assets/icon/${controller.authModel.foto}',
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
  }
}
