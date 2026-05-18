import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../constants/colors.dart';

class _Service {
  final String id;
  final String label;
  final IconData icon;
  const _Service(this.id, this.label, this.icon);
}

final _mainServices = [
  _Service('send',      'Send Money',      MdiIcons.send),
  _Service('recharge',  'Mobile Recharge', MdiIcons.cellphone),
  _Service('cashout',   'Cash Out',        MdiIcons.cash),
  _Service('payment',   'Make Payment',    MdiIcons.shoppingOutline),
  _Service('addmoney',  'Add Money',       MdiIcons.plusCircleOutline),
  _Service('paybill',   'Pay Bill',        MdiIcons.fileDocumentOutline),
  _Service('savings',   'Savings',         MdiIcons.piggyBankOutline),
  _Service('loan',      'Loan',            MdiIcons.bankOutline),
];

final _moreServices = [
  _Service('insurance',    'Insurance',     MdiIcons.shieldCheckOutline),
  _Service('bkashbank',    'bKash to Bank', MdiIcons.bankTransfer),
  _Service('education',    'Education Fee', MdiIcons.schoolOutline),
  _Service('micro',        'Microfinance',  MdiIcons.handCoinOutline),
  _Service('toll',         'Toll',          MdiIcons.boomGateUpOutline),
  _Service('requestmoney', 'Request Money', MdiIcons.accountCashOutline),
  _Service('remittance',   'Remittance',    MdiIcons.earth),
  _Service('donation',     'Donation',      MdiIcons.handHeartOutline),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showMore = false;

  Widget _buildServiceItem(_Service svc) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4 - 8,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: kLightPink,
              shape: BoxShape.circle,
            ),
            child: Icon(svc.icon, color: kPink, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            svc.label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF333333)),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(List<_Service> services) {
    final rows = <List<_Service>>[];
    for (var i = 0; i < services.length; i += 4) {
      rows.add(services.sublist(i, i + 4 > services.length ? services.length : i + 4));
    }
    return Column(
      children: rows.map((row) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row.map(_buildServiceItem).toList(),
        ),
      )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final user = app.user;
    final topPad = MediaQuery.of(context).padding.top;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    final balanceText = app.isBalanceVisible
        ? '৳ ${user.balance.toStringAsFixed(2)}'
        : 'Tap for Balance';

    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          // ── Header ──
          Container(
            color: kPink,
            padding: EdgeInsets.fromLTRB(16, topPad + 8, 16, 14),
            child: Row(
              children: [
                // Avatar + name + balance
                Expanded(
                  child: GestureDetector(
                    onTap: app.toggleBalanceVisibility,
                    child: Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                          ),
                          child: Center(
                            child: Text(user.initials,
                                style: const TextStyle(color: kWhite, fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name,
                                  style: const TextStyle(color: kWhite, fontSize: 14, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 16, height: 16,
                                      decoration: BoxDecoration(
                                        color: kPink,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: const Center(
                                        child: Text('৳',
                                            style: TextStyle(color: kWhite, fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(balanceText,
                                        style: const TextStyle(color: kPink, fontSize: 11, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Icons
                Row(
                  children: [
                    _HeaderIconBtn(icon: Icons.search, onTap: () {}),
                    const SizedBox(width: 10),
                    _HeaderIconBtn(
                      icon: MdiIcons.send,
                      onTap: () => Navigator.pushNamed(context, '/menu'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Body ──
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: bottomPad + 16),
              child: Column(
                children: [
                  // Services Card
                  Container(
                    color: kWhite,
                    padding: const EdgeInsets.only(top: 12, bottom: 4),
                    child: Column(
                      children: [
                        _buildServiceGrid(_mainServices),
                        if (_showMore) _buildServiceGrid(_moreServices),
                        const Divider(height: 1, color: Color(0xFFF0F0F0)),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => setState(() => _showMore = !_showMore),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_showMore ? 'See Less' : 'See More',
                                    style: const TextStyle(color: kPink, fontSize: 13, fontWeight: FontWeight.w500)),
                                const SizedBox(width: 4),
                                Icon(_showMore ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                                    color: kPink, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // NFC Promo
                  Container(
                    margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4, offset: const Offset(0, 1))],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('NFC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPink)),
                              const Text('একটি ট্যাপেই', style: TextStyle(fontSize: 12, color: Color(0xFF555555))),
                              const Text('৳500', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kText)),
                              const Text('ক্যাশব্যাক', style: TextStyle(fontSize: 12, color: Color(0xFF555555))),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPink,
                                  foregroundColor: kWhite,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                                child: const Text('জানুন আরো', style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80, height: 80,
                          decoration: const BoxDecoration(color: kPink, shape: BoxShape.circle),
                          child: Icon(MdiIcons.nfc, color: kWhite, size: 40),
                        ),
                      ],
                    ),
                  ),

                  // Quick Features
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    color: kWhite,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Quick Features',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kText)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _QuickCard(icon: MdiIcons.tagMultipleOutline, label: 'My Offers'),
                            const SizedBox(width: 10),
                            _QuickCard(icon: MdiIcons.ticketPercentOutline, label: 'Coupons'),
                            const SizedBox(width: 10),
                            _QuickCard(icon: MdiIcons.starCircleOutline, label: 'Rewards'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom Nav ──
          Container(
            decoration: const BoxDecoration(
              color: kWhite,
              border: Border(top: BorderSide(color: Color(0xFFE8E8E8))),
            ),
            padding: EdgeInsets.only(top: 8, bottom: bottomPad > 0 ? bottomPad : 8),
            child: Row(
              children: [
                _BottomBtn(icon: MdiIcons.viewGrid),
                _BottomBtn(icon: MdiIcons.circleOutline),
                _BottomBtn(icon: MdiIcons.chevronLeft),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.25),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Icon(icon, color: kWhite, size: 20),
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE8E8E8)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: kPink, size: 20),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF333333))),
          ],
        ),
      ),
    );
  }
}

class _BottomBtn extends StatelessWidget {
  final IconData icon;
  const _BottomBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Icon(icon, color: const Color(0xFF555555), size: 22),
    );
  }
}