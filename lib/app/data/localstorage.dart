import 'package:customer_bengkelly/app/data/publik.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorages {
  static GetStorage boxToken = GetStorage('token-mekanik');

  static Future<bool> hasToken() async {
    String token = await getToken;
    return token.isNotEmpty;
  }

  static Future<void> setToken(String token) async {
    await boxToken.write('token', token);
    Publics.controller.getToken.value = LocalStorages.getToken;
    return;
  }

  static String get getToken => boxToken.listenable.value['token'] ?? '';

  static Future<void> deleteToken() async {
    await boxToken.remove('token');
    Publics.controller.getToken.value = ''; // Set nilai token kosong setelah dihapus
  }

  // Tambahkan fungsi logout untuk menghapus token saat logout
  static Future<void> logout() async {
    await deleteToken(); // Panggil fungsi deleteToken
    // Tambahkan kode lain yang perlu dijalankan saat logout, jika ada
  }
}
