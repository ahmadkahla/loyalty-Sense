import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const Color primaryColor = Color(0xFFA5005A);
  static const Color accentColor = Color(0xFFE6008A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F0F15)
          : const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // ===== BACKGROUND GLOW =====
          Positioned(
            top: -120,
            right: -100,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDark ? const Color(0xFF3A1A2E) : primaryColor)
                      .withOpacity(isDark ? 0.55 : 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -120,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      (isDark
                              ? const Color(0xFF2A1525)
                              : const Color(0xFFCC007A))
                          .withOpacity(isDark ? 0.5 : 0.06),
                ),
              ),
            ),
          ),

          // ===== MAIN CONTENT =====
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ===== APP BAR =====
                SliverAppBar(
                  pinned: true,
                  backgroundColor: isDark
                      ? const Color(0xFF0F0F15).withOpacity(0.9)
                      : const Color(0xFFF8F9FF).withOpacity(0.9),
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: isDark
                          ? Colors.white.withOpacity(0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 42,
                          height: 42,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'terms_conditions'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: isDark ? Colors.white : const Color(0xFF242124),
                    ),
                  ),
                  centerTitle: true,
                ),

                // ===== BODY =====
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ============ LOGO CARD ============
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: isDark
                                  ? Colors.white.withOpacity(0.06)
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    isDark ? 0.3 : 0.05,
                                  ),
                                  blurRadius: 30,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    primaryColor.withOpacity(0.15),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.5, 1.0],
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
                                  width: 110,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ============ COMPANY NAME ============
                        const Text(
                          'SENSE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 6,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Makeup & More',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2.5,
                            color: isDark
                                ? Colors.white60
                                : const Color(0xFF697087),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ==================================================
                        // ============ 1. استخدام التطبيق ==================
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_1_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_1_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 2. إنشاء الحساب ====================
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_2_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_2_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 3. برنامج الولاء والنقاط ===========
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_3_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),

                              // السطر 1
                              Text(
                                'terms_3_p1'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // السطر 2
                              Text(
                                'terms_3_p2'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // السطر 3
                              Text(
                                'terms_3_p3'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // السطر 4
                              Text(
                                'terms_3_p4'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // السطر 5
                              Text(
                                'terms_3_p5'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 4. الخصومات والمكافآت ==============
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_4_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_4_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 5. الموقع ==========================
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_5_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_5_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 6. الإشعارات =======================
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '6',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_6_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_6_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 7. مسؤولية الحساب ==================
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '7',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_7_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_7_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 8. تعديل البرنامج والشروط ==========
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '8',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_8_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_8_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ==================================================
                        // ============ 9. التواصل =========================
                        // ==================================================
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.2 : 0.04,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [primaryColor, accentColor],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '9',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'terms_9_title'.tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF242124),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'terms_9_body'.tr(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.8,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF3F3F4E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
