import 'package:bapenda_getx2_admin/app/modules/laporan_bayaroffline/bindings/laporan_bayaroffline_binding.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_bayaroffline/views/laporan_bayaroffline_view.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_bayaronline/bindings/laporan_bayaronline_binding.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_bayaronline/views/laporan_bayaronline_view.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_spt_be/bindings/laporan_sptbe_binding.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_spt_be/views/laporan_sptbe_view.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/views/OpenMap_npwpdbaru.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/views/OpenMap_tambahnpwpd.dart';
import 'package:get/get.dart';

import '../modules/aktivitas/bindings/aktivitas_binding.dart';
import '../modules/aktivitas/views/aktivitas_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat_room/bindings/chat_room_binding.dart';
import '../modules/chat_room/views/chat_room_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard.dart';
import '../modules/detail_screen/bindings/detail_screen_binding.dart';
import '../modules/detail_screen/views/detail_screen_view.dart';
import '../modules/laporan_1/bindings/laporan_1_binding.dart';
import '../modules/laporan_1/views/laporan_1_view.dart';
import '../modules/laporan_2/bindings/laporan_2_binding.dart';
import '../modules/laporan_2/views/laporan_2_view.dart';
import '../modules/laporan_daftaruser/bindings/laporan_daftaruser_binding.dart';
import '../modules/laporan_daftaruser/views/laporan_daftaruser_view.dart';
import '../modules/laporan_daftaruser_old/bindings/laporan_daftaruser_binding.dart';
import '../modules/laporan_daftaruser_old/views/laporan_daftaruser_view.dart';
import '../modules/laporan_qris/bindings/lap_detail_qris_binding.dart';
import '../modules/laporan_qris/bindings/laporan_qris_binding.dart';
import '../modules/laporan_qris/views/lap_detail_qris_view.dart';
import '../modules/laporan_qris/views/laporan_qris_view.dart';
import '../modules/laporan_va/bindings/lap_detail_va_binding.dart';
import '../modules/laporan_va/bindings/laporan_va_binding.dart';
import '../modules/laporan_va/views/lap_detail_va_view.dart';
import '../modules/laporan_va/views/laporan_va_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map_detail/views/map_detail_view.dart';
import '../modules/notif_jatuhtempo/bindings/notif_jatuhtempo_binding.dart';
import '../modules/notif_jatuhtempo/views/notif_jatuhtempo_view.dart';
import '../modules/pendaftaran/bindings/pendaftaran_binding.dart';
import '../modules/pendaftaran/bindings/pendaftaran_search_binding.dart';
import '../modules/pendaftaran/views/pendaftaran_search_view.dart';
import '../modules/pendaftaran/views/pendaftaran_view.dart';
import '../modules/pendaftaran_detail/bindings/pendaftaran_detail_binding.dart';
import '../modules/pendaftaran_detail/views/pendaftaran_detail_view.dart';
import '../modules/pendataan/bindings/pendataan_binding.dart';
import '../modules/pendataan/bindings/pendataan_search_binding.dart';
import '../modules/pendataan/views/pendataan_search_view.dart';
import '../modules/pendataan/views/pendataan_view.dart';
import '../modules/pendataan_detail/bindings/pendataan_detail_binding.dart';
import '../modules/pendataan_detail/bindings/pendataan_detail_ppj_binding.dart';
import '../modules/pendataan_detail/views/pendataan_detail_ppj_view.dart';
import '../modules/pendataan_detail/views/pendataan_detail_view.dart';
import '../modules/ppid/bindings/ppid_binding.dart';
import '../modules/ppid/views/ppid_view.dart';
import '../modules/push_notification/bindings/push_notification_binding.dart';
import '../modules/push_notification/views/push_notification_view.dart';
import '../modules/register/register_baru/bindings/register_baru_binding.dart';
import '../modules/register/register_baru/views/register_baru_view.dart';
import '../modules/register/register_npwpd/bindings/register_npwpd_binding.dart';
import '../modules/register/register_npwpd/views/register_npwpd_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tambah_npwpd/bindings/tambah_npwpd_binding.dart';
import '../modules/tambah_npwpd/views/tambah_npwpd_view.dart';
import '../modules/tambah_npwpdbaru/bindings/tambah_npwpdbaru_binding.dart';
import '../modules/tambah_npwpdbaru/views/tambah_npwpdbaru_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: _Paths.DASHBOARD,
        page: () => Dashboard(),
        binding: DashboardBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: _Paths.REGISTER_NPWPD,
      page: () => const RegisterNpwpdView(),
      binding: RegisterNpwpdBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_BARU,
      page: () => const RegisterBaruView(),
      binding: RegisterBaruBinding(),
    ),
    GetPage(
      name: _Paths.PENDAFTARAN,
      page: () => const PendaftaranView(),
      binding: PendaftaranBinding(),
      transition: Transition.noTransition,
      children: [
        GetPage(
          name: _Paths.PENDAFTARAN_SEARCH,
          page: () => const PendaftaranSearchView(),
          binding: PendaftaranSearchBinding(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: _Paths.OPENMAP_NPWPDBARU,
          page: () => OpenMapNpwpdBaru(),
          binding: TambahNpwpdbaruBinding(),
        ),
        GetPage(
          name: _Paths.OPENMAP_NPWPD,
          page: () => OpenMapTambahNpwpd(),
          binding: TambahNpwpdBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PENDAFTARAN_DETAIL,
      page: () => const PendaftaranDetailView(),
      binding: PendaftaranDetailBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SCREEN,
      page: () => const DetailScreenView(),
      binding: DetailScreenBinding(),
    ),
    GetPage(
        name: _Paths.PENDATAAN,
        page: () => const PendataanView(),
        binding: PendataanBinding(),
        transition: Transition.noTransition,
        children: [
          GetPage(
            name: _Paths.PENDATAAN_SEARCH,
            page: () => const PendataanSearchView(),
            binding: PendataanSearchBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.PENDATAAN_DETAIL,
      page: () => const PendataanDetailView(),
      binding: PendataanDetailBinding(),
      children: [
        GetPage(
          name: _Paths.PENDATAAN_DETAIL_PPJ,
          page: () => const PendataanDetailPpjView(),
          binding: PendataanDetailPpjBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MAP_DETAIL,
      page: () => const MapDetailView(),
    ),
    GetPage(
      name: _Paths.PPID,
      page: () => const PpidView(),
      binding: PpidBinding(),
    ),
    GetPage(
      name: _Paths.PUSH_NOTIFICATION,
      page: () => const PushNotificationView(),
      binding: PushNotificationBinding(),
    ),
    GetPage(
      name: _Paths.AKTIVITAS,
      page: () => const AktivitasView(),
      binding: AktivitasBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_VA,
      page: () => const LaporanVaView(),
      binding: LaporanVaBinding(),
      children: [
        GetPage(
          name: _Paths.LAP_DETAIL_VA,
          page: () => const LapDetailVaView(),
          binding: LapDetailVaBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LAPORAN_QRIS,
      page: () => const LaporanQrisView(),
      binding: LaporanQrisBinding(),
      children: [
        GetPage(
          name: _Paths.LAP_DETAIL_QRIS,
          page: () => const LapDetailQrisView(),
          binding: LapDetailQrisBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LAPORAN_1,
      page: () => const LaporanSPTBEView(),
      binding: LaporanSPTBEBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_1,
      page: () => const Laporan1View(),
      binding: Laporan1Binding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_2,
      page: () => const Laporan2View(),
      binding: Laporan2Binding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_BAYARONLINE,
      page: () => const LaporanBayarOnlineView(),
      binding: LaporanBayarOnlineBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_BAYAROFFLINE,
      page: () => const LaporanBayarOfflineView(),
      binding: LaporanBayarOfflineBinding(),
    ),
    GetPage(
      name: _Paths.NOTIF_JATUHTEMPO,
      page: () => const NotifJatuhtempoView(),
      binding: NotifJatuhtempoBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_DAFTARUSER,
      page: () => const LaporanDaftaruserView(),
      binding: LaporanDaftaruserBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_DAFTARUSER_OLD,
      page: () => const LaporanDaftaruserViewOld(),
      binding: LaporanDaftaruserBindingOld(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => const ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_NPWPD,
      page: () => const TambahNpwpdView(),
      binding: TambahNpwpdBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_NPWPDBARU,
      page: () => const TambahNpwpdbaruView(),
      binding: TambahNpwpdbaruBinding(),
    ),
  ];
}
