import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDetailView extends GetView<DashboardController> {
  const MapDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Statistik Map Wajib Pajak", leading: true, isLogin: true),
      body: Center(
        child: GoogleMap(
          mapType: MapType.normal,
          indoorViewEnabled: true,
          markers: controller.markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(0.13295280196348974, 117.47944742888573),
            zoom: 13.5,
          ),
          onMapCreated: (GoogleMapController controllers) {},
        ),
      ),
    );
  }
}
