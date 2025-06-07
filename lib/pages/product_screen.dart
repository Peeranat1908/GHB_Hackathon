import 'package:flutter/material.dart';
import 'package:ghb_app/pages/consent_screen.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductScreen> {
  int _selectedIndex = 2; // For the bottom navigation bar, home is typically central

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for the bank logo
            Icon(Icons.home_work, color: Colors.deepOrange.shade700, size: 28),
            const SizedBox(width: 8),
            Text(
              'GHB BANK',
              style: TextStyle(
                color: Colors.deepOrange.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.grey),
            onPressed: () {
              // Handle exit/logout
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Info Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'สวัสดี\nคุณ น้ำใส',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.blueAccent, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              'พอยท์ 0',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Quick Action Icons
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Important to disable inner scrolling
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      _buildQuickActionButton(
                          Icons.swap_horiz, 'โอนเงิน', Colors.deepOrange),
                      _buildQuickActionButton(
                          Icons.currency_bitcoin, 'เติมเงิน', Colors.orange),
                      _buildQuickActionButton(
                          Icons.account_balance_wallet, 'ชำระเงินกู้', Colors.orange),
                      _buildQuickActionButton(
                          Icons.qr_code_scanner, 'สแกน', Colors.orange),
                      _buildQuickActionButton(
                          Icons.emoji_events, 'ตรวจรางวัล', Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Spacer between sections
            // Product Section
            _buildSectionHeader('ผลิตภัณฑ์'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              color: Colors.white,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildProductButton(
                      Icons.credit_score, 'PromptKuu', Colors.blue,(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConsentScreen()));
                      }),
                  _buildProductButton(
                      Icons.account_box, 'เปิดบัญชี', Colors.deepOrange,(){}),
                  _buildProductButton(
                      Icons.loyalty, 'ซื้อสลาก', Colors.orange,(){}),
                  _buildProductButton(
                      Icons.money, 'ขอสินเชื่อ', Colors.orange,(){}),
                  _buildProductButton(
                      Icons.home_work_outlined, 'ทรัพย์ NPA', Colors.orange,(){}),
                ],
              ),
            ),
            const SizedBox(height: 16), // Spacer between sections
            // Document Section
            _buildSectionHeader('ขอหนังสือ / เอกสาร'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              color: Colors.white,
              child: Column(
                children: [
                  _buildDocumentButton(
                      Icons.description, 'ขอ e-Statement', Colors.deepOrange),
                ],
              ),
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'บริการ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'บัญชี',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.home, color: Colors.white, size: 30),
            ),
            label: '', // No label for the central home button
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'แจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ตั้งค่า',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // To show all labels
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label, Color iconColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: iconColor.withOpacity(0.3)),
          ),
          child: Icon(icon, color: iconColor, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProductButton(IconData icon, String label, Color iconColor, VoidCallback onTap) {
  return GestureDetector( // ใช้ GestureDetector เพื่อตรวจจับการแตะ
    onTap: onTap, // กำหนดฟังก์ชัน onTap ที่รับเข้ามา
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: iconColor.withOpacity(0.3)),
          ),
          child: Icon(icon, color: iconColor, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

  Widget _buildDocumentButton(IconData icon, String label, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: iconColor.withOpacity(0.3)),
          ),
          child: Icon(icon, color: iconColor, size: 30),
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 18),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.grey.shade100, // Light grey background for section titles
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
