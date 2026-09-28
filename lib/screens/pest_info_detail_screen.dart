// lib/screens/pest_info_detail_screen.dart
// ──────────────────────────────────────────
// Full detail view for one entry in the Pest & Disease Library.

import 'package:flutter/material.dart';
import '../models/pest_info.dart';
import '../utils/app_theme.dart';

class PestInfoDetailScreen extends StatelessWidget {
  const PestInfoDetailScreen({super.key, required this.entry});

  final PestInfo entry;

  @override
  Widget build(BuildContext context) {
    final isPest = entry.isPest;
    final accent = isPest ? Colors.brown : Colors.redAccent;

    return Scaffold(
      appBar: AppBar(
        title: Text(entry.name, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accent.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: accent.withValues(alpha: 0.15),
                    child: Icon(
                      isPest ? Icons.bug_report_rounded : Icons.coronavirus_rounded,
                      color: accent,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.localName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(entry.scientificName,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppTheme.textSecondary,
                                fontSize: 13)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isPest ? 'PEST' : 'DISEASE',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _section(
              icon: Icons.info_outline_rounded,
              title: 'Overview',
              body: entry.description,
            ),
            _section(
              icon: Icons.help_outline_rounded,
              title: isPest ? 'How It Spreads' : 'What Causes It',
              body: entry.cause,
            ),
            _section(
              icon: Icons.visibility_outlined,
              title: 'Signs & Symptoms',
              body: entry.symptoms,
            ),
            _section(
              icon: Icons.shield_outlined,
              title: 'Prevention & Safety Measures',
              body: entry.prevention,
              accent: AppTheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required IconData icon,
    required String title,
    required String body,
    Color accent = AppTheme.textPrimary,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: accent),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: accent, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}