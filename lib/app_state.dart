import 'package:flutter/foundation.dart';

class UserProfile {
  final String name;
  final String phone;
  final double balance;
  final String accountType;
  final String initials;

  const UserProfile({
    required this.name,
    required this.phone,
    required this.balance,
    required this.accountType,
    required this.initials,
  });
}

class AppState extends ChangeNotifier {
  final UserProfile user = const UserProfile(
    name: 'Alif Bin Saudh',
    phone: '+880 1912 478177',
    balance: 5898.50,
    accountType: 'Personal',
    initials: 'AB',
  );

  bool _isBalanceVisible = false;
  bool get isBalanceVisible => _isBalanceVisible;

  bool _oneTapEnabled = false;
  bool get oneTapEnabled => _oneTapEnabled;

  bool _nfcEnabled = false;
  bool get nfcEnabled => _nfcEnabled;

  bool _touchFaceIdEnabled = true;
  bool get touchFaceIdEnabled => _touchFaceIdEnabled;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }

  void toggleOneTap() {
    _oneTapEnabled = !_oneTapEnabled;
    notifyListeners();
  }

  void toggleNfc() {
    _nfcEnabled = !_nfcEnabled;
    notifyListeners();
  }

  void toggleTouchFaceId() {
    _touchFaceIdEnabled = !_touchFaceIdEnabled;
    notifyListeners();
  }

  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }
}