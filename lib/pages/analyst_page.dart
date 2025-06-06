import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'dart:convert'; // For JSON encoding/decoding

class AnalystScreen extends StatefulWidget {
  const AnalystScreen({Key? key}) : super(key: key);

  @override
  State<AnalystScreen> createState() => _AnalystScreenState();
}

class _AnalystScreenState extends State<AnalystScreen>
    with TickerProviderStateMixin {
  File? _uploadedFile;
  bool _isAnalyzing = false;
  bool _showAnalysis = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Dynamic data for analysis
  List<Map<String, dynamic>> _monthlyData = [];
  List<Map<String, dynamic>> _categoryData = [];
  int _creditScore = 0;
  String _financialHealth = 'ไม่มีข้อมูล';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _loadAnalysisResults(); // Load existing results on init
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadAnalysisResults() async {
    final prefs = await SharedPreferences.getInstance();
    final monthlyDataString = prefs.getString('monthlyData');
    final categoryDataString = prefs.getString('categoryData');
    final creditScore = prefs.getInt('creditScore');
    final financialHealth = prefs.getString('financialHealth');

    if (monthlyDataString != null && categoryDataString != null) {
      setState(() {
        _monthlyData = List<Map<String, dynamic>>.from(json.decode(monthlyDataString));
        _categoryData = List<Map<String, dynamic>>.from(json.decode(categoryDataString));
        _creditScore = creditScore ?? 0;
        _financialHealth = financialHealth ?? 'ไม่มีข้อมูล';
        _showAnalysis = true; // Show analysis if data exists
      });
      _animationController.forward();
    }
  }

  Future<void> _saveAnalysisResults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('monthlyData', json.encode(_monthlyData));
    await prefs.setString('categoryData', json.encode(_categoryData));
    await prefs.setInt('creditScore', _creditScore);
    await prefs.setString('financialHealth', _financialHealth);
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'csv', 'xlsx', 'txt'],
      );

      if (result != null) {
        setState(() {
          _uploadedFile = File(result.files.single.path!);
        });
        _startAnalysis();
      }
    } catch (e) {
      _showErrorDialog('เกิดข้อผิดพลาดในการเลือกไฟล์');
    }
  }

  void _startAnalysis() async {
    setState(() {
      _isAnalyzing = true;
      _showAnalysis = false; // Hide previous analysis while analyzing
    });

    // Simulate analysis time
    await Future.delayed(const Duration(seconds: 3));

    // Generate mock dynamic data (replace with actual parsing and analysis)
    _generateMockAnalysisData();
    _calculateCreditScore();

    await _saveAnalysisResults(); // Save the new results

    setState(() {
      _isAnalyzing = false;
      _showAnalysis = true;
    });

    _animationController.forward();
  }

  void _generateMockAnalysisData() {
    // Generate mock monthly data
    _monthlyData = [
      {'month': 'ม.ค.', 'income': 40000 + (DateTime.now().millisecond % 10) * 1000, 'expense': 30000 + (DateTime.now().millisecond % 10) * 500},
      {'month': 'ก.พ.', 'income': 42000 + (DateTime.now().millisecond % 10) * 1000, 'expense': 31000 + (DateTime.now().millisecond % 10) * 500},
      {'month': 'มี.ค.', 'income': 45000 + (DateTime.now().millisecond % 10) * 1000, 'expense': 33000 + (DateTime.now().millisecond % 10) * 500},
      {'month': 'เม.ย.', 'income': 43000 + (DateTime.now().millisecond % 10) * 1000, 'expense': 32000 + (DateTime.now().millisecond % 10) * 500},
      {'month': 'พ.ค.', 'income': 48000 + (DateTime.now().millisecond % 10) * 1000, 'expense': 34000 + (DateTime.now().millisecond % 10) * 500},
      {'month': 'มิ.ย.', 'income': 46000 + (DateTime.now().millisecond % 10) * 1000, 'expense': 33500 + (DateTime.now().millisecond % 10) * 500},
    ];

    // Generate mock category data
    _categoryData = [
      {'category': 'อาหาร', 'amount': 14000 + (DateTime.now().millisecond % 10) * 100, 'color': Colors.red.value},
      {'category': 'ที่อยู่อาศัย', 'amount': 11000 + (DateTime.now().millisecond % 10) * 100, 'color': Colors.blue.value},
      {'category': 'คมนาคม', 'amount': 7500 + (DateTime.now().millisecond % 10) * 100, 'color': Colors.green.value},
      {'category': 'บันเทิง', 'amount': 4500 + (DateTime.now().millisecond % 10) * 100, 'color': Colors.orange.value},
      {'category': 'อื่นๆ', 'amount': 6500 + (DateTime.now().millisecond % 10) * 100, 'color': Colors.purple.value},
    ];
  }

  void _calculateCreditScore() {
    // Simple mock credit score calculation based on income/expense ratio
    final totalIncome = _monthlyData.fold<double>(0, (sum, item) => sum + item['income']);
    final totalExpense = _monthlyData.fold<double>(0, (sum, item) => sum + item['expense']);

    if (totalIncome > 0) {
      final ratio = (totalIncome - totalExpense) / totalIncome;
      _creditScore = (ratio * 100).round() + 50; // Base score + ratio influence
      if (_creditScore < 0) _creditScore = 0;
      if (_creditScore > 100) _creditScore = 1000;

      if (ratio > 0.3) {
        _financialHealth = 'ดีเยี่ยม';
      } else if (ratio > 0.1) {
        _financialHealth = 'ดี';
      } else if (ratio > 0) {
        _financialHealth = 'ปานกลาง';
      } else {
        _financialHealth = 'ต้องปรับปรุง';
      }
    } else {
      _creditScore = 0;
      _financialHealth = 'ไม่มีข้อมูล';
    }
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ข้อผิดพลาด'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Header
            _buildHeader(),
            const SizedBox(height: 32),

            // Upload Section
            _buildUploadSection(),
            const SizedBox(height: 32),

            // Analysis Progress
            if (_isAnalyzing) _buildAnalysisProgress(),

            // Analysis Results
            if (_showAnalysis) _buildAnalysisResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.analytics,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'วิเคราะห์การเงิน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'อัปโหลดไฟล์เพื่อเริ่มการวิเคราะห์',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Upload Area
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: _uploadedFile != null
                    ? const Color(0xFFE8F5E8)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _uploadedFile != null
                      ? const Color(0xFF10B981)
                      : const Color(0xFFE2E8F0),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _uploadedFile != null
                          ? const Color(0xFF10B981).withOpacity(0.1)
                          : const Color(0xFF667EEA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      _uploadedFile != null
                          ? Icons.check_circle
                          : Icons.cloud_upload,
                      size: 48,
                      color: _uploadedFile != null
                          ? const Color(0xFF10B981)
                          : const Color(0xFF667EEA),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _uploadedFile != null
                        ? 'ไฟล์ถูกอัปโหลดแล้ว'
                        : 'แตะเพื่อเลือกไฟล์',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _uploadedFile != null
                          ? const Color(0xFF10B981)
                          : const Color(0xFF334155),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _uploadedFile != null
                        ? _uploadedFile!.path.split('/').last
                        : 'รองรับไฟล์ PDF, CSV, XLSX, TXT',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // File Info
          if (_uploadedFile != null)
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.insert_drive_file,
                    color: Color(0xFF667EEA),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _uploadedFile!.path.split('/').last,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'พร้อมสำหรับการวิเคราะห์',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnalysisProgress() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667EEA)),
          ),
          const SizedBox(height: 20),
          const Text(
            'กำลังวิเคราะห์ข้อมูล...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'โปรดรอสักครู่',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisResults() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          _buildSummaryCards(),
          const SizedBox(height: 24),

          // Monthly Trend
          _buildMonthlyTrend(),
          const SizedBox(height: 24),

          // Category Breakdown
          _buildCategoryBreakdown(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    final totalIncome = _monthlyData.fold<double>(
        0, (sum, item) => sum + item['income']);
    final totalExpense = _monthlyData.fold<double>(
        0, (sum, item) => sum + item['expense']);
    final netSaving = totalIncome - totalExpense;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'รายได้รวม',
            '฿${totalIncome.toStringAsFixed(0)}',
            Icons.trending_up,
            const Color(0xFF10B981),
            const Color(0xFFECFDF5),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'รายจ่ายรวม',
            '฿${totalExpense.toStringAsFixed(0)}',
            Icons.trending_down,
            const Color(0xFFEF4444),
            const Color(0xFFFEF2F2),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'เงินออม',
            '฿${netSaving.toStringAsFixed(0)}',
            Icons.savings,
            const Color(0xFF667EEA),
            const Color(0xFFF0F4FF),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon,
      Color iconColor, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: iconColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              color: iconColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyTrend() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'แนวโน้มรายเดือน',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _monthlyData.length,
              itemBuilder: (context, index) {
                final data = _monthlyData[index];
                final maxValue = _monthlyData.map((e) => e['income'] > e['expense'] ? e['income'] : e['expense']).reduce((a, b) => a > b ? a : b) * 1.2; // Dynamic max value
                final incomeHeight = (data['income'] / maxValue) * 150;
                final expenseHeight = (data['expense'] / maxValue) * 150;

                return Container(
                  width: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 20,
                            height: incomeHeight,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 20,
                            height: expenseHeight,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['month'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('รายได้', const Color(0xFF10B981)),
              const SizedBox(width: 20),
              _buildLegendItem('รายจ่าย', const Color(0xFFEF4444)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBreakdown() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'รายจ่ายตามหมวดหมู่',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 20),
          ..._categoryData.map((category) => _buildCategoryRow(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(Map<String, dynamic> category) {
    final totalExpense = _categoryData.fold<double>(
        0, (sum, item) => sum + item['amount']);
    final percentage = (category['amount'] / totalExpense * 100);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Color(category['color']), // Use Color constructor
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    category['category'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF334155),
                    ),
                  ),
                ],
              ),
              Text(
                '฿${category['amount'].toStringAsFixed(0)} (${percentage.toStringAsFixed(1)}%)',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Color(category['color'])), // Use Color constructor
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}
