import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  int? id_user;
  String? fullname;
  String? email;
  String? phone;
  String? address;


  // Simpan sesi
  Future<void> saveSession(int value, int id_user, String fullname, String email, String phone, String address) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("value", value);
    await pref.setInt("id_user", id_user);
    await pref.setString("fullname", fullname);
    await pref.setString("email", email);
    await pref.setString("phone", phone);
    await pref.setString("address", address);
  }

  // Ambil sesi
  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    id_user = pref.getInt("id_user");
    fullname = pref.getString("fullname");
    email = pref.getString("email");
    phone = pref.getString("phone");
    address = pref.getString("address");
  }

  // Hapus sesi -> logout
  Future<void> clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

// Instance class biar dipanggil
SessionManager sessionManager = SessionManager();
