import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Pink header
          Container(
            color: AppTheme.bkashPink,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 8,
              right: 16,
              bottom: 16,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                const Icon(Icons.send, color: Colors.white),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile top card
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppTheme.bkashPink.withOpacity(0.15),
                          child: Text(
                            user.avatarInitials,
                            style: const TextStyle(
                              color: AppTheme.bkashPink,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.circle,
                                      color: Colors.green, size: 8),
                                  const SizedBox(width: 4),
                                  Text(
                                    user.phone,
                                    style: const TextStyle(
                                        fontSize: 13, color: AppTheme.greyText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () =>
                              _showEditDialog(context, userProvider, user.name),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.bkashPink,
                            side: const BorderSide(color: AppTheme.bkashPink),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text('Edit',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1, thickness: 6, color: AppTheme.lightGrey),

                  // Transaction Features
                  _sectionHeader('Set Your Transaction Features'),

                  _switchTile(
                    icon: Icons.touch_app,
                    label: 'One-Tap Transaction',
                    value: user.oneTapEnabled,
                    onChanged: (v) => userProvider.toggleOneTap(v),
                  ),
                  _switchTile(
                    icon: Icons.nfc,
                    label: 'bKash NFC',
                    value: user.nfcEnabled,
                    onChanged: (v) => userProvider.toggleNfc(v),
                  ),
                  _infoTile(icon: Icons.credit_card_outlined, label: 'Saved Cards'),
                  _infoTile(icon: Icons.link, label: 'Linked Apps'),
                  _switchTile(
                    icon: Icons.fingerprint,
                    label: 'Touch/Face ID',
                    value: user.touchFaceIdEnabled,
                    onChanged: (v) => userProvider.toggleTouchFaceId(v),
                  ),

                  const Divider(height: 1, thickness: 6, color: AppTheme.lightGrey),

                  // Preferences
                  _sectionHeader('Select Your Preferences'),

                  _infoTile(icon: Icons.palette_outlined, label: 'Select Theme'),
                  _switchTile(
                    icon: Icons.notifications_outlined,
                    label: 'Notification Management',
                    value: user.notificationsEnabled,
                    onChanged: (v) => userProvider.toggleNotifications(v),
                  ),

                  const Divider(height: 1, thickness: 6, color: AppTheme.lightGrey),

                  // Manage Account
                  _sectionHeader('Manage Your Account'),

                  _infoTile(
                      icon: Icons.phone_android_outlined,
                      label: 'Update bKash Number'),
                  _infoTile(icon: Icons.more_horiz, label: 'Others'),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.greyText,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _infoTile({required IconData icon, required String label}) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.greyText, size: 22),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: () {},
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.greyText, size: 22),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.bkashPink,
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, UserProvider provider, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profile'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.bkashPink),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                provider.updateName(controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}