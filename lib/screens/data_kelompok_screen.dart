import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class _Anggota {
  final String nama;
  final String nim;
  const _Anggota({required this.nama, required this.nim});
}

class DataKelompokScreen extends StatelessWidget {
  const DataKelompokScreen({super.key});

  static const List<_Anggota> _anggota = [
    _Anggota(nama: 'Akfina Ni\'mawati', nim: '123230076'),
    _Anggota(nama: 'Gorbi Ello Pasaribu', nim: '123230083'),
    _Anggota(nama: 'Adi Dwi Pambudi', nim: '123230170'),
    _Anggota(nama: 'Yediya Elshama Santosa', nim: '123230174'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bg,
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Info kelompok card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.surface2),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.group_rounded,
                    color: AppColors.teal,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kelompok 1',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrim,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Teknologi & Pemrograman Mobile',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'ANGGOTA KELOMPOK',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 10),
          ..._anggota.asMap().entries.map(
            (e) => _AnggotaCard(index: e.key, anggota: e.value),
          ),
        ],
      ),
    );
  }
}

class _AnggotaCard extends StatelessWidget {
  final int index;
  final _Anggota anggota;
  const _AnggotaCard({required this.index, required this.anggota});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surface2),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.teal.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: AppColors.teal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anggota.nama,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrim,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'NIM: ${anggota.nim}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) => AppBar(
  //elevation: 0,
  title: const Text(
    'Data Kelompok',
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
  ),
  leading: GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
    ),
  ),
);
