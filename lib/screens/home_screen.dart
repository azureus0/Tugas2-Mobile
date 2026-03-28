import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import './login_screen.dart';
import './data_kelompok_screen.dart';
import './aritmatika_screen.dart';
import './bilangan_screen.dart';
import './jumlah_total_screen.dart';
import './stopwatch_screen.dart';
import './piramid_screen.dart';
import './weton_screen.dart';
import './umur_screen.dart';
import './hijriah_screen.dart';

class _MenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final Widget screen;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<_MenuItem> _menus = [
    _MenuItem(
      title: 'Data Kelompok',
      icon: Icons.group_rounded,
      color: AppColors.teal,
      screen: DataKelompokScreen(),
    ),
    _MenuItem(
      title: 'Penjumlahan &\nPengurangan',
      icon: Icons.calculate_rounded,
      color: AppColors.orange,
      screen: AritmatikaScreen(),
    ),
    _MenuItem(
      title: 'Ganjil/Genap\n& Prima',
      icon: Icons.filter_alt_rounded,
      color: AppColors.purple,
      screen: BilanganScreen(),
    ),
    _MenuItem(
      title: 'Jumlah Total\nAngka',
      icon: Icons.functions_rounded,
      color: AppColors.red,
      screen: JumlahTotalScreen(),
    ),
    _MenuItem(
      title: 'Stopwatch',
      icon: Icons.timer_rounded,
      color: AppColors.blue,
      screen: StopwatchScreen(),
    ),
    _MenuItem(
      title: 'Luas & Volume\nPiramid',
      icon: Icons.change_history_rounded,
      color: AppColors.green,
      screen: PiramidScreen(),
    ),
    // ===== MENU BARU =====
    _MenuItem(
      title: 'Konversi\nWeton',
      icon: Icons.auto_stories_rounded,
      color: AppColors.teal,
      screen: WetonScreen(),
    ),
    _MenuItem(
      title: 'Kalkulator\nUmur',
      icon: Icons.cake_rounded,
      color: AppColors.purple,
      screen: UmurScreen(),
    ),
    _MenuItem(
      title: 'Konversi\nHijriah',
      icon: Icons.mosque_rounded,
      color: AppColors.orange,
      screen: HijriahScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 2),
                        Text(
                          'Kelompok 1',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrim,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Logout button
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.surface2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section label
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'MENU UTAMA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                  color: AppColors.textMuted,
                ),
              ),
            ),

            // Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.05,
                ),
                itemCount: _menus.length,
                itemBuilder: (context, i) => _MenuCard(item: _menus[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final _MenuItem item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => item.screen),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surface2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Top accent line
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(height: 2, color: item.color),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    // Icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(item.icon, color: item.color, size: 24),
                    ),
                    const SizedBox(height: 12),
                    // Title
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrim,
                        height: 1.4,
                      ),
                    ),
                    const Spacer(),
                    // Arrow
                    Text(
                      'Buka →',
                      style: TextStyle(
                        fontSize: 11,
                        color: item.color.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
