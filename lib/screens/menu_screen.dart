import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../constants/colors.dart';

class _MenuItem {
  final String id;
  final String label;
  final IconData icon;
  final String? badge;
  final String? route;
  const _MenuItem(this.id, this.label, this.icon, {this.badge, this.route});
}

final _menuItems = [
  _MenuItem('home',       'Home',               Icons.home_outlined,              route: '/home'),
  _MenuItem('statements', 'Statements',         MdiIcons.fileChartOutline),
  _MenuItem('limit',      'Limit',              MdiIcons.speedometerMedium),
  _MenuItem('customer',   'Customer Service',   MdiIcons.headphones),
  _MenuItem('map',        'bKash Map',          Icons.map_outlined),
  _MenuItem('infoupdate', 'Information Update', Icons.info_outline),
  _MenuItem('nominee',    'Nominee Update',     MdiIcons.accountEditOutline),
  _MenuItem('discover',   'Discover bKash',     MdiIcons.compassOutline, badge: 'New!'),
  _MenuItem('refer',      'Refer bKash App',    MdiIcons.shareOutline),
  _MenuItem('logout',     'Log out',            MdiIcons.logout),
];

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppState>().user;
    final topPad = MediaQuery.of(context).padding.top;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.fromLTRB(16, topPad, 16, 0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: Row(
              children: [
                Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(color: kPink, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text('b', style: TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text('bKash Menu',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: kText)),
                ),
                _HeaderBtn(icon: MdiIcons.dotsGrid, onTap: () {}),
                const SizedBox(width: 8),
                _HeaderBtn(icon: Icons.close, onTap: () => Navigator.pop(context)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: bottomPad + 16),
              child: Column(
                children: [
                  // AVA Card
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kDivider),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42, height: 42,
                          decoration: const BoxDecoration(color: kPink, shape: BoxShape.circle),
                          child: const Center(
                            child: Text('AVA',
                                style: TextStyle(color: kWhite, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('AVA', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kText)),
                              Text('Active Virtual Assistant',
                                  style: TextStyle(fontSize: 12, color: kGray)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Color(0xFFAAAAAA)),
                      ],
                    ),
                  ),

                  // Profile Link
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kDivider),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42, height: 42,
                            decoration: const BoxDecoration(color: kLightPink, shape: BoxShape.circle),
                            child: Center(
                              child: Text(user.initials,
                                  style: const TextStyle(color: kPink, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kText)),
                                Text(user.phone,
                                    style: const TextStyle(fontSize: 12, color: kGray)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Color(0xFFAAAAAA)),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8, color: const Color(0xFFF5F5F5), margin: const EdgeInsets.only(top: 16)),

                  // Menu Items
                  ..._menuItems.map((item) => _MenuRow(
                    item: item,
                    onTap: () {
                      if (item.id == 'logout') {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                      } else if (item.route != null) {
                        Navigator.pushNamed(context, item.route!);
                      }
                    },
                  )),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('Version 7.0.3',
                        style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34, height: 34,
        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), shape: BoxShape.circle),
        child: Icon(icon, size: 20, color: const Color(0xFF555555)),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final _MenuItem item;
  final VoidCallback onTap;
  const _MenuRow({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF5F5F5))),
        ),
        child: Row(
          children: [
            SizedBox(width: 32, child: Icon(item.icon, size: 20, color: const Color(0xFF555555))),
            const SizedBox(width: 12),
            Expanded(child: Text(item.label,
                style: const TextStyle(fontSize: 14, color: Color(0xFF222222)))),
            if (item.badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: kPink, borderRadius: BorderRadius.circular(10)),
                child: Text(item.badge!,
                    style: const TextStyle(color: kWhite, fontSize: 10, fontWeight: FontWeight.w600)),
              )
            else
              const Icon(Icons.chevron_right, size: 16, color: Color(0xFFBBBBBB)),
          ],
        ),
      ),
    );
  }
}