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
      body: SingleChildScrollView(
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

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CHAT,
                            arguments: controller.authModel,
                            parameters: {
                              'room_id': '${dataitem.roomId}',
                              'id_sender': '${dataitem.idSender}',
                              'nik_sender': '${dataitem.nikSender}',
                              'sender_name': '${dataitem.senderName}'
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
                            "${dataitem.lastMessageText}..", //${data_livechat['participantsInfo'][1]['countUnseenChat']}
                            maxLines: 3,
                            color: shadowText),
                        trailing: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Texts.captionSm(
                                  "${timeago.format(dataitem.sentAt)}",
                                  color: dataitem.hasUnread == 'TRUE'
                                      ? kdisetujui
                                      : Blacksoft),
                              dataitem.hasUnread == 'TRUE'
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
            },
          ),
        ),
      ),
    );
  }
}