import 'package:get/get.dart';

import '../controllers/chat_rooms_controller.dart';

class ChatRoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomsController>(
      () => ChatRoomsController(),
    );
  }
}
