import 'package:get/get.dart';

import '../componen/spleshscreen.dart';
import '../componen/spleshscreen_notoken.dart';
import '../data/data_endpoint/lokasilistrik.dart';
import '../modules/authorization/bindings/authorization_binding.dart';
import '../modules/authorization/componen/forget_password.dart';
import '../modules/authorization/componen/login_page.dart';
import '../modules/authorization/componen/new_password.dart';
import '../modules/authorization/componen/otp_verrifikasi.dart';
import '../modules/authorization/componen/signup_next.dart';
import '../modules/authorization/componen/signup_page.dart';
import '../modules/authorization/componen/ubah_password.dart';
import '../modules/authorization/views/authorization_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/componen/berhasil_booking.dart';
import '../modules/booking/componen/detailbooking.dart';
import '../modules/booking/componen/select_maps.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/booking_emergency/views/emergencybooking_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/componen/detail_history.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/detail/detailbengkelly/lokasibengkelly.dart';
import '../modules/home/detail/detailspesialis/spesialisofer.dart';
import '../modules/home/detail/lihatsemua/lihat_lokasi_bengkelly.dart';
import '../modules/home/detail/lihatsemua/lihat_spesialis.dart';
import '../modules/home/menu/lokasi_bengkelly.dart';
import '../modules/home/menu/lokasi_listrik.dart';
import '../modules/home/menu/repair&maintenance.dart';
import '../modules/home/views/home_view.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/componen/edit_profile.dart';
import '../modules/profile/componen/pengaturan.dart';
import '../modules/profile/componen/pilih_kendaraan.dart';
import '../modules/profile/componen/pusat_bantuan.dart';
import '../modules/profile/componen/widgets/tambah_kendaraan.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREENNO;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTHORIZATION,
      page: () => const AuthorizationView(),
      binding: AuthorizationBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.SINGIN,
      page: () => LoginPage(),
      binding: AuthorizationBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.SINGUP,
      page: () => SignupPage(),
      binding: AuthorizationBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.SINGUPNEXT,
      page: () => RegisterPage(),
      binding: AuthorizationBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.LUPAPASSWORD,
      page: () => ForgetPasswordPage(),
      binding: AuthorizationBinding(),
    ),
    GetPage(
      name: _Paths.NEWS,
      page: () => NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.CHAT,
      page: () => const HelpCenterPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.NOTIFIKASI,
      page: () => const Notofikasi(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.BOOKING,
      page: () => BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.SELECTBOOKING,
      page: () => SelectBooking(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.REPAIRMAINTENANCE,
      page: () => const RepairMaintenance(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.LOKASIBENGKELLY,
      page: () => const LokasiBengkelly(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.zoom,
      name: _Paths.EDITPROFILE,
      page: () => const EditProfile(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.PENGATURAN,
      page: () => const Pengaturan(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.PILIHKENDARAAN,
      page: () => PilihKendaraan(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.BANTUAN,
      page: () => const Bantuan(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.DETAILLOKASIBENGKELLY,
      page: () => DetailLokasiBengkelly(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.DETAILSPECIAL,
      page: () => DetailSpecialOffer(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.DETAILBOOKING,
      page: () => DetailBookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.DETAILHISTORY,
      page: () => DetailHistory(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.TAMBAHKENDARAAN,
      page: () => TambahKendaraan(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.SUKSESBOOKING,
      page: () => SuksesBooking(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => MyCustomSplashScreen(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREENNO,
      page: () => MyCustomSplashScreenno(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.SEMUALOKASIBENGKELLY,
      page: () => SemuaLokasiBengkelly(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.LIHATSEMUASPESIALIS,
      page: () => LihatSemuaSpesialis(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.NEWPASSWORD,
      page: () => const NewPasswordPage(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.OTP,
      page: () => const OtpVerificationPage(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.LOKASILISTRIK,
      page: () => LokasiListrik1(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.EmergencyBookingView,
      page: () => EmergencyBookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.UBAHPASSWORD,
      page: () => UbahPasswordPage(),
      binding: BookingBinding(),
    ),
  ];
}
