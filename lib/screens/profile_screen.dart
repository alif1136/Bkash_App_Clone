import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../constants/colors.dart';

class _SettingRow {
  final String id;
  final String label;
  final IconData icon;
  final bool hasToggle;
  const _SettingRow(this.id, this.label, this.icon, {this.hasToggle = false});
}

final _transactionFeatures = [
  _SettingRow('onetap',     'One-Tap Transaction',  MdiIcons.gestureTap,          hasToggle: true),
  _SettingRow('nfc',        'bKash NFC',             MdiIcons.nfc,                 hasToggle: true),
  _SettingRow('savedcards', 'Saved cards',           MdiIcons.creditCardOutline),
  _SettingRow('linkedapps', 'Linked Apps',           MdiIcons.apps),
  _SettingRow('touchid',    'Touch/Face ID',         MdiIcons.fingerprint,         hasToggle: true),
];

final _preferences = [
  _SettingRow('theme',         'Select Theme',            MdiIcons.paletteOutline),
  _SettingRow('notifications', 'Notification Management', MdiIcons.bellOutline, hasToggle: true),
];

final _accountSettings = [
  _SettingRow('updatenumber', 'Update bKash Number', MdiIcons.phoneOutline),
  _SettingRow('others',       'Others',              MdiIcons.dotsHorizontalCircleOutline),
];

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final user = app.user;
    final topPad = MediaQuery.of(context).padding.top;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    bool getToggleValue(String id) {
      switch (id) {
        case 'onetap':         return app.oneTapEnabled;
        case 'nfc':            return app.nfcEnabled;
        case 'touchid':        return app.touchFaceIdEnabled;
        case 'notifications':  return app.notificationsEnabled;
        default:               return false;
      }
    }

    void handleToggle(String id) {
      switch (id) {
        case 'onetap':        app.toggleOneTap(); break;
        case 'nfc':           app.toggleNfc(); break;
        case 'touchid':       app.toggleTouchFaceId(); break;
        case 'notifications': app.toggleNotifications(); break;
      }
    }

    Widget buildSection(String title, List<_SettingRow> rows) {
      return Container(
        color: kWhite,
        margin: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text(title.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500,
                      color: kGray, letterSpacing: 0.5)),
            ),
            ...rows.map((row) => Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFF5F5F5))),
              ),
              child: ListTile(
                leading: SizedBox(
                  width: 32,
                  child: Icon(row.icon, size: 20, color: const Color(0xFF555555)),
                ),
                title: Text(row.label,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF222222))),
                trailing: row.hasToggle
                    ? Switch(
                  value: getToggleValue(row.id),
                  onChanged: (_) => handleToggle(row.id),
                  activeColor: kPink,
                )
                    : const Icon(Icons.chevron_right, size: 16, color: Color(0xFFBBBBBB)),
              ),
            )),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          // Pink Header
          Container(
            color: kPink,
            padding: EdgeInsets.fromLTRB(16, topPad + 6, 16, 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: const Icon(Icons.arrow_back, color: kWhite, size: 22),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 52, height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.25),
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                  ),
                  child: Center(
                    child: Text(user.initials,
                        style: const TextStyle(color: kWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name,
                          style: const TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(MdiIcons.phone, size: 13, color: Colors.white.withOpacity(0.8)),
                          const SizedBox(width: 4),
                          Text(user.phone,
                              style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.8), width: 1.5),
                    foregroundColor: kWhite,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Edit', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: bottomPad + 16),
              child: Column(
                children: [
                  buildSection('Set Your Transaction Features', _transactionFeatures),
                  buildSection('Select Your Preferences', _preferences),
                  buildSection('Manage Your Account', _accountSettings),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}