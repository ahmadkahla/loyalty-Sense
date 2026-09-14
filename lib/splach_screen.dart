// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import 'onboarding_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.90, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );
//
//     _animationController.forward();
//
//     Timer(const Duration(seconds: 3), () {
//       if (!mounted) return;
//
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               const OnboardingScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 500),
//         ),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // دائرة زخرفية أعلى اليمين
//           Positioned(
//             top: -110,
//             right: -90,
//             child: Container(
//               width: 280,
//               height: 280,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: const Color(0xFF2563EB).withOpacity(0.06),
//               ),
//             ),
//           ),
//
//           // دائرة زخرفية أسفل اليسار
//           Positioned(
//             bottom: -130,
//             left: -100,
//             child: Container(
//               width: 310,
//               height: 310,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: const Color(0xFF3B82F6).withOpacity(0.05),
//               ),
//             ),
//           ),
//
//           // دائرة صغيرة بالخلفية
//           Positioned(
//             top: 150,
//             left: -35,
//             child: Container(
//               width: 85,
//               height: 85,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: const Color(0xFF60A5FA).withOpacity(0.05),
//               ),
//             ),
//           ),
//
//           // اللوجو فقط
//           Center(
//             child: AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: ScaleTransition(scale: _scaleAnimation, child: child),
//                 );
//               },
//               child: Image.asset(
//                 'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
//                 width: 280,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import 'onboarding_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.90, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );
//
//     _animationController.forward();
//
//     Timer(const Duration(seconds: 3), () {
//       if (!mounted) return;
//
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               const OnboardingScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 500),
//         ),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     // ==========================================================
//     // 🎨 الألوان حسب الوضع
//     // ==========================================================
//     final backgroundColor = isDark ? const Color(0xFF0F0F15) : Colors.white;
//
//     // الدوائر الزخرفية — ألوان بنفسجية (SENSE brand)
//     final circleColors = isDark
//         ? const [
//             Color(0xFF3A1A2E), // غامق بنفسجي
//             Color(0xFF2A1525), // أغمق
//             Color(0xFF351828), // وسط
//           ]
//         : const [
//             Color(0xFF2563EB), // أزرق فاتح
//             Color(0xFF3B82F6), // أزرق
//             Color(0xFF60A5FA), // أزرق سماوي
//           ];
//
//     // شفافية الدوائر — أقل في الداكن عشان ما تصير مبهرجة
//     final circleOpacity = isDark ? 0.55 : 0.06;
//
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Stack(
//         children: [
//           // ==========================================
//           // دائرة زخرفية أعلى اليمين
//           // ==========================================
//           Positioned(
//             top: -110,
//             right: -90,
//             child: Container(
//               width: 280,
//               height: 280,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: circleColors[0].withOpacity(circleOpacity),
//               ),
//             ),
//           ),
//
//           // ==========================================
//           // دائرة زخرفية أسفل اليسار
//           // ==========================================
//           Positioned(
//             bottom: -130,
//             left: -100,
//             child: Container(
//               width: 310,
//               height: 310,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: circleColors[1].withOpacity(circleOpacity * 0.85),
//               ),
//             ),
//           ),
//
//           // ==========================================
//           // دائرة صغيرة بالخلفية
//           // ==========================================
//           Positioned(
//             top: 150,
//             left: -35,
//             child: Container(
//               width: 85,
//               height: 85,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: circleColors[2].withOpacity(circleOpacity * 0.85),
//               ),
//             ),
//           ),
//
//           // ==========================================
//           // اللوجو
//           // ==========================================
//           Center(
//             child: AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: ScaleTransition(scale: _scaleAnimation, child: child),
//                 );
//               },
//               child: Image.asset(
//                 'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
//                 width: 280,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryController; // الدخول
  late AnimationController _pulseController; // النبض
  late AnimationController _floatController; // الطفو
  late AnimationController _rippleController; // الأمواج
  late AnimationController _dotsController; // نقاط التحميل

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _entryController.forward();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      _pulseController.repeat(reverse: true);
      _floatController.repeat(reverse: true);
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      _rippleController.repeat();
    });

    _dotsController.repeat();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    _rippleController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark ? const Color(0xFF0F0F15) : Colors.white;

    const senseColor = Color(0xFF990056);
    const senseLight = Color(0xFFCC007A);

    final circleColor1 = isDark
        ? const Color(0xFF3A1A2E)
        : const Color(0xFF990056);
    final circleColor2 = isDark
        ? const Color(0xFF2A1525)
        : const Color(0xFFCC007A);
    final circleColor3 = isDark
        ? const Color(0xFF351828)
        : const Color(0xFFE6008A);

    final circleOpacity = isDark ? 0.55 : 0.06;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -110,
            right: -90,
            child: _AnimatedCircle(
              size: 280,
              color: circleColor1.withOpacity(circleOpacity),
              isDark: isDark,
              duration: 3500,
            ),
          ),

          Positioned(
            bottom: -130,
            left: -100,
            child: _AnimatedCircle(
              size: 310,
              color: circleColor2.withOpacity(circleOpacity),
              isDark: isDark,
              duration: 4200,
            ),
          ),

          Positioned(
            top: 150,
            left: -35,
            child: _AnimatedCircle(
              size: 85,
              color: circleColor3.withOpacity(circleOpacity),
              isDark: isDark,
              duration: 3000,
            ),
          ),

          Center(
            child: AnimatedBuilder(
              animation: _rippleController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Wave 1
                    _RippleWave(
                      progress: _rippleController.value,
                      color: senseColor.withOpacity(isDark ? 0.25 : 0.15),
                    ),
                    _RippleWave(
                      progress: (_rippleController.value + 0.5) % 1.0,
                      color: senseLight.withOpacity(isDark ? 0.20 : 0.10),
                    ),
                  ],
                );
              },
            ),
          ),

          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _entryController,
                _pulseController,
                _floatController,
              ]),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.scale(
                        scale: _pulseAnimation.value,
                        child: child,
                      ),
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          senseColor.withOpacity(isDark ? 0.35 : 0.20),
                          Colors.transparent,
                        ],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),

                  // 🖼️ Logo
                  Image.asset(
                    'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
                    width: 240,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _dotsController,
                builder: (context, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (index) {
                      final phase = (_dotsController.value * 3 - index) % 3;
                      final scale = phase < 1
                          ? 1.0 + (0.5 * math.sin(phase * math.pi))
                          : 1.0;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: senseColor.withOpacity(
                                isDark ? 0.80 : 0.60,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCircle extends StatefulWidget {
  final double size;
  final Color color;
  final bool isDark;
  final int duration;

  const _AnimatedCircle({
    required this.size,
    required this.color,
    required this.isDark,
    required this.duration,
  });

  @override
  State<_AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<_AnimatedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}

class _RippleWave extends StatelessWidget {
  final double progress;
  final Color color;

  const _RippleWave({required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    final double size = 100 + (progress * 220);

    final double opacity = (1.0 - progress).clamp(0.0, 1.0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(opacity), width: 2),
      ),
    );
  }
}
