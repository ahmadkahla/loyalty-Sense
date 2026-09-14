import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'login/loginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  // ============================================================
  // ONBOARDING PAGES
  // ============================================================

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      image: 'assets/onboarding/onboarding_1.png',
      title: 'Discover Your Favorites',
      description:
          'Explore a beautiful selection of beauty products, accessories and more, all in one place.',
    ),
    _OnboardingData(
      image: 'assets/onboarding/onboarding_2.png',
      title: 'Your Loyalty Matters',
      description:
          'Earn points with every purchase and get closer to exclusive rewards and special benefits.',
    ),
    _OnboardingData(
      image: 'assets/onboarding/onboarding_3.png',
      title: 'How It Works',
      description:
          'Shop, collect points and turn them into rewards, gifts and special offers you will love.',
    ),
  ];

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ============================================================
  // NEXT
  // ============================================================

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  // ============================================================
  // SKIP
  // ============================================================

  void _skip() {
    _finishOnboarding();
  }

  // ============================================================
  // FINISH
  // ============================================================

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const LoginScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FC),

      body: Stack(
        fit: StackFit.expand,
        children: [
          // ======================================================
          // PREMIUM BACKGROUND
          // ======================================================
          const _OnboardingBackground(),

          // ======================================================
          // LARGE SENSE LOGO IN BACKGROUND
          // ======================================================
          Positioned(
            top: -50,
            left: -40,
            right: -40,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.055,
                child: Image.asset(
                  'assets/logo.png',
                  height: 350,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // ======================================================
          // MAIN CONTENT
          // ======================================================
          SafeArea(
            child: Column(
              children: [
                // ==================================================
                // TOP BAR
                // ==================================================
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ------------------------------------------------
                      // SENSE
                      // ------------------------------------------------
                      Text(
                        'SENSE'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.5,
                          color: Color(0xFF303552),
                        ),
                      ),

                      // ------------------------------------------------
                      // SKIP
                      // ------------------------------------------------
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: _currentPage == _pages.length - 1 ? 0 : 1,
                        child: IgnorePointer(
                          ignoring: _currentPage == _pages.length - 1,
                          child: TextButton(
                            onPressed: _skip,
                            child: Text(
                              'Skip'.tr(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF697087),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ==================================================
                // PAGES
                // ==================================================
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildPage(_pages[index]);
                    },
                  ),
                ),

                // ==================================================
                // BOTTOM CONTROLS
                // ==================================================
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    children: [
                      // ==================================================
                      // PAGE INDICATORS
                      // ==================================================
                      Row(
                        children: List.generate(_pages.length, (index) {
                          final bool active = index == _currentPage;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,

                            width: active ? 26 : 7,

                            height: 7,

                            margin: const EdgeInsets.only(right: 6),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                              color: active
                                  ? const Color(0xFF990056)
                                  : const Color(0xFFD1D5E4),
                            ),
                          );
                        }),
                      ),

                      const Spacer(),

                      // ==================================================
                      // NEXT BUTTON
                      // ==================================================
                      Container(
                        height: 54,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),

                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF990056).withOpacity(0.20),

                              blurRadius: 20,

                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: ElevatedButton(
                          onPressed: _nextPage,

                          style: ElevatedButton.styleFrom(
                            elevation: 0,

                            backgroundColor: const Color(0xFF990056),

                            foregroundColor: Colors.white,

                            padding: const EdgeInsets.symmetric(horizontal: 21),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _currentPage == _pages.length - 1
                                    ? 'Get_Started'.tr()
                                    : 'Next'.tr(),

                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(width: 8),

                              const Icon(Icons.arrow_forward_rounded, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SINGLE ONBOARDING PAGE
  // ============================================================

  Widget _buildPage(_OnboardingData data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double imageHeight = constraints.maxHeight * 0.50;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            children: [
              const Spacer(),

              // ==================================================
              // IMAGE CARD
              // ==================================================
              Container(
                height: imageHeight.clamp(270.0, 420.0),

                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),

                  color: Colors.white.withOpacity(0.30),

                  border: Border.all(
                    color: Colors.white.withOpacity(0.75),
                    width: 1.2,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.045),

                      blurRadius: 35,

                      offset: const Offset(0, 18),
                    ),
                  ],
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34),

                  child: Image.asset(
                    data.image,

                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 55,
                          color: Color(0xFF8C92A6),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ==================================================
              // TITLE
              // ==================================================
              Text(
                data.title,

                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                  color: Color(0xFF171A2D),
                ),
              ),

              const SizedBox(height: 11),

              // ==================================================
              // DESCRIPTION
              // ==================================================
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 365),

                child: Text(
                  data.description,

                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 14.5,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF697087),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}

// =================================================================
// ONBOARDING DATA
// =================================================================

class _OnboardingData {
  final String image;
  final String title;
  final String description;

  const _OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}

// =================================================================
// PREMIUM BACKGROUND
// =================================================================

class _OnboardingBackground extends StatelessWidget {
  const _OnboardingBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [Color(0xFFF8F9FF), Color(0xFFF0F2FB), Color(0xFFF6FAF9)],
        ),
      ),

      child: Stack(
        children: [
          // ======================================================
          // TOP RIGHT GLOW
          // ======================================================
          Positioned(
            top: -140,
            right: -120,

            child: _GlowCircle(size: 360, color: const Color(0xFFD0D5FF)),
          ),

          // ======================================================
          // LEFT GLOW
          // ======================================================
          Positioned(
            top: 260,
            left: -190,

            child: _GlowCircle(size: 360, color: const Color(0xFFDDE8FF)),
          ),

          // ======================================================
          // BOTTOM RIGHT GLOW
          // ======================================================
          Positioned(
            bottom: -170,
            right: -100,

            child: _GlowCircle(size: 390, color: const Color(0xFFD8F1E8)),
          ),

          // ======================================================
          // BOTTOM LEFT GLOW
          // ======================================================
          Positioned(
            bottom: -150,
            left: -130,

            child: _GlowCircle(size: 300, color: const Color(0xFFE8E0FF)),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// GLOW CIRCLE
// =================================================================

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),

      child: Container(
        width: size,
        height: size,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.42),
        ),
      ),
    );
  }
}
