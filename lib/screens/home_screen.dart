import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import 'menu_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    final List<Map<String, dynamic>> services = [
      {'icon': Icons.send, 'label': 'Send Money', 'color': Colors.orange},
      {'icon': Icons.phone_android, 'label': 'Mobile Recharge', 'color': Colors.green},
      {'icon': Icons.account_balance_wallet, 'label': 'Cash Out', 'color': Colors.teal},
      {'icon': Icons.payment, 'label': 'Make Payment', 'color': Colors.purple},
      {'icon': Icons.add_circle_outline, 'label': 'Add Money', 'color': Colors.blue},
      {'icon': Icons.receipt_long, 'label': 'Pay Bill', 'color': Colors.red},
      {'icon': Icons.savings, 'label': 'Savings', 'color': Colors.indigo},
      {'icon': Icons.account_balance, 'label': 'Loan', 'color': Colors.brown},
      {'icon': Icons.security, 'label': 'Insurance', 'color': Colors.cyan},
      {'icon': Icons.swap_horiz, 'label': 'bKash to Bank', 'color': Colors.deepOrange},
      {'icon': Icons.school, 'label': 'Education Fee', 'color': Colors.blueGrey},
      {'icon': Icons.credit_card, 'label': 'Microfinance', 'color': Colors.pink},
      {'icon': Icons.toll, 'label': 'Toll', 'color': Colors.lime},
      {'icon': Icons.request_quote, 'label': 'Request Money', 'color': Colors.amber},
      {'icon': Icons.send_to_mobile, 'label': 'Remittance', 'color': Colors.lightBlue},
      {'icon': Icons.volunteer_activism, 'label': 'Donation', 'color': Colors.deepPurple},
    ];

    return Scaffold(
      backgroundColor: AppTheme.lightGrey,
      body: Column(
        children: [
          // Pink top bar
          Container(
            color: AppTheme.bkashPink,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Text(
                      user.avatarInitials,
                      style: const TextStyle(
                        color: AppTheme.bkashPink,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Tap for Balance',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white, size: 26),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 26),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 26),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MenuScreen()),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Services grid
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        _buildServiceRow(context, services.sublist(0, 4)),
                        const SizedBox(height: 16),
                        _buildServiceRow(context, services.sublist(4, 8)),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('See More', style: TextStyle(color: AppTheme.bkashPink)),
                              Icon(Icons.keyboard_arrow_down, color: AppTheme.bkashPink),
                            ],
                          ),
                        ),
                        _buildServiceRow(context, services.sublist(8, 12)),
                        const SizedBox(height: 16),
                        _buildServiceRow(context, services.sublist(12, 16)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Banner
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    height: 130,
                    decoration: BoxDecoration(
                      color: AppTheme.bkashPink,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.nfc, color: Colors.white, size: 40),
                          Text(
                            'NFC ক্যাশব্যাক',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text('আজই পান!',
                              style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Quick Features
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Quick Features',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _quickFeatureCard(
                                  Icons.person, user.avatarInitials, AppTheme.bkashPink),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _quickFeatureCard(
                                  Icons.credit_card, 'VISA', Colors.blue),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _quickFeatureCard(Icons.lock, 'Locked', Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _offerCard(Icons.local_offer, 'My Offers', Colors.orange),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _offerCard(Icons.confirmation_number, 'Coupons', Colors.teal),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _offerCard(Icons.emoji_events, 'Rewards', Colors.amber),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRow(BuildContext context, List<Map<String, dynamic>> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((item) => _serviceItem(item)).toList(),
    );
  }

  Widget _serviceItem(Map<String, dynamic> item) {
    return SizedBox(
      width: 78,
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: (item['color'] as Color).withOpacity(0.12),
            child: Icon(item['icon'] as IconData,
                color: item['color'] as Color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            item['label'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _quickFeatureCard(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _offerCard(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}