import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

// Daftar key SharedPreferences yang dipakai di aplikasi
class PrefKeys {
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String isLoggedIn = 'is_logged_in';
  static const String isDarkMode = 'is_dark_mode'; // Latihan 1
  static const String visitCount = 'visit_count'; // Latihan 2
  static const String favorites = 'favorites'; // Latihan 3
  static const String registeredEmails = 'registered_emails'; // Latihan 5
}

// Latihan 4: UserProvider diubah dari InheritedWidget menjadi ChangeNotifier.
// State disimpan di sini, dan setiap perubahan diumumkan dengan
// notifyListeners() sehingga Consumer / context.watch() ikut rebuild.
class UserProvider extends ChangeNotifier {
  User _user = User(name: '', email: '');
  bool _isLoading = true;
  bool _isDarkMode = false;
  int _visitCount = 0;
  List<String> _favorites = const [];

  // Latihan 5: simulasi email yang sudah terdaftar oleh pengguna lain
  static const List<String> _dummyRegisteredEmails = [
    'admin@amikom.ac.id',
    'test@example.com',
  ];

  // Getter: widget hanya boleh membaca, perubahan lewat method
  User get user => _user;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _isDarkMode;
  int get visitCount => _visitCount;
  List<String> get favorites => _favorites;

  UserProvider() {
    loadUser();
  }

  // Memuat data user dan preferensi dari SharedPreferences
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    _user = User(
      name: prefs.getString(PrefKeys.userName) ?? '',
      email: prefs.getString(PrefKeys.userEmail) ?? '',
      isLoggedIn: prefs.getBool(PrefKeys.isLoggedIn) ?? false,
    );
    _isDarkMode = prefs.getBool(PrefKeys.isDarkMode) ?? false;

    _visitCount = (prefs.getInt(PrefKeys.visitCount) ?? 0) + 1;
    await prefs.setInt(PrefKeys.visitCount, _visitCount);

    _favorites = List.unmodifiable(
      prefs.getStringList(PrefKeys.favorites) ?? <String>[],
    );

    _isLoading = false;
    notifyListeners();
  }

  // Menyimpan data user ke SharedPreferences
  Future<void> updateUser(User newUser) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefKeys.userName, newUser.name);
    await prefs.setString(PrefKeys.userEmail, newUser.email);
    await prefs.setBool(PrefKeys.isLoggedIn, newUser.isLoggedIn);

    // Latihan 5: catat email yang pernah didaftarkan di perangkat ini
    final registered =
        prefs.getStringList(PrefKeys.registeredEmails) ?? <String>[];
    final email = newUser.email.toLowerCase();
    if (!registered.contains(email)) {
      await prefs.setStringList(
        PrefKeys.registeredEmails,
        [...registered, email],
      );
    }

    _user = newUser;
    _isLoading = false;
    notifyListeners();
  }

  // Logout: hapus data user (kecuali email)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefKeys.userName);
    await prefs.setBool(PrefKeys.isLoggedIn, false);

    _user = _user.copyWith(name: '', isLoggedIn: false);
    notifyListeners();
  }

  // Latihan 1: ganti tema Light/Dark
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefKeys.isDarkMode, _isDarkMode);
  }

  // Latihan 3: tambah / hapus favorit
  Future<void> addFavorite(String item) async {
    final value = item.trim();
    if (value.isEmpty || _favorites.contains(value)) return;
    await _saveFavorites([..._favorites, value]);
  }

  Future<void> removeFavorite(String item) async {
    await _saveFavorites(_favorites.where((e) => e != item).toList());
  }

  Future<void> _saveFavorites(List<String> newList) async {
    _favorites = List.unmodifiable(newList);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefKeys.favorites, newList);
  }

  // Latihan 5: cek apakah email sudah digunakan
  Future<bool> isEmailTaken(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final normalized = email.trim().toLowerCase();

    final currentEmail =
        (prefs.getString(PrefKeys.userEmail) ?? '').toLowerCase();
    if (normalized == currentEmail) return false;

    final registered =
        prefs.getStringList(PrefKeys.registeredEmails) ?? <String>[];
    return _dummyRegisteredEmails.contains(normalized) ||
        registered.contains(normalized);
  }
}
