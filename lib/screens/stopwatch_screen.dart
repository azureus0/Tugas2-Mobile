import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Timer? _timer;
  int _ms = 0;
  bool _running = false;
  final List<String> _laps = [];

  String get _time {
    final ms = _ms % 100;
    final sec = (_ms ~/ 100) % 60;
    final min = _ms ~/ 6000;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() => _ms++);
    });
    setState(() => _running = true);
  }

  void _stop() {
    _timer?.cancel();
    setState(() => _running = false);
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _ms = 0;
      _running = false;
      _laps.clear();
    });
  }

  void _lap() =>
      setState(() => _laps.insert(0, 'Lap ${_laps.length + 1}   $_time'));

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bg,
      appBar: AppBar(
        //backgroundColor: AppColors.blue.withOpacity(0.1),
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Stopwatch',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Clock circle
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(
                    color: _running ? AppColors.blue : AppColors.surface2,
                    width: 3,
                  ),
                  boxShadow: _running
                      ? [
                          BoxShadow(
                            color: AppColors.blue.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 4,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    _time,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrim,
                      fontFamily: 'monospace',
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_running)
                  _CtrlBtn(
                    label: 'Start',
                    icon: Icons.play_arrow_rounded,
                    color: AppColors.green,
                    onTap: _start,
                  )
                else
                  _CtrlBtn(
                    label: 'Stop',
                    icon: Icons.pause_rounded,
                    color: AppColors.orange,
                    onTap: _stop,
                  ),
                const SizedBox(width: 12),
                _CtrlBtn(
                  label: 'Lap',
                  icon: Icons.flag_rounded,
                  color: AppColors.blue,
                  onTap: _running ? _lap : null,
                ),
                const SizedBox(width: 12),
                _CtrlBtn(
                  label: 'Reset',
                  icon: Icons.refresh_rounded,
                  color: AppColors.red,
                  onTap: _reset,
                ),
              ],
            ),
            const SizedBox(height: 24),

            if (_laps.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'LAP TIMES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _laps.length,
                  itemBuilder: (context, i) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.surface2),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_rounded,
                          color: AppColors.blue.withOpacity(0.7),
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _laps[i],
                          style: const TextStyle(
                            color: AppColors.textPrim,
                            fontSize: 13,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CtrlBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _CtrlBtn({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: active ? 1.0 : 0.35,
        child: Container(
          width: 80,
          height: 64,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
