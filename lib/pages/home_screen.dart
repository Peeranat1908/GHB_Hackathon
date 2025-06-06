// lib/pages/home_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'product_screen.dart'; // <<< Can remove this import if the button is removed

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _creditScore = 0; // This is currently out of 100
  String _financialHealth = 'ไม่มีข้อมูล';
  List<Map<String, dynamic>> _monthlyData = [];
  List<Map<String, dynamic>> _categoryData = [];

  @override
  void initState() {
    super.initState();
    _loadAnalysisResults();
  }

  Future<void> _loadAnalysisResults() async {
    final prefs = await SharedPreferences.getInstance();
    final monthlyDataString = prefs.getString('monthlyData');
    final categoryDataString = prefs.getString('categoryData');
    final creditScore = prefs.getInt('creditScore');
    final financialHealth = prefs.getString('financialHealth');

    setState(() {
      _monthlyData = monthlyDataString != null
          ? List<Map<String, dynamic>>.from(json.decode(monthlyDataString))
          : [];
      _categoryData = categoryDataString != null
          ? List<Map<String, dynamic>>.from(json.decode(categoryDataString))
          : [];
      _creditScore = creditScore ?? 0;
      _financialHealth = financialHealth ?? 'ไม่มีข้อมูล';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine credit score stars
    int starCount = 0;
    // Adjusted thresholds for stars based on _creditScore (which is currently /100)
    if (_creditScore >= 80) { // Equivalent to 800/1000
      starCount = 5;
    } else if (_creditScore >= 60) { // Equivalent to 600/1000
      starCount = 4;
    } else if (_creditScore >= 40) { // Equivalent to 400/1000
      starCount = 3;
    } else if (_creditScore >= 20) { // Equivalent to 200/1000
      starCount = 2;
    } else if (_creditScore > 0) { // Equivalent to >0/1000
      starCount = 1;
    }

    // Calculate income, expense, and risk percentages for summary
    double incomePercentage = 0;
    double expensePercentage = 0;
    double riskPercentage = 0;

    if (_monthlyData.isNotEmpty) {
      final totalIncome = _monthlyData.fold<double>(0, (sum, item) => sum + item['income']);
      final totalExpense = _monthlyData.fold<double>(0, (sum, item) => sum + item['expense']);

      if (totalIncome > 0) {
        incomePercentage = ((totalIncome - totalExpense) / totalIncome) * 100;
        if (incomePercentage < 0) incomePercentage = 0; // Cap at 0
        if (incomePercentage > 100) incomePercentage = 100; // Cap at 100
      }
      if (totalExpense > 0) {
        expensePercentage = (totalExpense / totalIncome) * 100; // Ratio of expense to income
        if (expensePercentage < 0) expensePercentage = 0;
        if (expensePercentage > 100) expensePercentage = 100;
      }

      // Simple risk calculation: higher expense ratio means higher risk
      riskPercentage = expensePercentage * 0.5; // Example: 50% of expense ratio
      if (riskPercentage < 0) riskPercentage = 0;
      if (riskPercentage > 100) riskPercentage = 100;
    }


    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8F5E8),
            Color(0xFFF0F8F0),
            Colors.white,
          ],
        ),
      ),
      child: RefreshIndicator( // Add RefreshIndicator
        onRefresh: _loadAnalysisResults,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
          child: Column(
            children: [
              // Enhanced date indicator at top
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_month, color: Color(0xFF4CAF50), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'วันศุกร์ที่ ${DateTime.now().day} ${
                                  [
                                    'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน',
                                    'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม',
                                    'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'
                                  ][DateTime.now().month - 1]
                                } ${DateTime.now().year + 543}', // Buddhist year
                            style: const TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC107).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${DateTime.now().day}',
                          style: const TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Top section with enhanced yellow card
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.wb_sunny, color: Color(0xFFFFC107), size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'ล่าสุดวันนี้',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFC107), Color(0xFFFFD54F)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC107).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.health_and_safety, color: Color(0xFF4CAF50), size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  'สุขภาพการเงินของคุณ: $_financialHealth',
                                  style: const TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.psychology, color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _monthlyData.isEmpty
                                        ? 'ไม่มีข้อมูลการวิเคราะห์ โปรดอัปโหลดไฟล์'
                                        : 'AI วิเคราะห์ด้วยระบบการจัดการ ${_monthlyData.length * 2} รายการ (${_monthlyData.length} เดือน)',
                                    style: const TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.score, color: Color(0xFF2196F3), size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'เครดิตของคุณ',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  // Change this line to display /1000
                                  '${_creditScore * 10}/1000', // Multiply by 10 for 1000 scale
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // Adjust color thresholds for 1000 scale if needed
                                    color: (_creditScore * 10 >= 700) ? const Color(0xFF4CAF50) : ((_creditScore * 10 >= 400) ? Colors.orange : Colors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Row(
                                children: [
                                  for (int i = 0; i < starCount; i++)
                                    Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      child: const Icon(
                                        Icons.star,
                                        color: Color(0xFFFF9800),
                                        size: 24,
                                      ),
                                    ),
                                  for (int i = starCount; i < 5; i++)
                                    Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.star_border,
                                        color: Colors.grey[400],
                                        size: 24,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Enhanced summary section
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[700]!, Colors.grey[800]!],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.summarize, color: Color(0xFF9C27B0), size: 16),
                          SizedBox(width: 8),
                          Text(
                            'สรุปการประเมิน',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSummaryItem(
                      'รายได้: ${incomePercentage.toStringAsFixed(0)}%',
                      Icons.check_circle,
                      incomePercentage >= 50 ? Colors.green : (incomePercentage >= 20 ? Colors.orange : Colors.red),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryItem(
                      'รายจ่าย: ${expensePercentage.toStringAsFixed(0)}%',
                      Icons.warning,
                      expensePercentage <= 40 ? Colors.green : (expensePercentage <= 70 ? Colors.orange : Colors.red),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryItem(
                      'ความเสี่ยง: ${riskPercentage.toStringAsFixed(0)}%',
                      Icons.info,
                      riskPercentage <= 20 ? Colors.green : (riskPercentage <= 50 ? Colors.orange : Colors.red),
                    ),
                    // <<< REMOVED the "ดูผลิตภัณฑ์ทางการเงิน (GHB ALL GEN)" button here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String text, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
