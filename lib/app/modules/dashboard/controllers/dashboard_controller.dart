import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/jatuhtempo_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/grafik1.dart';
import 'dart:ui' as ui;
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2_admin/utils/app_const.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController with AuthCacheService {
  http.Client httpClient = http.Client();
  late AuthModel authModel;
  RxInt countUnseenChat = 0.obs;
  late String tokenMsg;
  int tot_pelaporan = 0;
  RxString value_admindaftar = "0".obs;
  RxInt value_adminpelaporan = 0.obs;
  Set<Marker> markers = <Marker>{};
  bool readBy = false;
  int wp_daftar = 0;
  int wp_bdaftar = 0;
  var countMap = {}.obs;
  List<SalesData> dataHotel = [];
  List<SalesData> dataRestoran = [];
  List<SalesData> dataKatering = [];
  List<SalesData> dataHiburan = [];
  List<SalesData> dataParkir = [];

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  RxList list_id_wajib_pajak = [].obs;
  int grafik = 0; //status grafik tampil atau tidak tampil

  //DashboardServices services;
  Api api;
  DashboardController(this.api);

  @override
  void onInit() async {
    
     CheckJatuhTempo();
    
    // TODO: implement onInit
    final box = GetStorage();
    var user = box.read(STORAGE_LOGIN_USER_DATA);

    authModel = AuthModel.fromJson(user);
    super.onInit();
    checkLatestVersion();
    requestPermission();
    loadFCM();
    listenFCM();
    grafik_vaqris();

    CountUnseenChat();
    //row_admindaftar();
    //row_adminpelaporan();
    update();
  }

  void CheckJatuhTempo() async {
  try {
    final response = await cekJatuhTempo();
    final responseData = response.data;
      if (responseData['status'] == 'tidak_ada') {
        final controller = Get.find<
        JatuhTempoController>(); 
        controller.fetchJatuhTempo();
      } else{
        print("Data sudah ada");
      }
    
  } catch (e) {
     
  }
}

  void CountUnseenChat() {
    FirebaseFirestore.instance
        .collection('rooms')
        .where('participants', arrayContains: authModel.nik)
        .snapshots()
        .listen((QuerySnapshot roomQuerySnapshot) {
      roomQuerySnapshot.docs.forEach((roomDoc) {
        // Accessing data for each room document
        //String roomId = roomDoc.id;

        // Check if 'readBy' is a List and contains authModel.nik
        if (roomDoc['readBy'] is List &&
            roomDoc['readBy'].contains(authModel.nik.toString())) {
          readBy = true;
          update();
        } else {
          readBy = false;
          update();
        }

        // Use the readBy variable as needed
        // ...

        // Update your UI or state
        countUnseenChat.value = roomQuerySnapshot.docs.length;
        update();
      });
    });
  }

  Future<void> grafik_fetch() async {
    try {
      var response =
          await httpClient.get(Uri.parse("${URL_APP_API}/admin/grafik.php"));
      var data = json.decode(response.body);
      String jsonStr = jsonEncode(data);

      List<dynamic> jsonData =
          (json.decode(jsonStr) as Map<String, dynamic>)["parkir"];
      print(json.encode(jsonData));
      for (var item in jsonData) {
        String month = item.keys.first;
        double sales = item.values.first.toDouble();
        dataParkir.add(SalesData(month, sales));
      }

      List<dynamic> jsonData2 =
          (json.decode(jsonStr) as Map<String, dynamic>)["hotel"];
      print(json.encode(jsonData2));
      for (var item in jsonData2) {
        String month = item.keys.first;
        double sales = item.values.first.toDouble();
        dataHotel.add(SalesData(month, sales));
      }

      List<dynamic> jsonData3 =
          (json.decode(jsonStr) as Map<String, dynamic>)["hiburan"];
      print(json.encode(jsonData3));
      for (var item in jsonData3) {
        String month = item.keys.first;
        double sales = item.values.first.toDouble();
        dataHiburan.add(SalesData(month, sales));
      }

      List<dynamic> jsonData4 =
          (json.decode(jsonStr) as Map<String, dynamic>)["restoran"];
      print(json.encode(jsonData4));
      for (var item in jsonData4) {
        String month = item.keys.first;
        double sales = item.values.first.toDouble();
        dataRestoran.add(SalesData(month, sales));
      }

      // Call other void functions here
      if (grafik == 2 || grafik == 3) {
        await Future.delayed(Duration(seconds: 5));
        await row_wpterdaftar();
      }

      // Update the UI after all operations are completed
      update();
    } catch (e) {
      print("An error occurred: $e");
      // Handle the error here, if needed
    }
  }

  Future<void> row_wpterdaftar() async {
    var response = await httpClient
        .get(Uri.parse("${URL_APP_API}/admin/wp_terdaftar.php"));
    var data = json.decode(response.body);
    wp_daftar = int.parse(data["total_terdaftar"]);
    wp_bdaftar = data["total_wp"] - wp_daftar;
    update();
    if (grafik == 3) {
      await Future.delayed(Duration(seconds: 5));
      await grafik_vaqris();
    }
  }

  void row_admindaftar() async {
    var response = await httpClient
        .get(Uri.parse("${URL_APP_API}/badge/row_admindaftar.php"));
    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    value_admindaftar.value = data[0]["tot_data"];
    update();
  }

  void row_adminpelaporan() async {
    var response = await httpClient
        .get(Uri.parse("${URL_APP_API}/badge/row_adminpelaporan.php"));

    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    value_adminpelaporan.value = data[0]["tot_data"];
    update();
  }

  Future<void> grafik_vaqris() async {
    try {
      // Make GET request to your PHP script
      var response = await httpClient.get(Uri.parse(
          'http://simpatda.bontangkita.id/simpatda/api_mobile2/vaqris/edee9b7c-b723-4990-a674-dfd6da7efdd1'));

      if (response.statusCode == 200) {
        // Parse JSON response
        Map<String, dynamic> data = json.decode(response.body);

        // Update countMap with the fetched data
        countMap.assignAll(data);
        print(jsonEncode(countMap));
        update();
      } else {
        // Handle error
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception occurred: $e');
    }
    update();
  }

  void logout() {
    removeToken();
    removeUserdata();
    Get.offNamed(Routes.LOGIN);
  }

  void tombolpesan() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(authModel.nik)
        .get();
    String token = snap['token'];
    //print(token);
    sendPushMessage(token, "Tes Berita", "Isi Berita", "tes");
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ignore: unused_local_variable
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        print("Listen Pesan yang masuk${message.notification?.title}");
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              sound: RawResourceAndroidNotificationSound('notif'),
              playSound: true,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'ic_notification',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notif'),
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void checkLatestVersion() async {
    var response =
        await http.get(Uri.parse("${baseUrlApi}/cek_utilitas/index_admin.php"));
    if (response.statusCode == 200) {
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      String? DBVersion = data[0]["version"];
      grafik = int.parse(data[0]["grafik"]);
      if (grafik == 1 || grafik == 2 || grafik == 3) {
        grafik_fetch();
      }
      if (int.parse(DBVersion!) > currentversion) {
        print("tampilkan dialog");
        GetDialogDismissible(
            currentversion: currentversion, DBVersion: DBVersion);
        return; // Menghentikan eksekusi setelah menampilkan dialog
      }
      update();
    }

    // Lanjutkan dengan logika lain jika diperlukan
    if (Get.arguments == "login" || Get.arguments == "autologin") {
      showBanner();
      fetchMarkers();
    }
  }

  void fetchMarkers() {
    api.fetchMarkersData().then((data) async {
      // Use async here
      final markerList = <Marker>[];
      for (var markerData in data) {
        final marker = Marker(
          markerId: MarkerId("${markerData.id}"),
          position: LatLng(markerData.latitude, markerData.longitude),
          icon: await getCustomMarkerIcon("${markerData.jenispajak}"),
          infoWindow: InfoWindow(
            //popup info
            title: '${markerData.nama_usaha} ',
            snippet: '${markerData.npwpd}',
          ),
        );
        markerList.add(marker);
      }

      markers = Set<Marker>.from(markerList); // Use Set to create markers
      update();
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getCustomMarkerIcon(String markerType) async {
    // Map markerType to custom icons
    switch (markerType) {
      case "RESTORAN":
        return BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/icon/restaurant.png', 60));
      case "HOTEL":
        return BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/icon/hotel.png', 60));
      case "CAFETARIA":
        return BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/icon/restaurant.png', 60));
      case "HIBURAN":
        return BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/icon/hiburan.png', 60));
      case "WARUNG":
        return BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/icon/restaurant.png', 60));
      case "CATERING":
        return BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/icon/catering.png', 60));
      case "TOKO":
        return BitmapDescriptor.defaultMarker;
      case "LAIN-LAIN":
        return BitmapDescriptor.defaultMarker;

      // Define other cases and return appropriate BitmapDescriptors for each marker type
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void showBanner() async {
    getDefaultDialog().BannerDashboard(
        title: "Selamat Datang",
        desc: "Nikmati fitur-fitur terbaru pada Big Update Bapenda Etam");
    update();
  }

  void stopProcess() async {
    httpClient.close();
    print("already close");
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    // Perform cleanup tasks when the controller is disposed
    super.dispose();
    print('Controller disposed');
  }

  @override
  void onClose() {
    // Method onClose() dipanggil ketika controller dihapus dari memory
    // Anda dapat membatalkan request yang sedang berlangsung di sini

    super.onClose();
    print('Controller close');
  }
}
