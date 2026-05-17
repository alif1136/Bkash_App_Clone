import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  void updateName(String name) {
    _user.name = name;
    _user.avatarInitials = name.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase();
    notifyListeners();
  }

  void updatePhone(String phone) {
    _user.phone = phone;
    notifyListeners();
  }

  void toggleNfc(bool value) {
    _user.nfcEnabled = value;
    notifyListeners();
  }

  void toggleOneTap(bool value) {
    _user.oneTapEnabled = value;
    notifyListeners();
  }

  void toggleTouchFaceId(bool value) {
    _user.touchFaceIdEnabled = value;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _user.notificationsEnabled = value;
    notifyListeners();
  }

  void setTheme(String theme) {
    _user.selectedTheme = theme;
    notifyListeners();
  }

  void toggleLanguage() {
    _user.language = _user.language == 'EN' ? 'BN' : 'EN';
    notifyListeners();
  }
}