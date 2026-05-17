import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import 'home_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.bar_chart_outlined, 'label': 'Statements'},
      {'icon': Icons.data_usage_outlined, 'label': 'Limit'},
      {'icon': Icons.headset_mic_outlined, 'label': 'Customer Service'},
      {'icon': Icons.map_outlined, 'label': 'bKash Map'},
      {'icon': Icons.info_outline, 'label': 'Information Update'},
      {'icon': Icons.people_outline, 'label': 'Nominee Update'},
      {'icon': Icons.explore_outlined, 'label': 'Discover bKash', 'isNew': true},
      {'icon': Icons.share_outlined, 'label': 'Refer bKash App'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'bKash Menu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.bkashPink,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => userProvider.toggleLanguage(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          _langTab('Eng', user.language == 'EN'),
                          const SizedBox(width: 4),
                          _langTab('বাং', user.language == 'BN'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // AVA Card
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppTheme.bkashPink.withOpacity(0.1),
                    child: const Text(
                      'AVA',
                      style: TextStyle(
                        color: AppTheme.bkashPink,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('AVA',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('Pro',
                                style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const Text('Active virtual Assistant',
                          style: TextStyle(
                              fontSize: 12, color: AppTheme.greyText)),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  ...menuItems.map((item) => _buildMenuItem(
                    context: context,
                    icon: item['icon'] as IconData,
                    label: item['label'] as String,
                    isNew: item['isNew'] == true,
                    onTap: () {
                      if (item['label'] == 'Home') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                              (route) => false,
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  )),

                  const Divider(height: 24),

                  // Log out
                  _buildMenuItem(
                    context: context,
                    icon: Icons.logout,
                    label: 'Log out',
                    isNew: false,
                    iconColor: Colors.red,
                    labelColor: Colors.red,
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // Version
                  const Center(
                    child: Text(
                      'Version 7.0.0',
                      style: TextStyle(fontSize: 12, color: AppTheme.greyText),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _langTab(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: active ? AppTheme.bkashPink : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: active ? Colors.white : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isNew,
    required VoidCallback onTap,
    Color iconColor = AppTheme.greyText,
    Color labelColor = Colors.black87,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      leading: Icon(icon, color: iconColor, size: 22),
      title: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: labelColor)),
          if (isNew) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('New',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }
}