import 'package:bapenda_getx2_admin/app/modules/dashboard/models/grafik1.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';

import 'package:bapenda_getx2_admin/widgets/custtombottombar.dart';
import 'package:bapenda_getx2_admin/widgets/pilih_pendaftaran.dart';
import 'package:bapenda_getx2_admin/widgets/utils/helper/responsive_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/dashboard_controller.dart';

import 'package:bapenda_getx2_admin/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class Dashboard extends GetView<DashboardController> {
  final DashboardController controller = Get.find();
  Dashboard({super.key});
  List<_SalesData> dataHotel = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
  ];
  List<_SalesData> dataRestoran = [
    _SalesData('Jan', 20),
    _SalesData('Feb', 32),
    _SalesData('Mar', 43),
  ];
  List<_SalesData> dataHiburan = [
    _SalesData('Jan', 32),
    _SalesData('Feb', 12),
    _SalesData('Mar', 53),
  ];
  List<_SalesData> dataKatering = [
    _SalesData('Jan', 43),
    _SalesData('Feb', 23),
    _SalesData('Mar', 43),
  ];
  List<_SalesData> dataParkir = [
    _SalesData('Jan', 19),
    _SalesData('Feb', 52),
    _SalesData('Mar', 35),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(Get.find<Api>()),
      builder: (controller) {
        return Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Image.asset(
              "assets/images/appbar-bapenda.png",
              height: Get.width * 0.2,
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: ResponsiveHelper.isTablet()
                        ? null
                        : BoxDecoration(
                            color: lightColor,
                            border: Border.all(width: 2.w, color: shadowColor2),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                    child: IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.bars,
                        color: primaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  ),
                );
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: ResponsiveHelper.isTablet()
                      ? null
                      : BoxDecoration(
                          color: lightColor,
                          border: Border.all(width: 2.w, color: shadowColor2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: primaryColor,
                    ),
                    tooltip: "Open notifications menu",
                    onPressed: () => Get.toNamed(Routes.DASHBOARD),
                  ),
                ),
              ),
            ],
          ),
          drawer: buildDrawer(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.r),
                  child: Text(
                    'Selamat Datang, ${controller.authModel.nama}',
                    style: TextStyle(
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[Color(0xFF03045e), Color(0xFF1ed8a2)],
                        ).createShader(
                          Rect.fromLTWH(60.0, 0.0, 140.0, 0.0),
                        ),
                      fontSize: 12.7.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.r),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 170.h,
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    indoorViewEnabled: true,
                                    markers: controller.markers,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(0.13295280196348974,
                                          117.47944742888573),
                                      zoom: 12.7,
                                    ),
                                    onMapCreated:
                                        (GoogleMapController controllers) {},
                                  ),
                                ),
                                Positioned(
                                  right: 5.r,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.MAP_DETAIL);
                                    },
                                    child: Icon(
                                      Icons.zoom_out_map,
                                      size: 20.r,
                                      color: Colors.black87,
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(35.r, 34.r)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 12.r, right: 12.r, bottom: 12.r),
                  child: Container(
                    height: 250.h,
                    width: 350.w,
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          maximum: 2.5,
                        ),
                        margin: EdgeInsets.only(top: 1),
                        // Chart title
                        title: ChartTitle(
                            text: "Jumlah Pelaporan Pajak",
                            textStyle: TextStyle(
                              fontSize: 12.sp,
                            )),
                        // Enable legend
                        legend: Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<SalesData, String>>[
                          ColumnSeries<SalesData, String>(
                              dataSource: controller.dataHotel,
                              xValueMapper: (SalesData sales, _) => sales.month,
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              name: 'Hotel',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false)),
                          ColumnSeries<SalesData, String>(
                              dataSource: controller.dataRestoran,
                              xValueMapper: (SalesData sales, _) => sales.month,
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              name: 'Restoran',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false)),
                          ColumnSeries<SalesData, String>(
                              dataSource: controller.dataHiburan,
                              xValueMapper: (SalesData sales, _) => sales.month,
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              name: 'Hiburan',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false)),
                          ColumnSeries<SalesData, String>(
                              dataSource: controller.dataParkir,
                              xValueMapper: (SalesData sales, _) => sales.month,
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              name: 'Parkir',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false)),
                        ]),
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.r),
                    child: Container(
                      height: ResponsiveHelper.isTablet() ? 180.h : 150.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 2.0)
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: SfCircularChart(
                        tooltipBehavior: TooltipBehavior(enable: true),
                        title: ChartTitle(
                            text:
                                "Wajib Pajak yang telah menggunakan \nBapenda Etam",
                            textStyle: TextStyle(
                              fontSize: 12.sp,
                            )),
                        legend: Legend(
                            isVisible: true,
                            position: LegendPosition.left,
                            iconHeight:
                                ResponsiveHelper.isTablet() ? 50 : null),
                        series: <DoughnutSeries<_DaftarWP, String>>[
                          DoughnutSeries<_DaftarWP, String>(
                            strokeColor: Colors.white,
                            strokeWidth: 2,
                            dataSource: <_DaftarWP>[
                              _DaftarWP(' WP Terdaftar', controller.wp_daftar,
                                  Color.fromARGB(255, 125, 225, 212)),
                              _DaftarWP(
                                  ' WP Belum Terdaftar',
                                  controller.wp_bdaftar,
                                  Color.fromARGB(255, 133, 175, 223)),
                            ],
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                fontSize: ResponsiveHelper.isTablet()
                                    ? 8.sp
                                    : null, // Set your desired font size here
                                color: Colors
                                    .black, // You can also set the text color if needed
                              ),
                            ),
                            dataLabelMapper: (_DaftarWP data, _) =>
                                '${data.jumlah} WP',
                            xValueMapper: (_DaftarWP data, _) => data.data,
                            yValueMapper: (_DaftarWP data, _) => data.jumlah,
                            radius: ResponsiveHelper.isTablet() ? "70" : "47",
                          ),
                        ],
                        margin: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Container(
                      height: 190.h,
                      child: GridView(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 1),
                                    blurRadius: 2.0)
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text: "Data Dummy",
                                  textStyle: TextStyle(
                                    fontSize: 11.4.sp,
                                  )),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom),
                              series: <DoughnutSeries<_MetodePembayaran,
                                  String>>[
                                DoughnutSeries<_MetodePembayaran, String>(
                                  strokeColor: Colors.white,
                                  strokeWidth: 2,
                                  dataSource: <_MetodePembayaran>[
                                    _MetodePembayaran('Target', 30,
                                        Color.fromARGB(255, 125, 225, 212)),
                                    _MetodePembayaran('Realisasi', 20,
                                        Color.fromARGB(255, 133, 175, 223)),
                                  ],
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: false),
                                  xValueMapper: (_MetodePembayaran data, _) =>
                                      data.year,
                                  yValueMapper: (_MetodePembayaran data, _) =>
                                      data.sales,
                                  radius:
                                      ResponsiveHelper.isTablet() ? "70" : "47",
                                  pointColorMapper:
                                      (_MetodePembayaran data, _) => data.color,
                                ),
                              ],
                              margin: EdgeInsets.zero,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 1),
                                    blurRadius: 2.0)
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text: "Jumlah Transaksi \nOnline",
                                  textStyle: TextStyle(
                                    fontSize: 11.4.sp,
                                  )),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom),
                              series: <PieSeries<_MetodePembayaran, String>>[
                                PieSeries<_MetodePembayaran, String>(
                                  strokeColor: Colors.white,
                                  strokeWidth: 2,
                                  dataSource: <_MetodePembayaran>[
                                    _MetodePembayaran(
                                        'VA',
                                        controller.countMap['VA'] == null
                                            ? 0
                                            : controller.countMap['VA'],
                                        Color.fromARGB(255, 225, 213, 125)),
                                    _MetodePembayaran(
                                        'QRIS',
                                        controller.countMap['QRIS'] == null
                                            ? 0
                                            : controller.countMap['QRIS'],
                                        Color.fromARGB(255, 125, 225, 208)),
                                  ],
                                  // Enable data label
                                  name: "Transaksi",
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: false),
                                  xValueMapper: (_MetodePembayaran data, _) =>
                                      data.year,
                                  radius:
                                      ResponsiveHelper.isTablet() ? "70" : "47",
                                  yValueMapper: (_MetodePembayaran data, _) =>
                                      data.sales,
                                  pointColorMapper:
                                      (_MetodePembayaran data, _) => data.color,
                                ),
                              ],
                              margin: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //SizedBox(height: 200.h)
              ],
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
              PilihPendaftaran(context, controller.authModel);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: customButtomBar(),
        );
      },
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _MetodePembayaran {
  _MetodePembayaran(this.year, this.sales, this.color);

  final String year;
  final int sales;
  final Color color;
}

class _DaftarWP {
  _DaftarWP(this.data, this.jumlah, this.color);

  final String data;
  final int jumlah;
  final Color color;
}
