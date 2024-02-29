import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/auth/service/auth_cache_service.dart';
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
  List<SalesData> dataHotel = [];
  List<SalesData> dataRestoran = [];
  List<SalesData> dataKatering = [];
  List<SalesData> dataHiburan = [];
  List<SalesData> dataParkir = [];

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  RxList list_id_wajib_pajak = [].obs;

  //DashboardServices services;
  Api api;
  DashboardController(this.api);

  @override
  void onInit() async {
    // TODO: implement onInit
    final box = GetStorage();
    var user = box.read(STORAGE_LOGIN_USER_DATA);

    authModel = AuthModel.fromJson(user);
    super.onInit();
    grafik_hotel();
    grafik_restoran();
    //grafik_katering();
    grafik_hiburan();
    grafik_parkir();
    row_wpterdaftar();
    row_wpbterdaftar();
    requestPermission();
    loadFCM();
    listenFCM();
    fetchMarkers();
    checkLatestVersion();

    CountUnseenChat();
    row_admindaftar();
    row_adminpelaporan();
    update();
  }

  void CountUnseenChat() {
    FirebaseFirestore.instance
        .collection('rooms')
        .where('participants', arrayContains: authModel.nik)
        .snapshots()
        .listen((QuerySnapshot roomQuerySnapshot) {
      roomQuerySnapshot.docs.forEach((roomDoc) {
        // Accessing data for each room document
        String roomId = roomDoc.id;

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

  void grafik_hotel() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/admin/grafik_hotel.php"));
    var data = json.decode(response.body);
    String jsonStr = jsonEncode(data);
    List<dynamic> jsonData = json.decode(jsonStr);

    // Iterate over each JSON object and populate the list
    for (var item in jsonData) {
      String month = item.keys.first; // Extract month
      double sales = item.values.first.toDouble(); // Extract sales

      // Create _SalesData object and add it to the list
      dataHotel.add(SalesData(month, sales));
    }
    update();
  }

  void grafik_restoran() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/admin/grafik_restoran.php"));
    var data = json.decode(response.body);
    String jsonStr = jsonEncode(data);
    List<dynamic> jsonData = json.decode(jsonStr);

    // Iterate over each JSON object and populate the list
    for (var item in jsonData) {
      String month = item.keys.first; // Extract month
      double sales = item.values.first.toDouble(); // Extract sales

      // Create _SalesData object and add it to the list
      dataRestoran.add(SalesData(month, sales));
    }
    update();
  }

  void grafik_katering() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/admin/grafik_katering.php"));
    if (response.body != "0 results") {
      var data = json.decode(response.body);
      String jsonStr = jsonEncode(data);
      List<dynamic> jsonData = json.decode(jsonStr);

      // Iterate over each JSON object and populate the list
      for (var item in jsonData) {
        String month = item.keys.first; // Extract month
        double sales = item.values.first.toDouble(); // Extract sales

        // Create _SalesData object and add it to the list
        dataKatering.add(SalesData(month, sales));
      }
    }

    update();
  }

  void grafik_hiburan() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/admin/grafik_hiburan.php"));
    var data = json.decode(response.body);
    String jsonStr = jsonEncode(data);
    List<dynamic> jsonData = json.decode(jsonStr);

    // Iterate over each JSON object and populate the list
    for (var item in jsonData) {
      String month = item.keys.first; // Extract month
      double sales = item.values.first.toDouble(); // Extract sales

      // Create _SalesData object and add it to the list
      dataHiburan.add(SalesData(month, sales));
    }
    update();
  }

  void grafik_parkir() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/admin/grafik_parkir.php"));
    var data = json.decode(response.body);
    String jsonStr = jsonEncode(data);
    List<dynamic> jsonData = json.decode(jsonStr);

    // Iterate over each JSON object and populate the list
    for (var item in jsonData) {
      String month = item.keys.first; // Extract month
      double sales = item.values.first.toDouble(); // Extract sales

      // Create _SalesData object and add it to the list
      dataParkir.add(SalesData(month, sales));
    }
    update();
  }

  void row_wpterdaftar() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/admin/wp_terdaftar.php"));
    var data = json.decode(response.body);
    wp_daftar = int.parse(data["total_terdaftar"]);
    update();
  }

  void row_wpbterdaftar() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/admin/wp_totalsimpatda.php"));
    var data1 = json.decode(response.body);
    wp_bdaftar = data1["total_wp"] - wp_daftar;
    update();
  }

  void row_admindaftar() async {
    var response =
        await http.get(Uri.parse("${URL_APP_API}/badge/row_admindaftar.php"));
    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    value_admindaftar.value = data[0]["tot_data"];
    update();
  }

  void row_adminpelaporan() async {
    var response = await http
        .get(Uri.parse("${URL_APP_API}/badge/row_adminpelaporan.php"));

    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    value_adminpelaporan.value = data[0]["tot_data"];
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
    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    String? DBVersion = data[0]["version"];
    if (int.parse(DBVersion!) > currentversion) {
      print("tampilkan dialog");
      GetDialogDismissible(
          currentversion: currentversion, DBVersion: DBVersion);
    } else {
      if (Get.arguments == "login" || Get.arguments == "autologin") {
        showBanner();
      }
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
}
