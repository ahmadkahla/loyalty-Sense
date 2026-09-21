// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// class AboutUsScreen extends StatelessWidget {
//   const AboutUsScreen({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // ==================================================
//           // LOGO
//           // ==================================================
//           Image.asset(
//             'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
//             width: 200,
//             fit: BoxFit.contain,
//           ),
//
//           const SizedBox(height: 24),
//
//           // ==================================================
//           // TITLE
//           // ==================================================
//           Text(
//             'about_us'.tr(),
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: primaryColor,
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // ==================================================
//           // DESCRIPTION
//           // ==================================================
//           Text(
//             'about_us_description'.tr(),
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 15, height: 1.6),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// class AboutUsScreen extends StatelessWidget {
//   const AboutUsScreen({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // 👈 خلفية الشاشة حسب الثيم (Light/Dark)
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//
//       // 👈 AppBar مع زر رجوع تلقائي
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white
//                 : primaryColor,
//             size: 20,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'about_us'.tr(),
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white
//                 : const Color(0xFF242124),
//           ),
//         ),
//         centerTitle: true,
//       ),
//
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // ==================================================
//             // LOGO
//             // ==================================================
//             Image.asset(
//               'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
//               width: 200,
//               fit: BoxFit.contain,
//             ),
//
//             const SizedBox(height: 24),
//
//             // ==================================================
//             // TITLE
//             // ==================================================
//             Text(
//               'about_us'.tr(),
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: primaryColor,
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // ==================================================
//             // DESCRIPTION
//             // ==================================================
//             Text(
//               'about_us_description'.tr(),
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 15,
//                 height: 1.6,
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? Colors.white70
//                     : Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const Color primaryColor = Color(0xFFA5005A);
  static const Color primaryLight = Color(0xFFCC007A);
  static const Color accentColor = Color(0xFFE6008A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final scale = (size.height / 852).clamp(0.8, 1.1);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F0F15)
          : const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // ==================================================
          // BACKGROUND DECORATIONS
          // ==================================================
          _BackgroundDecorations(isDark: isDark),

          // ==================================================
          // MAIN CONTENT
          // ==================================================
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ==============================================
                // APP BAR
                // ==============================================
                SliverAppBar(
                  pinned: true,
                  backgroundColor: isDark
                      ? const Color(0xFF0F0F15).withOpacity(0.9)
                      : const Color(0xFFF8F9FF).withOpacity(0.9),
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _IconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      isDark: isDark,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  title: Text(
                    'about_us'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18 * scale,
                      letterSpacing: 0.3,
                      color: isDark ? Colors.white : const Color(0xFF242124),
                    ),
                  ),
                  centerTitle: true,
                ),

                // ==============================================
                // CONTENT
                // ==============================================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _LogoCard(isDark: isDark, scale: scale),
                        const SizedBox(height: 28),
                        _CompanyTitle(isDark: isDark, scale: scale),
                        const SizedBox(height: 20),
                        _StatsRow(isDark: isDark),
                        const SizedBox(height: 28),
                        _DescriptionCard(isDark: isDark),
                        const SizedBox(height: 24),
                        _ContactSection(isDark: isDark),
                        const SizedBox(height: 24),
                        _Footer(isDark: isDark),
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

// =================================================================
// BACKGROUND DECORATIONS
// =================================================================

class _BackgroundDecorations extends StatelessWidget {
  final bool isDark;
  const _BackgroundDecorations({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -100,
            child: _GlowCircle(
              size: 320,
              color: isDark ? const Color(0xFF3A1A2E) : const Color(0xFFA5005A),
              opacity: isDark ? 0.55 : 0.08,
            ),
          ),
          Positioned(
            bottom: -150,
            left: -120,
            child: _GlowCircle(
              size: 340,
              color: isDark ? const Color(0xFF2A1525) : const Color(0xFFCC007A),
              opacity: isDark ? 0.5 : 0.06,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const _GlowCircle({
    required this.size,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(opacity),
        ),
      ),
    );
  }
}

// =================================================================
// CUSTOM ICON BUTTON
// =================================================================

class _IconButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;
  const _IconButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark
          ? Colors.white.withOpacity(0.08)
          : Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: isDark ? Colors.white : AboutUsScreen.primaryColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}

// =================================================================
// LOGO CARD
// =================================================================

class _LogoCard extends StatelessWidget {
  final bool isDark;
  final double scale;
  const _LogoCard({required this.isDark, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [Colors.white.withOpacity(0.06), Colors.white.withOpacity(0.02)]
              : [Colors.white, Colors.white.withOpacity(0.7)],
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.white.withOpacity(0.8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AboutUsScreen.primaryColor.withOpacity(isDark ? 0.3 : 0.15),
                  Colors.transparent,
                ],
                stops: const [0.5, 1.0],
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
                width: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// COMPANY TITLE
// =================================================================

class _CompanyTitle extends StatelessWidget {
  final bool isDark;
  final double scale;
  const _CompanyTitle({required this.isDark, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SENSE'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30 * scale,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
            color: AboutUsScreen.primaryColor,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Makeup & More'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14 * scale,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
            color: isDark ? Colors.white60 : const Color(0xFF697087),
          ),
        ),
      ],
    );
  }
}

// =================================================================
// STATS ROW
// =================================================================

class _StatsRow extends StatelessWidget {
  final bool isDark;
  const _StatsRow({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.calendar_today_rounded,
            value: '2009',
            label: 'Established'.tr(),
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.store_rounded,
            value: '11',
            label: 'Branches'.tr(),
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool isDark;
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : AboutUsScreen.primaryColor.withOpacity(0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AboutUsScreen.primaryColor.withOpacity(isDark ? 0.0 : 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AboutUsScreen.primaryColor.withOpacity(0.12),
            ),
            child: Icon(icon, color: AboutUsScreen.primaryColor, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF242124),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: isDark ? Colors.white60 : const Color(0xFF697087),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// DESCRIPTION CARD
// =================================================================

class _DescriptionCard extends StatelessWidget {
  final bool isDark;
  const _DescriptionCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.9),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [
                      AboutUsScreen.primaryColor,
                      AboutUsScreen.accentColor,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Who We Are'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF242124),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            'sense_about_us'.tr(),
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14.5,
              height: 1.75,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white70 : const Color(0xFF3F3F4E),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// CONTACT SECTION
// =================================================================

class _ContactSection extends StatelessWidget {
  final bool isDark;
  const _ContactSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AboutUsScreen.primaryColor.withOpacity(0.15),
                  AboutUsScreen.accentColor.withOpacity(0.08),
                ]
              : [
                  AboutUsScreen.primaryColor.withOpacity(0.08),
                  AboutUsScreen.accentColor.withOpacity(0.04),
                ],
        ),
        border: Border.all(
          color: AboutUsScreen.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [
                      AboutUsScreen.primaryColor,
                      AboutUsScreen.accentColor,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Contact Us'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF242124),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _ContactTile(
            icon: Icons.phone_rounded,
            label: 'Phone'.tr(),
            value: '0799509996',
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _ContactTile(
            icon: Icons.email_rounded,
            label: 'Email'.tr(),
            value: 'e.senseacc@gmail.com',
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _ContactTile(
            icon: Icons.language_rounded,
            label: 'Website'.tr(),
            value: 'sensemakeupjo.com',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: AboutUsScreen.primaryColor.withOpacity(0.15),
          ),
          child: Icon(icon, color: AboutUsScreen.primaryColor, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: isDark ? Colors.white54 : const Color(0xFF8A8FA3),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF242124),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =================================================================
// FOOTER
// =================================================================

class _Footer extends StatelessWidget {
  final bool isDark;
  const _Footer({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 1,
              color: isDark
                  ? Colors.white.withOpacity(0.15)
                  : AboutUsScreen.primaryColor.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.favorite_rounded,
                size: 14,
                color: AboutUsScreen.primaryColor.withOpacity(0.7),
              ),
            ),
            Container(
              width: 30,
              height: 1,
              color: isDark
                  ? Colors.white.withOpacity(0.15)
                  : AboutUsScreen.primaryColor.withOpacity(0.2),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '© 2009 - 2026 SENSE Makeup & More',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: isDark ? Colors.white38 : const Color(0xFF8A8FA3),
          ),
        ),
      ],
    );
  }
}
