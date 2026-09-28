// lib/screens/home_screen.dart
// ─────────────────────────────
// Universal screen: secure snapshot/upload → supports Web & Emulator layouts & Offline Queue.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/analysis_result.dart';
import '../utils/app_theme.dart';
import '../widgets/result_card.dart';
import '../widgets/severity_badge.dart';
import '../widgets/scanning_overlay.dart';
import 'offline_queue_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _api         = ApiService();
  final _picker      = ImagePicker();

  XFile?          _pickedFile;
  AnalysisResult? _result;
  bool            _loading = false;
  String?         _error;

  late AnimationController _pulseController;
  late Animation<double>   _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // ── Secure Camera Capture ──────────────────────────────────────────────────
  Future<void> _pickImage() async {
    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 95,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (xFile == null) return;
      setState(() {
        _pickedFile    = xFile;
        _result        = null;
        _error         = null;
      });
    } catch (e) {
      _showError('Could not access device camera input: $e');
    }
  }


  Future<void> _pickImageFromGallery() async {
    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 95,
      );

      if (xFile == null) return;
      setState(() {
        _pickedFile    = xFile;
        _result        = null;
        _error         = null;
      });
    } catch (e) {
      _showError('Could not access storage explorer: $e');
    }
  }


  Future<void> _saveToOfflineQueue() async {
    if (_pickedFile == null) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> queue = prefs.getStringList('offline_pests_queue') ?? [];

      if (!queue.contains(_pickedFile!.path)) {
        queue.add(_pickedFile!.path);
        await prefs.setStringList('offline_pests_queue', queue);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved to Offline Queue! Upload it when internet is available.'),
            backgroundColor: Colors.orange,
          ),
        );
        _reset();
      }
    } catch (e) {
      _showError('Failed to cache offline capture: $e');
    }
  }


  void _showOfflineOptionDialog(String originalError) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.signal_wifi_off_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('You are Offline'),
          ],
        ),
        content: Text('Maaaring mahina o walang signal sa iyong pwesto.\n\nGusto mo bang i-save muna itong nakatagong larawan sa "Offline Saved Captures" para ma-analyze kapag may internet ka na?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Navigator.pop(context);
              _saveToOfflineQueue();
            },
            child: const Text('Save Offline', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }


  Future<void> _analyzeImage() async {
    if (_pickedFile == null) return;
    setState(() { _loading = true; _error = null; _result = null; });

    try {
      File fileToUpload = File(_pickedFile!.path);
      final result = await _api.analyzeImage(fileToUpload);
      setState(() { _result = result; });
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (e) {
      final errorString = e.toString().toLowerCase();
      _showError('Connection issue: $e');

      if (errorString.contains('socketexception') ||
          errorString.contains('network') ||
          errorString.contains('timeout') ||
          errorString.contains('connection failed')) {
        _showOfflineOptionDialog(e.toString());
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showError(String msg) {
    setState(() => _error = msg);
  }

  void _reset() => setState(() {
    _pickedFile    = null;
    _result        = null;
    _error         = null;
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              height: 28,
              width: 28,
            ),
            const SizedBox(width: 8),
            const Text('Rice Pest Detector', style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_special_rounded),
            tooltip: 'Offline Captures',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OfflineQueueScreen()),
              );
            },
          ),
          if (_pickedFile != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Reset Tracker',
              onPressed: _reset,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Image preview ──────────────────────────────────────────────
            _buildImageSection(),
            const SizedBox(height: 20),

            // ── Error Message Display ──────────────────────────────────────
            if (_error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
            ],


            if (_pickedFile == null) ...[
              Column(

                crossAxisAlignment: CrossAxisAlignment.stretch, //
                children: [
                  _sourceButton(
                    icon:    Icons.photo_camera_rounded,
                    label:   kIsWeb ? 'Start Desktop Webcam' : 'Capture Your Rice Field ',
                    onTap:   _pickImage,
                    primary: true,
                  ),
                  const SizedBox(height: 12),

                  OutlinedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo_library_rounded, color: AppTheme.primary),
                    label: const Text('Add Image from Gallery', style: TextStyle(color: AppTheme.primary)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppTheme.primary, width: 1.5),
                    ),
                  ),
                ],
              ),
            ],


            if (_pickedFile != null && _result == null && !_loading) ...[
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _analyzeImage,
                icon:  const Icon(Icons.analytics_rounded),
                label: const Text('Analyze Image'),
              ),
            ],

            // ── Loading caption ────────────────────────────────────────────
            // The scan animation itself now lives on top of the image in
            // _buildImageSection(); this just adds a short status caption.
            if (_loading) ...[
              const SizedBox(height: 12),
              const Center(
                child: Text('Running model inference…',
                    style: TextStyle(color: AppTheme.textSecondary)),
              ),
            ],

            // ── Result card ────────────────────────────────────────────────
            if (_result != null) ...[
              const SizedBox(height: 20),
              ResultCard(result: _result!),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _reset,
                icon:  const Icon(Icons.add_a_photo_outlined),
                label: const Text('Scan Another Crop'),
                style: OutlinedButton.styleFrom(foregroundColor: AppTheme.primary),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    if (_pickedFile == null) {
      return _emptyImagePlaceholder();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          kIsWeb
              ? Image.network(
            _pickedFile!.path,
            width: double.infinity,
            height: 280,
            fit: BoxFit.cover,
          )
              : Image.file(
            File(_pickedFile!.path),
            width: double.infinity,
            height: 280,
            fit: BoxFit.cover,
          ),

          // ── Scanning animation while analysis is running ────────────────
          if (_loading)
            const Positioned.fill(
              child: ScanningOverlay(),
            ),

          if (_result != null)
            Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(8),
              child: SeverityBadge(severity: _result!.severity),
            ),
        ],
      ),
    );
  }

  Widget _emptyImagePlaceholder() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (_, child) => Transform.scale(
        scale: _pulseAnimation.value,
        child: child,
      ),
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          color: AppTheme.primaryLight.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.primaryLight.withOpacity(0.3), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo_full.png',
              height: 140,
            ),
            const SizedBox(height: 12),
            const Text('Camera Viewfinder Ready',
                style: TextStyle(fontSize: 16, color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text('Capture a real-time photo of a rice leaf field',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _sourceButton({
    required IconData icon,
    required String   label,
    required VoidCallback onTap,
    bool primary = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon:  Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 2,
      ),
    );
  }
}