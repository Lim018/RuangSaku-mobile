import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;
  bool _loading = false;

  void _handleLogin() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 48),

              // Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.blue600,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.blue200,
                        blurRadius: 20,
                        offset: const Offset(0, 8)),
                  ],
                ),
                child: const Icon(LucideIcons.logIn,
                    size: 32, color: Colors.white),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scale(begin: const Offset(0.5, 0.5)),

              const SizedBox(height: 24),

              Text(
                'Selamat Datang',
                style: AppTypography.headingBlack.copyWith(fontSize: 28),
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

              const SizedBox(height: 8),

              Text(
                'Masuk dengan akun portal akademik Anda',
                style: TextStyle(
                    color: AppColors.slate400,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ).animate().fadeIn(delay: 300.ms, duration: 500.ms),

              const SizedBox(height: 40),

              // NIM / Email
              _buildLabel('NIM / EMAIL'),
              const SizedBox(height: 4),
              TextField(
                decoration: _inputDecoration('434231022'),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),

              const SizedBox(height: 16),

              // Password
              _buildLabel('KATA SANDI'),
              const SizedBox(height: 4),
              TextField(
                obscureText: _obscure,
                decoration: _inputDecoration('••••••••').copyWith(
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Icon(
                      _obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                      color: AppColors.slate300,
                      size: 20,
                    ),
                  ),
                ),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),

              const SizedBox(height: 24),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _loading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    shadowColor: AppColors.blue200,
                  ),
                  child: Text(
                    _loading ? 'Memproses...' : 'Log Masuk',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 500.ms)
                  .slideY(begin: 0.2),

              const Spacer(),

              Text(
                'Universitas RuangSaku © 2026',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate300,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.slate400,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          TextStyle(color: AppColors.slate300, fontWeight: FontWeight.w600),
      filled: true,
      fillColor: AppColors.slate50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.slate100),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.slate100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: AppColors.blue600.withValues(alpha: 0.3), width: 2),
      ),
    );
  }
}
