import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen({Key? key}) : super(key: key);

  Future<void> _setConsent(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasConsent', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 47, 47).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.privacy_tip_outlined,
                  size: 60,
                  color: Color.fromARGB(255, 255, 47, 47),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'ยินดีต้อนรับสู่แอปวิเคราะห์การเงิน',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'เราให้ความสำคัญกับความเป็นส่วนตัวของคุณ โปรดอ่านและยอมรับข้อกำหนดการใช้งานเพื่อใช้บริการของเรา',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => _setConsent(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 47, 47),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: const Color.fromARGB(255, 255, 47, 47).withOpacity(0.4),
                ),
                child: const Text(
                  'ยอมรับและดำเนินการต่อ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Handle privacy policy viewing
                },
                child: const Text(
                  'อ่านนโยบายความเป็นส่วนตัว',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 255, 47, 47),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}