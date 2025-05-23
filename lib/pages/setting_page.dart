import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  // รายการตั้งค่าตัวอย่าง
  final List<_SettingItem> _settings = const [
    _SettingItem(
      icon: Icons.person,
      title: 'ข้อมูลส่วนตัว',
      subtitle: 'แก้ไขข้อมูลผู้ใช้',
    ),
    _SettingItem(
      icon: Icons.notifications,
      title: 'การแจ้งเตือน',
      subtitle: 'ตั้งค่าการแจ้งเตือน',
    ),
    _SettingItem(
      icon: Icons.lock,
      title: 'ความเป็นส่วนตัว',
      subtitle: 'จัดการความเป็นส่วนตัว',
    ),
    _SettingItem(
      icon: Icons.palette,
      title: 'ธีมสี',
      subtitle: 'เปลี่ยนธีมแอป',
    ),
    _SettingItem(
      icon: Icons.info,
      title: 'เกี่ยวกับแอป',
      subtitle: 'เวอร์ชันและข้อมูลเพิ่มเติม',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE74C3C),
        title: const Text(
          'ตั้งค่า',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: _settings.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
        itemBuilder: (context, index) {
          final item = _settings[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFE74C3C).withOpacity(0.1),
              child: Icon(item.icon, color: const Color(0xFFE74C3C)),
            ),
            title: Text(
              item.title,
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              item.subtitle,
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            onTap: () {
              // TODO: เพิ่มฟังก์ชันเมื่อแตะรายการตั้งค่า
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('เปิดเมนู: ${item.title}')),
              );
            },
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: Colors.white,
            dense: false,
          );
        },
      ),
    );
  }
}

// โมเดลข้อมูลรายการตั้งค่า
class _SettingItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
