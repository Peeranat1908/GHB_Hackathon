// lib/pages/product_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <<< Import SharedPreferences
import 'home_page.dart';
import 'consent_screen.dart'; // <<< Import ConsentScreen

class ProductScreen extends StatefulWidget { // Changed to StatefulWidget
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> { // State class for ProductScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildWelcomeCard(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // NEW PRODUCT GROUP FOR PROMPT KUU
                _buildProductGroup(
                  context,
                  title: 'บริการของ PromptKuu',
                  products: [
                    _ProductItem(
                      icon: Icons.track_changes,
                      title: 'PromptKuu: วิเคราะห์การเงินของคุณ',
                      subtitle: 'เข้าถึงเครื่องมือวิเคราะห์และจัดการการเงินส่วนบุคคล',
                      color: const Color(0xFF9C27B0),
                      isPromptKuu: true,
                    ),
                  ],
                ),
                // END NEW PRODUCT GROUP
                _buildProductGroup(
                  context,
                  title: 'เงินฝาก',
                  products: [
                    _ProductItem(
                      icon: Icons.savings_outlined,
                      title: 'ออมทรัพย์ดิจิทัล',
                      subtitle: 'ดอกเบี้ยสูง เปิดง่ายผ่านแอป',
                      color: const Color(0xFF4CAF50),
                    ),
                    _ProductItem(
                      icon: Icons.wallet_outlined,
                      title: 'ฝากประจำพิเศษ',
                      subtitle: 'รับดอกเบี้ยทันทีเมื่อฝาก',
                      color: const Color(0xFF2196F3),
                    ),
                  ],
                ),
                _buildProductGroup(
                  context,
                  title: 'สินเชื่อบ้าน',
                  products: [
                    _ProductItem(
                      icon: Icons.home_work_outlined,
                      title: 'สินเชื่อบ้านใหม่',
                      subtitle: 'กู้ซื้อบ้านใหม่ ดอกเบี้ยพิเศษ',
                      color: const Color(0xFFFF9800),
                    ),
                    _ProductItem(
                      icon: Icons.house_siding_outlined,
                      title: 'รีไฟแนนซ์บ้าน',
                      subtitle: 'ลดภาระดอกเบี้ย ยืดเวลาผ่อนชำระ',
                      color: const Color(0xFFE91E63),
                    ),
                  ],
                ),
                _buildProductGroup(
                  context,
                  title: 'ประกัน',
                  products: [
                    _ProductItem(
                      icon: Icons.health_and_safety_outlined,
                      title: 'ประกันชีวิตและสุขภาพ',
                      subtitle: 'คุ้มครองคุณและครอบครัว',
                      color: const Color(0xFF673AB7),
                    ),
                    _ProductItem(
                      icon: Icons.directions_car_outlined,
                      title: 'ประกันภัยรถยนต์',
                      subtitle: 'คุ้มครองครบวงจรทุกประเภทรถ',
                      color: const Color(0xFF795548),
                    ),
                  ],
                ),
                _buildProductGroup(
                  context,
                  title: 'บริการอื่นๆ',
                  products: [
                    _ProductItem(
                      icon: Icons.credit_card_outlined,
                      title: 'บัตรเครดิต',
                      subtitle: 'สมัครบัตรเครดิตพร้อมสิทธิพิเศษ',
                      color: const Color(0xFF607D8B),
                    ),
                    _ProductItem(
                      icon: Icons.qr_code_scanner_outlined,
                      title: 'สแกนจ่าย QR',
                      subtitle: 'จ่ายง่าย สบายกระเป๋า',
                      color: const Color(0xFF00BCD4),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'ผลิตภัณฑ์ธนาคาร',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Color(0xFF1E293B),
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2196F3).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stars, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              const Text(
                'พิเศษสำหรับคุณ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'ค้นพบผลิตภัณฑ์ทางการเงินที่เหมาะกับคุณโดยเฉพาะ เพื่ออนาคตที่มั่นคงยิ่งขึ้น',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('กำลังดูข้อเสนอพิเศษ!'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            icon: const Icon(Icons.flash_on, size: 20),
            label: const Text('ดูข้อเสนอพิเศษ'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF2196F3),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGroup(BuildContext context, {required String title, required List<_ProductItem> products}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: products.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isLast = index == products.length - 1;

                return _buildProductTile(item, isLast, context);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTile(_ProductItem item, bool isLast, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async { // Changed to async
          if (item.isPromptKuu) {
            final prefs = await SharedPreferences.getInstance();
            final hasConsent = prefs.getBool('hasConsent') ?? false;

            if (hasConsent) {
              // If user has consented, go to HomePage (main app flow)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else {
              // If user has NOT consented, go to ConsentScreen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ConsentScreen()),
              );
            }
          } else {
            // For other products, show a snackbar or navigate to a product detail page
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('เปิดหน้า: ${item.title}'),
                backgroundColor: item.color,
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: !isLast
                ? Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.1),
                      width: 1,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isPromptKuu;

  const _ProductItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.isPromptKuu = false,
  });
}
