import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'login/loginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  static const Color kSenseColor = Color(0xFF990056);

  // Light
  static const Color lightBg = Color(0xFFF5F6FC);
  static const Color lightTitle = Color(0xFF171A2D);
  static const Color lightSubtitle = Color(0xFF697087);
  static const Color lightCaption = Color(0xFF303552);
  static const Color lightIndicatorInactive = Color(0xFFD1D5E4);

  // Dark
  static const Color darkBg = Color(0xFF0F0F15);
  static const Color darkTitle = Colors.white;
  static const Color darkSubtitle = Color(0xFFB0B5C7);
  static const Color darkCaption = Color(0xFFD0D5E4);
  static const Color darkIndicatorInactive = Color(0xFF3A3A4A);

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      image: 'assets/onboarding/WhatsApp Image 2026-09-19 at 15.23.50 (1).png',
      title: 'Scan. Shop. Collect points'.tr(),
      description: 'Scan your receipt and earn points with every purchase.'
          .tr(),
    ),
    _OnboardingData(
      image: 'assets/onboarding/WhatsApp Image 2026-09-19 at 15.23.50.2.png',
      title: 'More points, more rewards.'.tr(),
      description:
          'Collect points, get exclusive offers, and enjoy special rewards.'
              .tr(),
    ),
    _OnboardingData(
      image: 'assets/onboarding/WhatsApp Image 2026-09-19 at 15.23.49 (1).png',
      title: 'Our branches are always close to you.'.tr(),
      description: 'Discover all Sense branches and find one near you.'.tr(),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

  void _skip() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    GetStorage().write('has_seen_onboarding', true);

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark ? darkBg : lightBg;

    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    final scale = (screenHeight / 852).clamp(0.75, 1.15);

    final isSmallScreen = screenHeight < 700;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: backgroundColor,

      body: Stack(
        fit: StackFit.expand,
        children: [
          _OnboardingBackground(isDark: isDark),

          Positioned(
            top: -50,
            left: -40,
            right: -40,
            child: IgnorePointer(
              child: Opacity(
                opacity: isDark ? 0.10 : 0.055,
                child: Image.asset(
                  'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
                  height: isTablet ? 450 : 350 * scale,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 12 * scale, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                fontSize: 14 * scale,
                                fontWeight: FontWeight.w600,
                                color: isDark ? darkSubtitle : lightSubtitle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

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
                      return _buildPage(
                        _pages[index],
                        isDark,
                        scale: scale,
                        isSmallScreen: isSmallScreen,
                        isTablet: isTablet,
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 24 * scale),
                  child: Row(
                    children: [
                      Row(
                        children: List.generate(_pages.length, (index) {
                          final bool active = index == _currentPage;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,

                            width: active ? 26 * scale : 7 * scale,

                            height: 7 * scale,

                            margin: EdgeInsets.only(right: 6 * scale),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                              color: active
                                  ? kSenseColor
                                  : (isDark
                                        ? darkIndicatorInactive
                                        : lightIndicatorInactive),
                            ),
                          );
                        }),
                      ),

                      const Spacer(),

                      Container(
                        height: (isSmallScreen ? 48 : 54) * scale,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),

                          boxShadow: [
                            BoxShadow(
                              color: kSenseColor.withOpacity(0.20),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: ElevatedButton(
                          onPressed: _nextPage,

                          style: ElevatedButton.styleFrom(
                            elevation: 0,

                            backgroundColor: kSenseColor,

                            foregroundColor: Colors.white,

                            padding: EdgeInsets.symmetric(
                              horizontal: 21 * scale,
                            ),

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

                                style: TextStyle(
                                  fontSize: 14 * scale,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              SizedBox(width: 8 * scale),

                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 20 * scale,
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
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
    _OnboardingData data,
    bool isDark, {
    required double scale,
    required bool isSmallScreen,
    required bool isTablet,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double imageHeight = isSmallScreen
            ? constraints.maxHeight * 0.42
            : isTablet
            ? constraints.maxHeight * 0.55
            : constraints.maxHeight * 0.48;

        final double titleSize = isSmallScreen
            ? 22
            : isTablet
            ? 34
            : 27 * scale;

        final double descSize = isSmallScreen
            ? 13
            : isTablet
            ? 17
            : 14.5 * scale;

        final double gapAfterImage = isSmallScreen
            ? 18
            : isTablet
            ? 36
            : 28 * scale;

        final double gapAfterTitle = isSmallScreen
            ? 8
            : isTablet
            ? 16
            : 11 * scale;

        final double horizontalPadding = isTablet ? 80 : 24;

        final bool needsScroll = isSmallScreen || constraints.maxHeight < 500;

        final pageContent = Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: imageHeight.clamp(180.0, 420.0),

                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),

                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.white.withOpacity(0.30),

                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.10)
                        : Colors.white.withOpacity(0.75),
                    width: 1.2,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.30 : 0.045),
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
                      return Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 55,
                          color: isDark
                              ? Colors.white30
                              : const Color(0xFF8C92A6),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: gapAfterImage),

              Text(
                data.title,

                textAlign: TextAlign.center,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                  height: 1.15,
                  color: isDark ? darkTitle : lightTitle,
                ),
              ),

              SizedBox(height: gapAfterTitle),

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isTablet ? 500 : 365),

                child: Text(
                  data.description,

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: descSize,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                    color: isDark ? darkSubtitle : lightSubtitle,
                  ),
                ),
              ),
            ],
          ),
        );

        if (needsScroll) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(child: pageContent),
            ),
          );
        }

        return Center(child: pageContent);
      },
    );
  }
}

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

class _OnboardingBackground extends StatelessWidget {
  final bool isDark;

  const _OnboardingBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: isDark
              ? const [Color(0xFF0F0F15), Color(0xFF14101A), Color(0xFF1A0F1A)]
              : const [Color(0xFFF8F9FF), Color(0xFFF0F2FB), Color(0xFFF6FAF9)],
        ),
      ),

      child: Stack(
        children: [
          Positioned(
            top: -140,
            right: -120,

            child: _GlowCircle(
              size: 360,
              color: isDark ? const Color(0xFF3A1A2E) : const Color(0xFFD0D5FF),
              isDark: isDark,
            ),
          ),

          Positioned(
            top: 260,
            left: -190,

            child: _GlowCircle(
              size: 360,
              color: isDark ? const Color(0xFF2A1525) : const Color(0xFFDDE8FF),
              isDark: isDark,
            ),
          ),

          Positioned(
            bottom: -170,
            right: -100,

            child: _GlowCircle(
              size: 390,
              color: isDark ? const Color(0xFF2A1220) : const Color(0xFFD8F1E8),
              isDark: isDark,
            ),
          ),

          Positioned(
            bottom: -150,
            left: -130,

            child: _GlowCircle(
              size: 300,
              color: isDark ? const Color(0xFF351828) : const Color(0xFFE8E0FF),
              isDark: isDark,
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
  final bool isDark;

  const _GlowCircle({
    required this.size,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),

      child: Container(
        width: size,
        height: size,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(isDark ? 0.55 : 0.42),
        ),
      ),
    );
  }
}
