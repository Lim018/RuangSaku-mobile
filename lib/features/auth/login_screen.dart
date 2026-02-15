import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/press_effect.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Shield icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  LucideIcons.shieldCheck,
                  color: AppColors.slate900,
                  size: 24,
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack),

              const SizedBox(height: 24),

              // Heading
              Text(
                'Ekses Penuh\nRuangSaku.',
                style: AppTypography.headingBlack.copyWith(fontSize: 36),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 150.ms)
                  .slideX(begin: -0.1, curve: Curves.easeOutCubic),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Kelola pemesanan ruangan Anda dengan mudah dan aman.',
                style: AppTypography.bodyLG,
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 300.ms)
                  .slideX(begin: -0.1, curve: Curves.easeOutCubic),

              const SizedBox(height: 48),

              // SSO Input
              _buildInputField(
                label: 'SINGLE SIGN ON',
                placeholder: 'nim@student.univ.ac.id',
                controller: _emailController,
                delay: 400,
              ),

              const SizedBox(height: 20),

              // Password input
              _buildPasswordField(delay: 500),

              const SizedBox(height: 28),

              // Login button
              PressEffect(
                onTap: () => context.go('/home'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.slate900,
                    borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.slateShadow,
                        blurRadius: 32,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Masuk Sekarang', style: AppTypography.buttonLG),
                      const SizedBox(width: 12),
                      const Icon(LucideIcons.arrowRight, color: AppColors.white, size: 20),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 650.ms)
                  .slideY(begin: 0.3, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required int delay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(label, style: AppTypography.labelUppercase),
        ),
        TextField(
          controller: controller,
          style: AppTypography.bodySM,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: AppTypography.bodySM.copyWith(color: AppColors.slate300),
            filled: true,
            fillColor: AppColors.slate50,
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              borderSide: BorderSide(color: AppColors.slate100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              borderSide: BorderSide(color: AppColors.slate100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              borderSide: BorderSide(color: AppColors.primaryYellow, width: 2),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: Duration(milliseconds: delay))
        .slideY(begin: 0.2, curve: Curves.easeOutCubic);
  }

  Widget _buildPasswordField({required int delay}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text('PASSWORD', style: AppTypography.labelUppercase),
        ),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: AppTypography.bodySM,
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: AppTypography.bodySM.copyWith(color: AppColors.slate300),
            filled: true,
            fillColor: AppColors.slate50,
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscurePassword = !_obscurePassword),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                  color: AppColors.slate300,
                  size: 20,
                ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              borderSide: BorderSide(color: AppColors.slate100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              borderSide: BorderSide(color: AppColors.slate100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              borderSide: BorderSide(color: AppColors.primaryYellow, width: 2),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: Duration(milliseconds: delay))
        .slideY(begin: 0.2, curve: Curves.easeOutCubic);
  }
}
