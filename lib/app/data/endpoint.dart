import 'dart:convert';
import 'dart:ui';import 'package:customer_bengkelly/app/data/data_endpoint/bookingcustomer.dart';
import 'package:customer_bengkelly/app/data/data_endpoint/createkendaraan.dart';
import 'package:customer_bengkelly/app/data/data_endpoint/lupapassword.dart';
import 'package:customer_bengkelly/app/data/data_endpoint/otp.dart';
import 'package:customer_bengkelly/app/data/publik.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../routes/app_pages.dart';
import 'data_endpoint/bookingemergency.dart';
import 'data_endpoint/customkendaraan.dart';
import 'data_endpoint/generalcekup.dart';
import 'data_endpoint/history.dart';
import 'data_endpoint/jenisservice.dart';
import 'data_endpoint/kategorikendaraan.dart';
import 'data_endpoint/lokasi.dart';
import 'data_endpoint/lokasilistrik.dart';
import 'data_endpoint/merekkendaraan.dart';
import 'data_endpoint/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_endpoint/profile.dart';
import 'data_endpoint/register.dart';
import 'data_endpoint/tipekendaraan.dart';
import 'localstorage.dart';


class API {
  //News ----------------------------------------------------------------------------------
  static const _bengkellyUrl = 'https://bengkelly.co.id/wp-json/wp/v2/posts';
  static const _fleetMaintenanceUrl = 'https://fleetmaintenance.co.id/wp-json/wp/v2/posts';
  static const _katagorikendaraan = 'https://api-vale.techthinkhub.com/api/kategori-kendaraan';
  //API ------------------------------------------------------------------------------------
  // static const _url = 'https://mobile.techthinkhub.id';
  static const _urlbe = 'https://api-vale.techthinkhub.com';
  static const _baseUrl = '$_urlbe/api';
  static const _PostLogin = '$_baseUrl/customer/login';
  static const _Getprofile = '$_baseUrl/customer-get-profile';
  static const _PostRegister = '$_baseUrl/register-kendaraan';
  static const _PostCreateKendaraan = '$_baseUrl/customer-create-kendaraan';
  static const _postCreateBooking = '$_baseUrl/booking/book-rest-area';
  static const _GetLokasi = '$_baseUrl/get-lokasi';
  static const _GetLokasiRechargeStasiun = '$_baseUrl/spklu-jawa';
  static const _GetHistory = '$_baseUrl/history';
  static const _GetGeneralCheckup = '$_baseUrl/general-checkup';
  static const _GetEmergencyService = '$_baseUrl/emergency-service';
  static const _GetEmergencyService2 = '$_baseUrl/emergency-service';
  static const _GetMerek = '$_baseUrl/merk';
  static const _GetTipe = '$_baseUrl/tipe';
  static const _GetCustomKendaraan = '$_baseUrl/customer-kendaraan';
  static const _GetJenisService = '$_baseUrl/get-jenis-service';
  static const _PostLupaPassword = '$_baseUrl/customer/kirim-otp';
  static const _PostOTP = '$_baseUrl/customer/verify-otp';
  static const _PostResetPassword = '$_baseUrl/customer/reset-password';


  static Future<String?> login({required String email, required String password}) async {
    final data = {
      "email": email,
      "password": password,
    };

    try {
      var response = await Dio().post(
        _PostLogin,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          if (responseData['status'] == false) {
            Get.snackbar('Error', responseData['message'],
                backgroundColor: const Color(0xffe5f3e7));
            return null;
          } else {
            String token = responseData['token'];
            LocalStorages.setToken(token);
            Get.snackbar('Selamat Datang', 'Vale Indonesia',
                backgroundColor:Colors.green,
                colorText: Colors.white
            );
            Get.offAllNamed(Routes.HOME);
            return token;
          }
        } else {
          print('Unexpected response format');
          throw Exception('Unexpected response format');
        }
      } else {
        print('Failed to load data, status code: ${response.statusCode}');
        throw Exception('Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      throw e;
    }
  }

  //Beda
  static Future<Register> RegisterID({
    required String nama,
    required String hp,
    required String email,
    required String password,
    required String passwordconfirmation,
    required String alamat,
    required String nopolisi,
    required String idmerk,
    required String idtipe,
    required String kategorikendaraan,
    required String tahun,
    required String warna,
    required String transmisi,
  }) async {
    final data = {
      "nama": nama,
      "hp": hp,
      "email": email,
      "password": password,
      "password_confirmation": passwordconfirmation,
      "alamat": alamat,
      "no_polisi": nopolisi,
      "id_merk": idmerk,
      "id_tipe": idtipe,
      "kategori_kendaraan": kategorikendaraan,
      "tahun": tahun,
      "warna": warna,
      "transmisi": transmisi,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().post(
        _PostRegister,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        Get.snackbar(
          'Hore',
          'Registrasi Akun Anda Berhasil!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Terjadi kesalahan saat registrasi',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }

      final obj = Register.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }

      return obj;
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Gagal Registrasi',
        'Terjadi kesalahan saat registrasi',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      throw e;
    }
  }
  //Beda
  static Future<BookingCustomer?> BookingID({
    required String idcabang,
    required String idjenissvc,
    required String keluhan,
    required String tglbooking,
    required String jambooking,
    required String idkendaraan,
  }) async {
    final data = {
      "id_cabang": idcabang,
      "id_jenissvc": idjenissvc,
      "keluhan": keluhan,
      "tgl_booking": tglbooking,
      "jam_booking": jambooking,
      "id_kendaraan": idkendaraan,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');
      print('Request Data: $data');

      var response = await Dio().post(
        _postCreateBooking,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final obj = BookingCustomer.fromJson(response.data);

        // Check for specific message in response
        if (obj.message == 'Invalid token: Expired') {
          Get.offAllNamed(Routes.SUKSESBOOKING);
          Get.snackbar(
            obj.message.toString(),
            obj.message.toString(),
            backgroundColor: Colors.yellow,
            colorText: Colors.black,
          );
        } else {
        }
        return obj;
      } else {
        Get.snackbar(
          'Gagal',
          'Mungkin alamat email anda tidak terdaftar',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error during registration: $e');
    }
  }
  //Beda
  static Future<LupaPassword?> LupaPasswordID({
    required String email,
  }) async {
    final data = {
      "email": email,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');
      print('Request Data: $data');

      var response = await Dio().post(
        _PostLupaPassword,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final obj = LupaPassword.fromJson(response.data);

        // Check for specific message in response
        if (obj.message == 'Invalid token: Expired') {
          Get.offAllNamed(Routes.SUKSESBOOKING);
          Get.snackbar(
            obj.message.toString(),
            obj.message.toString(),
            backgroundColor: Colors.yellow,
            colorText: Colors.black,
          );
        } else {
          Get.snackbar(
            'OTP',
            'Kode OTP Sudah di Kirim ke alamat Email Anda',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.OTP);
        }
        return obj;
      } else {

        throw Exception('Failed to register booking: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Gagal',
        'Email anda mungkin tidak terdaftar atau ada kesalahan pengetikan',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
  //Beda
  //Beda
  static Future<OTP> OTPID({
    required String otp,
  }) async {
    final data = {
      "otp": otp,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');
      print('Request Data: $data');

      var response = await Dio().post(
        _PostOTP,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final obj = OTP.fromJson(response.data);

        // Check for specific message in response
        if (obj.message == 'Invalid token: Expired') {
          Get.offAllNamed(Routes.SUKSESBOOKING);
          Get.snackbar(
            obj.message.toString(),
            obj.message.toString(),
            backgroundColor: Colors.yellow,
            colorText: Colors.black,
          );
        } else {
          Get.snackbar(
            'OTP Tervirifikasi',
            'Silahkan masukan pasword baru anda',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.NEWPASSWORD);
        }
        return obj;
      } else {
        throw Exception('Failed to register booking: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error during registration: $e');
    }
  }
  //Beda
  static Future<OTP> ResetPasswordID({
    required String email,
    required String password,
    required String passwordconfirmation,
  }) async {
    final data = {
      "email": email,
      "password": password,
      "password_confirmation": passwordconfirmation,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');
      print('Request Data: $data');

      var response = await Dio().post(
        _PostResetPassword,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final obj = OTP.fromJson(response.data);

        // Check for specific message in response
        if (obj.message == 'Invalid token: Expired') {
          Get.offAllNamed(Routes.SINGIN);
          Get.snackbar(
            obj.message.toString(),
            obj.message.toString(),
            backgroundColor: Colors.yellow,
            colorText: Colors.black,
          );
        } else {
          Get.snackbar(
            'Reset Password Berhasil',
            'Password baru anda sudah bisa digunakan',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.SINGIN);
        }
        return obj;
      } else {
        throw Exception('Failed to register booking: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error during registration: $e');
    }
  }
  //Beda
  static Future<BookingEmergency> EmergencyServiceID({
    required String idcabang,
    required String keluhan,
    required String berita,
    required String idkendaraan,
  }) async {
    final data = {
      "id_cabang": idcabang,
      "keluhan": keluhan,
      "berita": berita,
      "id_kendaraan": idkendaraan,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().post(
        _GetEmergencyService,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final obj = BookingEmergency.fromJson(response.data);

        // Check for specific message in response
        if (obj.message == 'Invalid token: Expired') {
          Get.offAllNamed(Routes.HOME);
          Get.snackbar(
            obj.message.toString(),
            obj.message.toString(),
            backgroundColor: Colors.yellow,
            colorText: Colors.black,
          );
        } else {
          Get.snackbar(
            'Berhasil',
            'Emergency Service akan segera di lawani',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }

        return obj;
      } else {

        throw Exception('Failed to register booking: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');

      throw Exception('Error during registration: $e');
    }
  }
//Beda
// Beda
  static Future<BookingEmergency> EmergencyServiceValeID({
    required String idcabang,
    required String keluhan,
    required String idkendaraan,
    required String location,

  }) async {
    final data = {
      "id_cabang": idcabang,
      "keluhan": keluhan,
      "id_kendaraan": idkendaraan,
      "location": location,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().post(
        _GetEmergencyService2,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final obj = BookingEmergency.fromJson(response.data);

        // Check for specific message in response
        if (obj.message == 'Invalid token: Expired') {
          Get.offAllNamed(Routes.HOME);
          Get.snackbar(
            obj.message.toString(),
            obj.message.toString(),
            backgroundColor: Colors.yellow,
            colorText: Colors.black,
          );
        } else {
          Get.snackbar(
            'Berhasil',
            'Emergency Service akan segera di lawani',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }

        return obj;
      } else {
        throw Exception('Failed to register booking: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error during registration: $e');
    }
  }
//Beda
  static Future<CreateKendaraan> CreateKendaraanID({
    required String nopolisi,
    required String idmerk,
    required String idtipe,
    required String warna,
    required String tahun,
    required String categoryname,
    required String transmission,
  }) async {
    final data = {
      "no_polisi": nopolisi,
      "id_merk": idmerk,
      "id_tipe": idtipe,
      "warna": warna,
      "tahun": tahun,
      "category_name": categoryname,
      "transmission": transmission,
    };

    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().post(
        _PostCreateKendaraan,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final obj = CreateKendaraan.fromJson(response.data);

        // Check for specific message in response
        if (obj.message == 'Invalid token: Expired') {
          Get.offAllNamed(Routes.HOME);
          Get.snackbar(
            obj.message.toString(),
            obj.message.toString(),
            backgroundColor: Colors.yellow,
            colorText: Colors.black,
          );
        } else {
          Get.snackbar(
            'Berhasil',
            'Data kendaraan anda sudah dapat melakukan Booking service',
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        }

        return obj;
      } else {
        Get.snackbar(
          'Error',
          'Terjadi kesalahan saat Emergency Service: ${response.statusMessage}',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        throw Exception('Failed to register booking: ${response.statusMessage}');
      }
    } catch (e) {
      Get.snackbar(
        'Berhasil',
        'Data kendaraan anda berhasil kami simpan',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.HOME);
      throw Exception();
    }
  }
//Beda
  static Future<MerekKendaraan> merekid() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetMerek,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return MerekKendaraan(status: false, message: "Tidak ada data booking untuk karyawan ini.");
      }

      final obj = MerekKendaraan.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }

      return obj;
    } catch (e) {
      throw e;
    }
  }
  //Beda
  static Future<KategoryKendaraan> kategorykendaraanID() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _katagorikendaraan,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return KategoryKendaraan(status: false, message: "Tidak ada data booking untuk karyawan ini.");
      }

      final obj = KategoryKendaraan.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }

      return obj;
    } catch (e) {
      throw e;
    }
  }
  //Beda
  static Future<TipeKendaraan> tipekendaraanID({required int id}) async {
    try {
      var response = await Dio().get(
        '$_GetTipe/$id', // Make sure this correctly formats the URL
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 404) {
        return TipeKendaraan(status: false, message: "Tidak ada data booking untuk karyawan ini.");
      }

      final obj = TipeKendaraan.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }

      return obj;
    } catch (e) {
      throw e;
    }
  }
  //Beda
  static Future<CustomerKendaraan> PilihKendaraan() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetCustomKendaraan,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return CustomerKendaraan(status: false, message: "Tidak ada data booking untuk karyawan ini.");
      }

      final obj = CustomerKendaraan.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }

      return obj;
    } catch (e) {
      throw e;
    }
  }
//Beda
  static Future<Profile> profileiD() async {
    final token = Publics.controller.getToken.value ?? '';
    var data = {"token": token};
    try {
      var response = await Dio().get(
        _Getprofile,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return Profile(status: false, message: "Tidak ada data booking untuk karyawan ini.");
      }

      final obj = Profile.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }
      return obj;
    } catch (e) {
      throw e;
    }
  }
  //Beda
  static Future<HistoryBooking> HistoryBookingID() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response: ${response.data}');

      final obj = HistoryBooking.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }
      return obj;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  } //Beda
  static Future<Lokasi> LokasiBengkellyID() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().get(
        _GetLokasi,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response: ${response.data}');

      final obj = Lokasi.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }
      return obj;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  } //Beda
  static Future<LokasiListrik> LokasiListrikID() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().get(
        _GetLokasiRechargeStasiun,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response: ${response.data}');

      final obj = LokasiListrik.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }
      return obj;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  } //Beda
  static Future<JenisServiceResponse> JenisServiceID() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      print('Token: $token');

      var response = await Dio().get(
        _GetJenisService,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response: ${response.data}');

      final obj = JenisServiceResponse.fromJson(response.data);

      if (obj.message == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.message.toString(),
          obj.message.toString(),
        );
      }
      return obj;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  } //Beda
  static Future<GeneralCheckup> GCMekanikID({
    required String kategoriKendaraanId,
  }) async {
    final token = Publics.controller.getToken.value;
    var data = {
      "kategori_kendaraan_id": kategoriKendaraanId,
    };
    try {
      var response = await Dio().get(
        _GetGeneralCheckup,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 404) {
        throw Exception("Tidak ada data general checkup.");
      }

      final obj = GeneralCheckup.fromJson(response.data);

      if (obj.data == null) {
        throw Exception("Data general checkup kosong.");
      }

      return obj;
    } catch (e) {
      throw e;
    }
  }
  //Beda
  static Future<void> showBookingNotificationsDitolak() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Ditolak') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            10,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsLunas() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Lunas') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            9,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsInvoice() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Invoice') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            8,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsSelesaiDikerjakan() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Selesai Dikerjakan') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            7,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsPKBTUTUP() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'PKB TUTUP') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            6,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsPKB() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'PKB') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            5,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsEstimasi() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Estimasi') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            4,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsDiproses() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Diproses') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            3,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<void> showBookingNotificationsBooking() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Booking') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            2,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  //Beda

  static Future<void> showBookingNotificationsApprove() async {
    try {
      final token = Publics.controller.getToken.value ?? '';
      var data = {"token": token};
      var response = await Dio().get(
        _GetHistory,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: data,
      );

      if (response.statusCode == 404) {
        return;
      }
      final obj = HistoryBooking.fromJson(response.data);
      if (obj.status == 'Invalid token: Expired') {
        Get.offAllNamed(Routes.SINGIN);
        Get.snackbar(
          obj.status.toString(),
          obj.status.toString(),
        );
      }
      final bookings = obj.datahistory ?? [];
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      for (final booking in bookings) {
        if (booking.namaStatus == 'Approve') {
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('sounds'),
          );
          const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            1,
            'Booking ${booking.namaStatus ?? ''}',
            booking.namaJenissvc ?? '',
            platformChannelSpecifics,
            payload: 'item x', // optional, used for onClick event
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }
  //Beda
  static Future<List<Post>> fetchPostsFromSource({
    required String url,
    int perPage = 10,
    int page = 1,
  }) async {
    final response = await http.get(Uri.parse('$url?_embed&per_page=$perPage&page=$page'));

    if (response.statusCode == 200) {
      List<dynamic> postsJson = json.decode(response.body);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.reasonPhrase}');
    }
  }

  static Future<List<Post>> fetchBengkellyPosts({int perPage = 10, int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('bengkelly_posts');

    if (savedData != null && savedData.isNotEmpty) {
      List<dynamic> postsJson = json.decode(savedData);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      List<Post> posts = await fetchPostsFromSource(url: _bengkellyUrl, perPage: perPage, page: page);
      return posts;
    }
  }

  static Future<List<Post>> fetchFleetMaintenancePosts({int perPage = 10, int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('fleet_maintenance_posts');

    if (savedData != null && savedData.isNotEmpty) {
      List<dynamic> postsJson = json.decode(savedData);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      List<Post> posts = await fetchPostsFromSource(url: _fleetMaintenanceUrl, perPage: perPage, page: page);
      return posts;
    }
  }
}
