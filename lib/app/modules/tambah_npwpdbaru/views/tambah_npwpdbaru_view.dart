import 'dart:io';

import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:bapenda_getx2_admin/widgets/text_fields.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/tambah_npwpdbaru_controller.dart';

class TambahNpwpdbaruView extends StatefulWidget {
  const TambahNpwpdbaruView({Key? key}) : super(key: key);

  @override
  _TambahNpwpdbaruViewState createState() => _TambahNpwpdbaruViewState();
}

class _TambahNpwpdbaruViewState extends State<TambahNpwpdbaruView> {
  final controller = Get.find<TambahNpwpdbaruController>();

  @override
  void initState() {
    super.initState();
  }

  List<Step> stepList() => [
    Step(
          state: controller.activeStepIndex <= 0
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex >= 0,
          title:  Text('AKUN',
                      style: TextStyle(
                          fontSize: 11.sp)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Punya Akun'),
                    value: '1',
                    groupValue: controller.hasAkun.value,
                    onChanged: (value) {
                      controller.setHasAkun(value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Belum Punya Akun'),
                    value: '2',
                    groupValue: controller.hasAkun.value,
                    onChanged: (value) {
                      controller.setHasAkun(value!);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controller.hasAkun.value == '1') {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(width: Get.width * 0.58,child: TextFields.defaultTextField2(
                                    title: "Masukkan NIK Akun Terdaftar",
                                    controller: controller.nik,
                                    isLoading: controller.isLoading,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.number,
                                    prefixIcon: Icons.contact_emergency,
                                    borderColor: primaryColor,
                                    validator: true,
                                  ),),
                        Padding(
                          padding: EdgeInsets.only(top: 20.r),
                          child: Container(width: Get.width * 0.15,child: SizedBox(
                                        width: 45.w, // <-- Your width
                                        height: 50.h, // <-- Your height
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                                  primary: controller.checkNIKstatus ? Colors.green[300] : Colors.blue,
                                                ),
                                          onPressed: () {
                                            controller.checkNIK();
                                          },
                                          child: controller.checkNIKstatus ? Icon(Icons.check_box,size: 30.r,) : Text(
                                            "Cek \nNIK",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10.5.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),),),
                        ),
                         
                      ],
                    ),
                    Texts.caption(
                      "*Pastikan sudah Klik Cek NIK sebelum lanjut ke Formulir selanjutnya",
                      maxLines: 2,
                      color: const Color.fromARGB(197, 0, 0, 0)),
                  ],
                );
              } else if (controller.hasAkun.value == '2') {
                return Form(
                key: controller.formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        children: [
                          TextFields.defaultTextField2(
                              title: "Nama Lengkap Pemilik",
                              controller: controller.nama,
                              isLoading: controller.isLoading,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              prefixIcon: Icons.person,
                              borderColor: primaryColor,
                              validator: true,
                              textCapitalization: TextCapitalization.words),
                          TextFields.defaultTextField2(
                            title: "No. HP",
                            controller: controller.no_hp,
                            isLoading: controller.isLoading,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            prefixIcon: Icons.phone_android,
                            borderColor: primaryColor,
                            validator: true,
                          ),
                          TextFields.defaultTextField2(
                            title: "NIK Pemilik",
                            controller: controller.nik,
                            isLoading: controller.isLoading,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            prefixIcon: Icons.contact_emergency,
                            borderColor: primaryColor,
                            validator: true,
                          ),
                          TextFields.defaultTextField2(
                            title: "Password",
                            controller: controller.password,
                            isLoading: controller.isLoading,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            prefixIcon: Icons.key,
                            borderColor: primaryColor,
                            validator: true,
                          ),
                        ],
                      )),
                  Texts.caption(
                      "*Anda harus mengingat Password ini untuk Login kedalam Aplikasi",
                      maxLines: 2,
                      color: const Color.fromARGB(197, 0, 0, 0)),
                   
                ],
                ),
              );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: controller.activeStepIndex <= 1
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex >= 1,
          title:  Text('USAHA',
                      style: TextStyle(
                          fontSize: 11.sp)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Texts.body2("Jenis Pajak :"),
                    ),
                    Container(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.ValueJenisPajak,
                            isDense: true,
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                controller.ValueJenisPajak = newValue!;
                              });
                            },
                            items: <String>[
                              // 'PT',
                              // 'CV',
                              // 'UD',
                              'HOTEL',
                              'RESTORAN',
                              'WARUNG',
                              'CATERING',
                              'CAFETARIA',
                              'HIBURAN',
                              // 'YAYASAN/KOPERASI',
                              // 'PERKANTORAN',
                              // 'PRIBADI',
                              // 'BENGKEL',
                              // 'TOKO',
                              // 'APOTEK',
                              // 'LAIN-LAIN',
                              // 'BPHTB',
                              'Air Bawah T',
                              'Pajak Penerangan Jalan',
                              'Sarang Burung Walet',
                              'Parkir'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 11.5.sp),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Texts.body2("Nama Usaha :"),
                    ),
                    Container(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.nama_usaha,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Texts.body2("Alamat :"),
                        ],
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.alamat_usaha,
                        minLines:
                            2, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("RT :"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.rt_usaha,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Kota :"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.characters,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kota_usaha,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kelurahan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.ValueKelurahan,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          controller.ValueKelurahan = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'LUAR KOTA',
                                        'LOK TUAN',
                                        'BONTANG BARU',
                                        'BONTANG KUALA',
                                        'API-API',
                                        'GUNUNG ELAI',
                                        'GUNTUNG',
                                        'TANJUNG LAUT',
                                        'SATIMPO',
                                        'BERBAS TENGAH',
                                        'BERBAS PANTAI',
                                        'BONTANG LESTARI',
                                        'TJ. LAUT INDAH',
                                        'BELIMBING',
                                        'TELIHAN',
                                        'KANAAN',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 10.5.sp),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kecamatan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.ValueKecamatan,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          controller.ValueKecamatan = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'LUAR KOTA',
                                        'BONTANG UTARA',
                                        'BONTANG SELATAN',
                                        'BONTANG BARAT',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 10.5.sp),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("No HP :"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.nohp_usaha,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Email :"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.email_usaha,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: controller.activeStepIndex <= 2
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex >= 2,
          title:  Text('PEMILIK',
                      style: TextStyle(
                          fontSize: 11.sp)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Texts.body2("Nama Pemilik/Pengelola :"),
                        ),
                        SizedBox(
                            // <-- Your width
                            height: 23.h, // <-- Your height
                            child: controller.buttonsalin
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[200], // background
                                      onPrimary: lightTextColor, // foreground
                                    ),
                                    onPressed: () {
                                      controller.hapussalin();
                                    },
                                    child: Text(
                                      "Hapus Salinan",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: lightBlueColor, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    onPressed: () {
                                      controller.salin();
                                    },
                                    child: Text(
                                      "Salin dari Usaha",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                      ],
                    ),
                    Container(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.nama_pemilik,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Texts.body2("Pekerjaan/Jabatan :"),
                    ),
                    Container(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.pekerjaan_pemilik,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 251, 161, 161),
                                width: 2.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Texts.body2("Alamat :"),
                        ],
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.alamat_pemilik,
                        minLines:
                            3, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(12.r, 12.r, 12.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("RT"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.rt_pemilik,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Kota :"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.characters,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kota_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kelurahan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kel_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Data harus diisi";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kecamatan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kec_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Data harus diisi";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("No HP :"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.nohp_pemilik,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Email :"),
                              ),
                              Container(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.email_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(child: Texts.body2("Upload KTP :")),
                            ),
                            Container(
                              width: 80,
                              height: 60,
                              child: (controller.imageFileKTP == null)
                                  ? Text("")
                                  : Image.file(
                                      File(controller.imageFileKTP!.path)),
                            ),
                            SizedBox(
                              width: 128.w,
                              height: 33.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.showChoiceDialog(context, "KTP");
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 64, 64, 64)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.camera_alt, size: 20),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Pilih Gambar',
                                      style: TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child:
                                    Center(child: Texts.body2("Upload NPWP :")),
                              ),
                              Container(
                                width: 80,
                                height: 60,
                                child: (controller.imageFileNPWP == null)
                                    ? Text("")
                                    : Image.file(
                                        File(controller.imageFileNPWP!.path)),
                              ),
                              SizedBox(
                                width: 128.w,
                                height: 33.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.showChoiceDialog(
                                        context, "NPWP");
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 64, 64, 64)),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.camera_alt, size: 20),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Pilih Gambar',
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: controller.activeStepIndex >= 3,
          title:  Text('LOKASI',
                      style: TextStyle(
                          fontSize: 11.sp)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "Tentukan Titik Lokasi Objek Pajak Anda",
                    style: TextStyle(
                        color: MainColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 230.w,
                    height: 35.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, // background
                            onPrimary: Blacksoft, // foreground
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          Get.toNamed(Routes.OPENMAP_NPWPDBARU);
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/mark-google.png',
                              width: 15.w,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('Klik Disini untuk tentukan lokasi')
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GetBuilder<TambahNpwpdbaruController>(
                    init: TambahNpwpdbaruController(),
                    builder: (controller) {
                      return SizedBox(
                        height: 200.h,
                        child: controller.lat == null
                            ? SizedBox()
                            : GoogleMap(
                                markers: controller.markers2,
                                mapType: MapType.satellite,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      controller.lat == null
                                          ? 0.13295280196348974
                                          : controller.lat!,
                                      controller.long == null
                                          ? 117.47944742888573
                                          : controller.long!),
                                  zoom: 18,
                                ),
                                onMapCreated:
                                    (GoogleMapController controllers) {
                                  controller.addMarkers();
                                },
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ];
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: MainColor //change your color here
              ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Form Pendaftaran NPWPD Baru",
            style: TextStyle(color: MainColor),
          ),
           
        ),
        body: GetBuilder<TambahNpwpdbaruController>(
          init: TambahNpwpdbaruController(),
          builder: (controller) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: controller.activeStepIndex,
              steps: stepList(),
              onStepContinue: () {
                if (controller.activeStepIndex < (stepList().length - 1)) {
                  setState(() {
                    controller.activeStepIndex += 1;
                    dismissKeyboard();
                  });
                } else {
                  print('Submited');
                }
              },
              onStepCancel: () {
                if (controller.activeStepIndex == 0) {
                  return;
                }
                setState(() {
                  controller.activeStepIndex -= 1;
                });
              },
              onStepTapped: (int index) {
                setState(() {
                  controller.activeStepIndex = index;
                });
              },
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                final isLastStep =
                    controller.activeStepIndex == stepList().length - 1;
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (isLastStep)
                          ? SizedBox(
                              width: 140,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if(controller.hasAkun == '1' && controller.checkNIKstatus == false){
                                      RawSnackbar_top(
                                          message:
                                              "Anda harus melakukan Check NIK terlebih dahulu",
                                          kategori: "warning",
                                          duration: 2);
                                    }
                                    if (controller.nik.text == "" ||
                                      controller.ValueJenisPajak == null ||
                                        controller.nama_usaha.text == "" ||
                                        controller.alamat_usaha.text == "" ||
                                        controller.rt_usaha.text == "" ||
                                        controller.kota_usaha.text == "" ||
                                        controller.ValueKelurahan == "" ||
                                        controller.ValueKecamatan == "" ||
                                        controller.nohp_usaha.text == "" ||
                                        controller.email_usaha.text == "" ||
                                        controller.nama_pemilik.text == "" ||
                                        controller.pekerjaan_pemilik.text ==
                                            "" ||
                                        controller.alamat_pemilik.text == "" ||
                                        controller.rt_pemilik.text == "" ||
                                        controller.kota_pemilik.text == "" ||
                                        controller.kel_pemilik.text == "" ||
                                        controller.kec_pemilik.text == "" ||
                                        controller.nohp_pemilik.text == "" ||
                                        controller.email_pemilik.text == "") {
                                      RawSnackbar_top(
                                          message:
                                              "Semua Form Wajib diisi! \nSilahkan Periksa Kembali",
                                          kategori: "warning",
                                          duration: 2);
                                    } else if (controller.imageFileKTP ==
                                        null) {
                                      RawSnackbar_top(
                                          message:
                                              "Upload KTP Tidak Boleh Kosong!",
                                          kategori: "warning",
                                          duration: 2);
                                    } else if (controller.imageFileNPWP ==
                                        null) {
                                      RawSnackbar_top(
                                          message:
                                              "Upload NPWP Tidak Boleh Kosong!",
                                          kategori: "warning",
                                          duration: 2);
                                    } else if (controller.lat == null &&
                                        controller.long == null) {
                                      RawSnackbar_top(
                                          message:
                                              "Lokasi Map Objek Pajak Wajib tentukan",
                                          kategori: "warning",
                                          duration: 2);
                                    } else {
                                      controller.SimpanData();
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            lightBlueColor),
                                  ),
                                  child: Text(
                                    'Simpan Data',
                                    style: TextStyle(fontSize: 14),
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                dismissKeyboard();
                              },
                              child: SizedBox(
                                width: 140,
                                child: ElevatedButton(
                                    onPressed: controls.onStepContinue,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              lightBlueColor),
                                    ),
                                    child: Text(
                                      'Selanjutnya',
                                      style: TextStyle(fontSize: 14),
                                    )),
                              ),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (controller.activeStepIndex > 0)
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              onPressed: controls.onStepCancel,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        veryLightTextColor),
                              ),
                              child: Text(
                                'Kembali',
                                style: TextStyle(fontSize: 14),
                              )),
                        ),
                        
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
