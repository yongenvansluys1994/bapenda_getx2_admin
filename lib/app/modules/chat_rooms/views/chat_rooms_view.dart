import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../controllers/chat_rooms_controller.dart';

class ChatRoomsView extends GetView<ChatRoomsController> {
  const ChatRoomsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Chat Room", leading: true, isLogin: true),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(() {
                if (controller.room_list.isEmpty) {
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
                      itemCount: controller.room_list.length,
                      physics: PageScrollPhysics(),
                      shrinkWrap: true,
                      reverse: false,
                      itemBuilder: (context, index) {
                        var data_livechat = controller.room_list[index];
                        //mengatasi error null timestamp saat sendchat
                        bool readBy = false;
                        bool containsNoDigits(String s) {
                          return !RegExp(r'\d').hasMatch(s);
                        }

                        bool allElementsContainDigits(List<dynamic> list) {
                          return list.every((element) {
                            if (element is int) {
                              return true;
                            } else if (element is String) {
                              return !containsNoDigits(element);
                            }
                            return false;
                          });
                        }

                        if (allElementsContainDigits(data_livechat['readBy'])) {
                          readBy = false;
                        } else {
                          readBy = true;
                        }

                        final currentTime =
                            Timestamp.fromMicrosecondsSinceEpoch(
                                DateTime.now().millisecondsSinceEpoch);
                        Timestamp t = data_livechat['createdAt'] == null
                            ? currentTime
                            : data_livechat['createdAt'] as Timestamp;
                        late DateTime date = t.toDate();
                        // end mengatasi error null timestamp saat sendchat
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CHATS,
                                arguments: controller.authModel,
                                parameters: {
                                  'roomID': data_livechat['postID'],
                                  'textTo': data_livechat['nikFrom'] == 'admin'
                                      ? data_livechat['nikTo']
                                      : data_livechat['nikFrom'],
                                  'namaTo':
                                      '${data_livechat['participantsInfo'][0]['participant'] == 'admin' ? data_livechat['participantsInfo'][1]['nama'] : data_livechat['participantsInfo'][0]['nama']}',
                                  'createRoom': 'no'
                                });
                          },
                          child: ListTile(
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
                                    'assets/icon/${data_livechat['participantsInfo'][0]['participant'] == 'admin' ? data_livechat['participantsInfo'][1]['avatar'] : data_livechat['participantsInfo'][0]['avatar']}', //'assets/icon/${data_livechat['foto']}'
                                    height: 50.h,
                                    width: 50.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Texts.caption(
                                "${data_livechat['participantsInfo'][0]['participant'] == 'admin' ? data_livechat['participantsInfo'][1]['nama'] : data_livechat['participantsInfo'][0]['nama']}"),
                            subtitle: Texts.caption(
                                "${data_livechat['lastText']}..", //${data_livechat['participantsInfo'][1]['countUnseenChat']}
                                maxLines: 3,
                                color: shadowText),
                            trailing: Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.r),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Texts.captionSm("${timeago.format(date)}",
                                      color: readBy != true
                                          ? kdisetujui
                                          : Blacksoft),
                                  readBy != true
                                      ? Container(
                                          width: 18.sp,
                                          height: 18.sp,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF39D2C0),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x2B202529),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            shape: BoxShape.circle,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                        )
                                      : SizedBox(
                                          height: 2.h,
                                        )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
          controller.fetchWP();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Texts.body1("Daftar Wajib Pajak", isBold: true),
                  content: setupAlertDialoadContainer(),
                );
              });
        },
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 600.h, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 600.h,
              child: GetBuilder<ChatRoomsController>(
                init: ChatRoomsController(),
                builder: (controller) {
                  if (controller.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.datalist.length,
                      itemBuilder: (context, index) {
                        var datatitem = controller.datalist[index];

                        return Card(
                          child: InkWell(
                            onTap: () async {
                              Get.back();
                              easyThrottle(
                                handler: () async {
                                  EasyLoading.show();
                                  int roomCount = await controller.checkRoom(
                                      textTo: datatitem.nikUser);
                                  print(roomCount);
                                  if (roomCount == 0) {
                                    controller.createRoom(datatitem.nikUser);
                                    EasyLoading.dismiss();
                                  } else {
                                    String? postID = await controller
                                        .openChat(datatitem.nikUser);
                                    Get.toNamed(Routes.CHATS,
                                        arguments: controller.authModel,
                                        parameters: {
                                          'roomID': '${postID}',
                                          'textTo': '${datatitem.nikUser}',
                                          'namaTo': '${datatitem.namaUsaha}',
                                          'createRoom': 'no'
                                        });
                                    EasyLoading.dismiss();
                                  }
                                },
                              );
                            },
                            child: ListTile(
                              dense: true,
                              title: Texts.captionSm('${datatitem.namaUsaha}'),
                              subtitle: Texts.captionSm(
                                  "Jenis Pajak : ${datatitem.jenispajak}",
                                  color: shadowText),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
