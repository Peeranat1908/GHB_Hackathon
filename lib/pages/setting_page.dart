import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  // สร้างตัวแปรสำหรับ Switch states (จะใช้ static เพื่อเก็บสถานะ)
  static bool _notificationsEnabled = true;
  static bool _darkModeEnabled = false;

  // รายการตั้งค่าแบบใหม่
  List<_SettingGroup> get _settingGroups => [
    _SettingGroup(
      title: 'บัญชีผู้ใช้',
      items: [
        _SettingItem(
          icon: Icons.person_outline,
          title: 'ข้อมูลส่วนตัว',
          subtitle: 'แก้ไขโปรไฟล์และข้อมูลติดต่อ',
          color: const Color(0xFF667EEA),
          hasSwitch: false,
        ),
        _SettingItem(
          icon: Icons.security,
          title: 'ความปลอดภัย',
          subtitle: 'รหัสผ่านและการยืนยันตัวตน',
          color: const Color(0xFF10B981),
          hasSwitch: false,
        ),
      ],
    ),
    _SettingGroup(
      title: 'การตั้งค่าแอป',
      items: [
        _SettingItem(
          icon: Icons.notifications_outlined,
          title: 'การแจ้งเตือน',
          subtitle: 'รับการแจ้งเตือนและอัปเดต',
          color: const Color(0xFFFFB800),
          hasSwitch: true,
          switchValue: _notificationsEnabled,
          onSwitchChanged: (value) {
            // อัปเดตค่าและรีโหลดหน้า
            _notificationsEnabled = value;
          },
        ),
        _SettingItem(
          icon: Icons.dark_mode_outlined,
          title: 'โหมดมืด',
          subtitle: 'เปิดใช้งานธีมสีเข้ม',
          color: const Color(0xFF6366F1),
          hasSwitch: true,
          switchValue: _darkModeEnabled,
          onSwitchChanged: (value) {
            // อัปเดตค่าและรีโหลดหน้า
            _darkModeEnabled = value;
          },
        ),
        _SettingItem(
          icon: Icons.language,
          title: 'ภาษา',
          subtitle: 'เปลี่ยนภาษาของแอป',
          color: const Color(0xFFEC4899),
          hasSwitch: false,
        ),
      ],
    ),
    _SettingGroup(
      title: 'การเงิน',
      items: [
        _SettingItem(
          icon: Icons.account_balance_wallet_outlined,
          title: 'การเชื่อมต่อธนาคาร',
          subtitle: 'จัดการบัญชีธนาคารที่เชื่อมต่อ',
          color: const Color(0xFF059669),
          hasSwitch: false,
        ),
        _SettingItem(
          icon: Icons.backup,
          title: 'สำรองข้อมูล',
          subtitle: 'สำรองและกู้คืนข้อมูลการเงิน',
          color: const Color(0xFF7C3AED),
          hasSwitch: false,
        ),
        _SettingItem(
          icon: Icons.download,
          title: 'ส่งออกข้อมูล',
          subtitle: 'ดาวน์โหลดรายงานการเงิน',
          color: const Color(0xFFEF4444),
          hasSwitch: false,
        ),
      ],
    ),
    _SettingGroup(
      title: 'ช่วยเหลือ',
      items: [
        _SettingItem(
          icon: Icons.help_outline,
          title: 'ช่วยเหลือ',
          subtitle: 'คำถามที่พบบ่อยและการสนับสนุน',
          color: const Color(0xFF0EA5E9),
          hasSwitch: false,
        ),
        _SettingItem(
          icon: Icons.star_outline,
          title: 'ให้คะแนนแอป',
          subtitle: 'แบ่งปันความคิดเห็นของคุณ',
          color: const Color(0xFFF59E0B),
          hasSwitch: false,
        ),
        _SettingItem(
          icon: Icons.info_outline,
          title: 'เกี่ยวกับแอป',
          subtitle: 'เวอร์ชัน 1.2.3 - เงื่อนไขการใช้งาน',
          color: const Color(0xFF64748B),
          hasSwitch: false,
        ),
      ],
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildUserProfile(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildSettingGroup(_settingGroups[index], context);
              },
              childCount: _settingGroups.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
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
          'ตั้งค่า',
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

  Widget _buildUserProfile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
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
          Hero(
            tag: 'profile_avatar',
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'สวัสดี, นาย ABC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,

                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'สมาชิกตั้งแต่ มกราคม 2024',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showProfileOptions(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingGroup(_SettingGroup group, BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              group.title,
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
              children: group.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isLast = index == group.items.length - 1;
                
                return _buildSettingTile(item, isLast, context);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(_SettingItem item, bool isLast, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.hasSwitch ? null : () => _handleSettingTap(item, context),
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
              const SizedBox(width: 12),
              if (item.hasSwitch)
                Switch.adaptive(
                  value: item.switchValue ?? false,
                  onChanged: item.onSwitchChanged,
                  activeColor: item.color,
                )
              else
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

  void _handleSettingTap(_SettingItem item, BuildContext context) {
    // HapticFeedback.lightImpact(); // ถอดออกเพื่อไม่ต้อง import
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              item.icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text('เปิดเมนู: ${item.title}'),
          ],
        ),
        backgroundColor: item.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ตัวเลือกโปรไฟล์',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF667EEA)),
              title: const Text('แก้ไขโปรไฟล์'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera, color: Color(0xFF10B981)),
              title: const Text('เปลี่ยนรูปโปรไฟล์'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// โมเดลข้อมูลใหม่
class _SettingGroup {
  final String title;
  final List<_SettingItem> items;

  const _SettingGroup({
    required this.title,
    required this.items,
  });
}

class _SettingItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool hasSwitch;
  final bool? switchValue;
  final Function(bool)? onSwitchChanged;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.hasSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
  });
}