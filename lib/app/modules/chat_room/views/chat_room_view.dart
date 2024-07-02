import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/nodata.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Ruang Chat", leading: true, isLogin: true),
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg-parkirapp.jpg'), // Path to your image asset
            opacity: 0.4,
            fit: BoxFit.cover, // Adjust this based on your requirements
          ),
        ),
        child: SingleChildScrollView(
          reverse: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<ChatRoomController>(
              init: ChatRoomController(),
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
                    reverse: false,
                    itemCount: controller.datalist.length,
                    itemBuilder: (context, index) {
                      var dataitem = controller.datalist[index];

                      return Card(
                        child: Ink(
                          height: Get.height * 0.090,
                          child: InkWell(
                            splashColor: lightBlueColor,
                            child: ListTile(
                              tileColor: (index % 2 == 0)
                                  ? Colors.blueGrey[50]
                                  : Colors.grey[100],
                              leading: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: kdisetujui,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0.1.r),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.asset(
                                      'assets/icon/${dataitem.isGroup == 'false' ? dataitem.foto : 'group.png'}',
                                      height: 50.h,
                                      width: 50.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              title: Texts.caption(
                                  "${dataitem.isGroup == 'false' ? dataitem.senderName : dataitem.roomName}"),
                              subtitle: Texts.caption(
                                  "${dataitem.lastMessageText}..",
                                  maxLines: 1,
                                  color: shadowText),
                              trailing: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.r),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Texts.captionSm(
                                        "${timeago.format(dataitem.sentAt)}",
                                        color: dataitem.hasUnread == 'TRUE'
                                            ? kdisetujui
                                            : Blacksoft),
                                    dataitem.hasUnread == 'TRUE'
                                        ? SizedBox(
                                            width: Get.width * 0.19,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                dataitem.type == null
                                                    ? SizedBox()
                                                    : Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 63, 248, 63),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          "${dataitem.type}",
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(width: 4),
                                                Container(
                                                  width: 18.sp,
                                                  height: 18.sp,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF39D2C0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0x2B202529),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(
                                            width: Get.width * 0.19,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                dataitem.type == null
                                                    ? SizedBox()
                                                    : Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 63, 248, 63),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          "${dataitem.type}",
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(width: 4),
                                                Container(
                                                  width: 18.sp,
                                                  height: 18.sp,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                ),
                                              ],
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(Routes.CHAT,
                                  arguments: controller.authModel,
                                  parameters: {
                                    'room_id': '${dataitem.roomId}',
                                    'target_id': '${dataitem.idSender}',
                                    'target_nik': '${dataitem.nikSender}',
                                    'sender_name':
                                        '${dataitem.isGroup == 'true' ? dataitem.roomName : dataitem.senderName}',
                                  });
                            },
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ),
      ),
      floatingActionButton: GetBuilder<ChatRoomController>(
        builder: (controller) {
          return Visibility(
            visible: controller.actionbutton,
            child: FloatingActionButton(
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
              onPressed: () {
                controller.changeActionbutton();
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
