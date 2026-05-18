class UserModel {
  String name;
  String phone;
  String avatarInitials;
  bool nfcEnabled;
  bool oneTapEnabled;
  bool touchFaceIdEnabled;
  bool notificationsEnabled;
  String selectedTheme;
  String language; // 'EN' or 'BN'

  UserModel({
    this.name = 'Jannat Al Naeem',
    this.phone = '+880 1912 474177',
    this.avatarInitials = 'JN',
    this.nfcEnabled = true,
    this.oneTapEnabled = true,
    this.touchFaceIdEnabled = false,
    this.notificationsEnabled = true,
    this.selectedTheme = 'Default',
    this.language = 'EN',
  });
}