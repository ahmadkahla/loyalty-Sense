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

// import 'dart:async';
// import 'dart:math' as math;
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
//     with TickerProviderStateMixin {
//   late AnimationController _entryController; // الدخول
//   late AnimationController _pulseController; // النبض
//   late AnimationController _floatController; // الطفو
//   late AnimationController _rippleController; // الأمواج
//   late AnimationController _dotsController; // نقاط التحميل
//
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _floatAnimation;
//   late Animation<double> _rippleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _entryController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _fadeAnimation = CurvedAnimation(
//       parent: _entryController,
//       curve: Curves.easeInOut,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
//       CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
//     );
//
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//
//     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//
//     _floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2500),
//     );
//
//     _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );
//
//     _rippleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2200),
//     );
//
//     _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
//     );
//
//     _dotsController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//
//     _entryController.forward();
//
//     Future.delayed(const Duration(milliseconds: 600), () {
//       if (!mounted) return;
//       _pulseController.repeat(reverse: true);
//       _floatController.repeat(reverse: true);
//     });
//
//     Future.delayed(const Duration(milliseconds: 400), () {
//       if (!mounted) return;
//       _rippleController.repeat();
//     });
//
//     _dotsController.repeat();
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
//     _entryController.dispose();
//     _pulseController.dispose();
//     _floatController.dispose();
//     _rippleController.dispose();
//     _dotsController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final backgroundColor = isDark ? const Color(0xFF0F0F15) : Colors.white;
//
//     const senseColor = Color(0xFF990056);
//     const senseLight = Color(0xFFCC007A);
//
//     final circleColor1 = isDark
//         ? const Color(0xFF3A1A2E)
//         : const Color(0xFF990056);
//     final circleColor2 = isDark
//         ? const Color(0xFF2A1525)
//         : const Color(0xFFCC007A);
//     final circleColor3 = isDark
//         ? const Color(0xFF351828)
//         : const Color(0xFFE6008A);
//
//     final circleOpacity = isDark ? 0.55 : 0.06;
//
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Stack(
//         children: [
//           Positioned(
//             top: -110,
//             right: -90,
//             child: _AnimatedCircle(
//               size: 280,
//               color: circleColor1.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 3500,
//             ),
//           ),
//
//           Positioned(
//             bottom: -130,
//             left: -100,
//             child: _AnimatedCircle(
//               size: 310,
//               color: circleColor2.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 4200,
//             ),
//           ),
//
//           Positioned(
//             top: 150,
//             left: -35,
//             child: _AnimatedCircle(
//               size: 85,
//               color: circleColor3.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 3000,
//             ),
//           ),
//
//           Center(
//             child: AnimatedBuilder(
//               animation: _rippleController,
//               builder: (context, child) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Wave 1
//                     _RippleWave(
//                       progress: _rippleController.value,
//                       color: senseColor.withOpacity(isDark ? 0.25 : 0.15),
//                     ),
//                     _RippleWave(
//                       progress: (_rippleController.value + 0.5) % 1.0,
//                       color: senseLight.withOpacity(isDark ? 0.20 : 0.10),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//
//           Center(
//             child: AnimatedBuilder(
//               animation: Listenable.merge([
//                 _entryController,
//                 _pulseController,
//                 _floatController,
//               ]),
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: Offset(0, _floatAnimation.value),
//                   child: ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Transform.scale(
//                         scale: _pulseAnimation.value,
//                         child: child,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 260,
//                     height: 260,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: RadialGradient(
//                         colors: [
//                           senseColor.withOpacity(isDark ? 0.35 : 0.20),
//                           Colors.transparent,
//                         ],
//                         stops: const [0.4, 1.0],
//                       ),
//                     ),
//                   ),
//
//                   // 🖼️ Logo
//                   Image.asset(
//                     'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
//                     width: 240,
//                     fit: BoxFit.contain,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           Positioned(
//             bottom: 80,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: AnimatedBuilder(
//                 animation: _dotsController,
//                 builder: (context, child) {
//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: List.generate(3, (index) {
//                       final phase = (_dotsController.value * 3 - index) % 3;
//                       final scale = phase < 1
//                           ? 1.0 + (0.5 * math.sin(phase * math.pi))
//                           : 1.0;
//
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 5),
//                         child: Transform.scale(
//                           scale: scale,
//                           child: Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: senseColor.withOpacity(
//                                 isDark ? 0.80 : 0.60,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _AnimatedCircle extends StatefulWidget {
//   final double size;
//   final Color color;
//   final bool isDark;
//   final int duration;
//
//   const _AnimatedCircle({
//     required this.size,
//     required this.color,
//     required this.isDark,
//     required this.duration,
//   });
//
//   @override
//   State<_AnimatedCircle> createState() => _AnimatedCircleState();
// }
//
// class _AnimatedCircleState extends State<_AnimatedCircle>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: widget.duration),
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.9,
//       end: 1.1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     _controller.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _scaleAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: Container(
//             width: widget.size,
//             height: widget.size,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: widget.color,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _RippleWave extends StatelessWidget {
//   final double progress;
//   final Color color;
//
//   const _RippleWave({required this.progress, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     final double size = 100 + (progress * 220);
//
//     final double opacity = (1.0 - progress).clamp(0.0, 1.0);
//
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: color.withOpacity(opacity), width: 2),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
//
// import 'login/loginScreen.dart';
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
//     with TickerProviderStateMixin {
//   late AnimationController _entryController; // الدخول
//   late AnimationController _pulseController; // النبض
//   late AnimationController _floatController; // الطفو
//   late AnimationController _rippleController; // الأمواج
//   late AnimationController _dotsController; // نقاط التحميل
//
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _floatAnimation;
//   late Animation<double> _rippleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // ============================================================
//     // ENTRY ANIMATION
//     // ============================================================
//
//     _entryController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _fadeAnimation = CurvedAnimation(
//       parent: _entryController,
//       curve: Curves.easeInOut,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
//       CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
//     );
//
//     // ============================================================
//     // PULSE ANIMATION
//     // ============================================================
//
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//
//     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//
//     // ============================================================
//     // FLOAT ANIMATION
//     // ============================================================
//
//     _floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2500),
//     );
//
//     _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );
//
//     // ============================================================
//     // RIPPLE ANIMATION
//     // ============================================================
//
//     _rippleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2200),
//     );
//
//     _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
//     );
//
//     // ============================================================
//     // DOTS ANIMATION
//     // ============================================================
//
//     _dotsController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//
//     // ============================================================
//     // START ANIMATIONS
//     // ============================================================
//
//     _entryController.forward();
//
//     Future.delayed(const Duration(milliseconds: 600), () {
//       if (!mounted) return;
//
//       _pulseController.repeat(reverse: true);
//       _floatController.repeat(reverse: true);
//     });
//
//     Future.delayed(const Duration(milliseconds: 400), () {
//       if (!mounted) return;
//
//       _rippleController.repeat();
//     });
//
//     _dotsController.repeat();
//
//     // ============================================================
//     // NAVIGATION
//     // ============================================================
//
//     Timer(const Duration(seconds: 3), () {
//       if (!mounted) return;
//
//       final box = GetStorage();
//
//       // هل المستخدم شاهد الـ Onboarding سابقًا؟
//       final hasSeenOnboarding = box.read('has_seen_onboarding') == true;
//
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             // أول استخدام → Onboarding
//             // بعد مشاهدة Onboarding → Login
//             return hasSeenOnboarding
//                 ? const LoginScreen()
//                 : const OnboardingScreen();
//           },
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
//     _entryController.dispose();
//     _pulseController.dispose();
//     _floatController.dispose();
//     _rippleController.dispose();
//     _dotsController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final backgroundColor = isDark ? const Color(0xFF0F0F15) : Colors.white;
//
//     const senseColor = Color(0xFF990056);
//     const senseLight = Color(0xFFCC007A);
//
//     final circleColor1 = isDark
//         ? const Color(0xFF3A1A2E)
//         : const Color(0xFF990056);
//
//     final circleColor2 = isDark
//         ? const Color(0xFF2A1525)
//         : const Color(0xFFCC007A);
//
//     final circleColor3 = isDark
//         ? const Color(0xFF351828)
//         : const Color(0xFFE6008A);
//
//     final circleOpacity = isDark ? 0.55 : 0.06;
//
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Stack(
//         children: [
//           // ==========================================================
//           // TOP RIGHT CIRCLE
//           // ==========================================================
//
//           Positioned(
//             top: -110,
//             right: -90,
//             child: _AnimatedCircle(
//               size: 280,
//               color: circleColor1.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 3500,
//             ),
//           ),
//
//           // ==========================================================
//           // BOTTOM LEFT CIRCLE
//           // ==========================================================
//           Positioned(
//             bottom: -130,
//             left: -100,
//             child: _AnimatedCircle(
//               size: 310,
//               color: circleColor2.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 4200,
//             ),
//           ),
//
//           // ==========================================================
//           // LEFT SMALL CIRCLE
//           // ==========================================================
//           Positioned(
//             top: 150,
//             left: -35,
//             child: _AnimatedCircle(
//               size: 85,
//               color: circleColor3.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 3000,
//             ),
//           ),
//
//           // ==========================================================
//           // RIPPLE WAVES
//           // ==========================================================
//           Center(
//             child: AnimatedBuilder(
//               animation: _rippleController,
//               builder: (context, child) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Wave 1
//                     _RippleWave(
//                       progress: _rippleController.value,
//                       color: senseColor.withOpacity(isDark ? 0.25 : 0.15),
//                     ),
//
//                     // Wave 2
//                     _RippleWave(
//                       progress: (_rippleController.value + 0.5) % 1.0,
//                       color: senseLight.withOpacity(isDark ? 0.20 : 0.10),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//
//           // ==========================================================
//           // LOGO
//           // ==========================================================
//           Center(
//             child: AnimatedBuilder(
//               animation: Listenable.merge([
//                 _entryController,
//                 _pulseController,
//                 _floatController,
//               ]),
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: Offset(0, _floatAnimation.value),
//                   child: ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Transform.scale(
//                         scale: _pulseAnimation.value,
//                         child: child,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 260,
//                     height: 260,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: RadialGradient(
//                         colors: [
//                           senseColor.withOpacity(isDark ? 0.35 : 0.20),
//                           Colors.transparent,
//                         ],
//                         stops: const [0.4, 1.0],
//                       ),
//                     ),
//                   ),
//
//                   // Logo
//                   Image.asset(
//                     'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
//                     width: 240,
//                     fit: BoxFit.contain,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // ==========================================================
//           // LOADING DOTS
//           // ==========================================================
//           Positioned(
//             bottom: 80,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: AnimatedBuilder(
//                 animation: _dotsController,
//                 builder: (context, child) {
//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: List.generate(3, (index) {
//                       final phase = (_dotsController.value * 3 - index) % 3;
//
//                       final scale = phase < 1
//                           ? 1.0 + (0.5 * math.sin(phase * math.pi))
//                           : 1.0;
//
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 5),
//                         child: Transform.scale(
//                           scale: scale,
//                           child: Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: senseColor.withOpacity(
//                                 isDark ? 0.80 : 0.60,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // =================================================================
// // ANIMATED CIRCLE
// // =================================================================
//
// class _AnimatedCircle extends StatefulWidget {
//   final double size;
//   final Color color;
//   final bool isDark;
//   final int duration;
//
//   const _AnimatedCircle({
//     required this.size,
//     required this.color,
//     required this.isDark,
//     required this.duration,
//   });
//
//   @override
//   State<_AnimatedCircle> createState() => _AnimatedCircleState();
// }
//
// class _AnimatedCircleState extends State<_AnimatedCircle>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: widget.duration),
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.9,
//       end: 1.1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     _controller.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _scaleAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: Container(
//             width: widget.size,
//             height: widget.size,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: widget.color,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// // =================================================================
// // RIPPLE WAVE
// // =================================================================
//
// class _RippleWave extends StatelessWidget {
//   final double progress;
//   final Color color;
//
//   const _RippleWave({required this.progress, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     final double size = 100 + (progress * 220);
//
//     final double opacity = (1.0 - progress).clamp(0.0, 1.0);
//
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: color.withOpacity(opacity), width: 2),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:math' as math;
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
//     with TickerProviderStateMixin {
//   late AnimationController _entryController;
//   late AnimationController _pulseController;
//   late AnimationController _floatController;
//   late AnimationController _rippleController;
//   late AnimationController _dotsController;
//
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _floatAnimation;
//   late Animation<double> _rippleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // ============================================================
//     // ENTRY ANIMATION
//     // ============================================================
//     _entryController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _fadeAnimation = CurvedAnimation(
//       parent: _entryController,
//       curve: Curves.easeInOut,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
//       CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
//     );
//
//     // ============================================================
//     // PULSE ANIMATION
//     // ============================================================
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//
//     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//
//     // ============================================================
//     // FLOAT ANIMATION
//     // ============================================================
//     _floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2500),
//     );
//
//     _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );
//
//     // ============================================================
//     // RIPPLE ANIMATION
//     // ============================================================
//     _rippleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2200),
//     );
//
//     _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
//     );
//
//     // ============================================================
//     // DOTS ANIMATION
//     // ============================================================
//     _dotsController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//
//     // ============================================================
//     // START ANIMATIONS
//     // ============================================================
//     _entryController.forward();
//
//     Future.delayed(const Duration(milliseconds: 600), () {
//       if (!mounted) return;
//       _pulseController.repeat(reverse: true);
//       _floatController.repeat(reverse: true);
//     });
//
//     Future.delayed(const Duration(milliseconds: 400), () {
//       if (!mounted) return;
//       _rippleController.repeat();
//     });
//
//     _dotsController.repeat();
//
//     // ============================================================
//     // NAVIGATION
//     // ============================================================
//     Timer(const Duration(seconds: 3), () {
//       if (!mounted) return;
//
//       // ✅ دائماً اذهب إلى Onboarding
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return const OnboardingScreen();
//           },
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
//     _entryController.dispose();
//     _pulseController.dispose();
//     _floatController.dispose();
//     _rippleController.dispose();
//     _dotsController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final backgroundColor = isDark ? const Color(0xFF0F0F15) : Colors.white;
//
//     const senseColor = Color(0xFF990056);
//     const senseLight = Color(0xFFCC007A);
//
//     final circleColor1 = isDark
//         ? const Color(0xFF3A1A2E)
//         : const Color(0xFF990056);
//     final circleColor2 = isDark
//         ? const Color(0xFF2A1525)
//         : const Color(0xFFCC007A);
//     final circleColor3 = isDark
//         ? const Color(0xFF351828)
//         : const Color(0xFFE6008A);
//
//     final circleOpacity = isDark ? 0.55 : 0.06;
//
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Stack(
//         children: [
//           // TOP RIGHT CIRCLE
//           Positioned(
//             top: -110,
//             right: -90,
//             child: _AnimatedCircle(
//               size: 280,
//               color: circleColor1.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 3500,
//             ),
//           ),
//
//           // BOTTOM LEFT CIRCLE
//           Positioned(
//             bottom: -130,
//             left: -100,
//             child: _AnimatedCircle(
//               size: 310,
//               color: circleColor2.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 4200,
//             ),
//           ),
//
//           // LEFT SMALL CIRCLE
//           Positioned(
//             top: 150,
//             left: -35,
//             child: _AnimatedCircle(
//               size: 85,
//               color: circleColor3.withOpacity(circleOpacity),
//               isDark: isDark,
//               duration: 3000,
//             ),
//           ),
//
//           // RIPPLE WAVES
//           Center(
//             child: AnimatedBuilder(
//               animation: _rippleController,
//               builder: (context, child) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     _RippleWave(
//                       progress: _rippleController.value,
//                       color: senseColor.withOpacity(isDark ? 0.25 : 0.15),
//                     ),
//                     _RippleWave(
//                       progress: (_rippleController.value + 0.5) % 1.0,
//                       color: senseLight.withOpacity(isDark ? 0.20 : 0.10),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//
//           // LOGO
//           Center(
//             child: AnimatedBuilder(
//               animation: Listenable.merge([
//                 _entryController,
//                 _pulseController,
//                 _floatController,
//               ]),
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: Offset(0, _floatAnimation.value),
//                   child: ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Transform.scale(
//                         scale: _pulseAnimation.value,
//                         child: child,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 260,
//                     height: 260,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: RadialGradient(
//                         colors: [
//                           senseColor.withOpacity(isDark ? 0.35 : 0.20),
//                           Colors.transparent,
//                         ],
//                         stops: const [0.4, 1.0],
//                       ),
//                     ),
//                   ),
//                   Image.asset(
//                     'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
//                     width: 240,
//                     fit: BoxFit.contain,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // LOADING DOTS
//           Positioned(
//             bottom: 80,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: AnimatedBuilder(
//                 animation: _dotsController,
//                 builder: (context, child) {
//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: List.generate(3, (index) {
//                       final phase = (_dotsController.value * 3 - index) % 3;
//                       final scale = phase < 1
//                           ? 1.0 + (0.5 * math.sin(phase * math.pi))
//                           : 1.0;
//
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 5),
//                         child: Transform.scale(
//                           scale: scale,
//                           child: Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: senseColor.withOpacity(
//                                 isDark ? 0.80 : 0.60,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // =================================================================
// // ANIMATED CIRCLE
// // =================================================================
//
// class _AnimatedCircle extends StatefulWidget {
//   final double size;
//   final Color color;
//   final bool isDark;
//   final int duration;
//
//   const _AnimatedCircle({
//     required this.size,
//     required this.color,
//     required this.isDark,
//     required this.duration,
//   });
//
//   @override
//   State<_AnimatedCircle> createState() => _AnimatedCircleState();
// }
//
// class _AnimatedCircleState extends State<_AnimatedCircle>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: widget.duration),
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.9,
//       end: 1.1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     _controller.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _scaleAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: Container(
//             width: widget.size,
//             height: widget.size,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: widget.color,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// // =================================================================
// // RIPPLE WAVE
// // =================================================================
//
// class _RippleWave extends StatelessWidget {
//   final double progress;
//   final Color color;
//
//   const _RippleWave({required this.progress, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     final double size = 100 + (progress * 220);
//     final double opacity = (1.0 - progress).clamp(0.0, 1.0);
//
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: color.withOpacity(opacity), width: 2),
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
  // ============================================================
  // CONTROLLERS
  // ============================================================
  late AnimationController _entryController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _dotsController;
  late AnimationController _particleController;

  // القلم + الكتابة + ظهور اللوجو
  late AnimationController _penController;
  late AnimationController _textRevealController;
  late AnimationController _logoRevealController;

  // حركة الهالات (Aurora)
  late AnimationController _auroraController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  final String _brandName = 'SENSE';
  final int _charCount = 5;

  @override
  void initState() {
    super.initState();

    // ============================================================
    // ENTRY ANIMATION
    // ============================================================
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

    // ============================================================
    // PULSE ANIMATION
    // ============================================================
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // ============================================================
    // FLOAT ANIMATION
    // ============================================================
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // ============================================================
    // DOTS ANIMATION
    // ============================================================
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // ============================================================
    // PARTICLES ANIMATION
    // ============================================================
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    );

    // ============================================================
    // AURORA ANIMATION
    // ============================================================
    _auroraController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 14000),
    );

    // ============================================================
    // PEN WRITING ANIMATION
    // ============================================================
    _penController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // ============================================================
    // TEXT REVEAL ANIMATION
    // ============================================================
    _textRevealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // ============================================================
    // LOGO REVEAL ANIMATION
    // ============================================================
    _logoRevealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // ============================================================
    // START ANIMATIONS
    // ============================================================
    _entryController.forward();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      _pulseController.repeat(reverse: true);
      _floatController.repeat(reverse: true);
    });

    _dotsController.repeat();
    _particleController.repeat();
    _auroraController.repeat();

    // ابدأ كتابة الاسم
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      _penController.forward();
      _textRevealController.forward();
    });

    // أظهر اللوجو بعد اكتمال الكتابة
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (!mounted) return;
      _logoRevealController.forward();
    });

    // ============================================================
    // NAVIGATION
    // ============================================================
    Timer(const Duration(milliseconds: 4500), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const OnboardingScreen();
          },
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
    _dotsController.dispose();
    _particleController.dispose();
    _auroraController.dispose();
    _penController.dispose();
    _textRevealController.dispose();
    _logoRevealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const senseColor = Color(0xFF990056);
    const senseLight = Color(0xFFCC007A);
    const senseAccent = Color(0xFFE6008A);

    // ============================================================
    // BACKGROUND GRADIENT
    // ============================================================
    final bgGradient = isDark
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0A10), Color(0xFF12060F), Color(0xFF0F0F15)],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFFFFF), Color(0xFFFFF7FC), Color(0xFFFDF0F8)],
          );

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F15) : Colors.white,
      body: Container(
        decoration: BoxDecoration(gradient: bgGradient),
        child: Stack(
          children: [
            // ============================================================
            // ✨ AURORA BLOBS
            // ============================================================
            _buildAuroraBlobs(isDark, senseColor, senseAccent),

            // ============================================================
            // ✨ DOT GRID PATTERN
            // ============================================================
            _buildDotGrid(isDark, senseColor),

            // ============================================================
            // ✨ DIAGONAL LIGHT STREAKS
            // ============================================================
            _buildLightStreaks(isDark, senseColor, senseAccent),

            // ============================================================
            // ✨ FLOATING PARTICLES
            // ============================================================
            ..._buildParticles(isDark, senseColor, senseAccent),

            // ============================================================
            // ✍️ MAIN CONTENT: PEN + TEXT + LOGO
            // ============================================================
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _entryController,
                  _floatController,
                ]),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatAnimation.value),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: child,
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ------------------------------------------------
                    // ✍️ PEN + HANDWRITING SECTION
                    // ------------------------------------------------
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _penController,
                        _textRevealController,
                        _logoRevealController,
                      ]),
                      builder: (context, _) {
                        final hideProgress = _logoRevealController.value;
                        final sectionOpacity = (1.0 - hideProgress).clamp(
                          0.0,
                          1.0,
                        );

                        if (sectionOpacity <= 0.01) {
                          return const SizedBox.shrink();
                        }

                        return Opacity(
                          opacity: sectionOpacity,
                          child: _buildPenWritingSection(
                            isDark,
                            senseColor,
                            senseAccent,
                          ),
                        );
                      },
                    ),

                    // ------------------------------------------------
                    // 🖼️ LOGO + BRAND NAME
                    // ------------------------------------------------
                    _buildLogoSection(
                      isDark,
                      senseColor,
                      senseAccent,
                      senseLight,
                    ),
                  ],
                ),
              ),
            ),

            // ============================================================
            // LOADING DOTS
            // ============================================================
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
                            ? 1.0 + (0.6 * math.sin(phase * math.pi))
                            : 1.0;
                        final glow = phase < 1
                            ? 0.4 + (0.6 * math.sin(phase * math.pi))
                            : 0.3;

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    senseAccent.withOpacity(isDark ? 0.9 : 0.8),
                                    senseColor.withOpacity(isDark ? 0.9 : 0.8),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: senseColor.withOpacity(glow),
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                  ),
                                ],
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
      ),
    );
  }

  // ============================================================
  // ✨ AURORA BLOBS
  // ============================================================
  Widget _buildAuroraBlobs(bool isDark, Color c1, Color c2) {
    return AnimatedBuilder(
      animation: _auroraController,
      builder: (context, _) {
        final t = _auroraController.value;
        final drift1 = Offset(
          math.sin(t * 2 * math.pi) * 40,
          math.cos(t * 2 * math.pi) * 30,
        );
        final drift2 = Offset(
          math.cos(t * 2 * math.pi) * 50,
          math.sin(t * 2 * math.pi) * 35,
        );

        return Stack(
          children: [
            Positioned(
              top: -180 + drift1.dy,
              right: -180 + drift1.dx,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      c1.withOpacity(isDark ? 0.35 : 0.15),
                      c1.withOpacity(0.0),
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -220 + drift2.dy,
              left: -200 + drift2.dx,
              child: Container(
                width: 550,
                height: 550,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      c2.withOpacity(isDark ? 0.30 : 0.12),
                      c2.withOpacity(0.0),
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // ✨ DOT GRID PATTERN
  // ============================================================
  Widget _buildDotGrid(bool isDark, Color color) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _DotGridPainter(
          color: color.withOpacity(isDark ? 0.10 : 0.06),
          spacing: 40,
          dotSize: 1.2,
        ),
      ),
    );
  }

  // ============================================================
  // ✨ DIAGONAL LIGHT STREAKS
  // ============================================================
  Widget _buildLightStreaks(bool isDark, Color c1, Color c2) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, _) {
        final t = _particleController.value;
        return Positioned.fill(
          child: CustomPaint(
            painter: _LightStreakPainter(
              progress: t,
              color1: c1.withOpacity(isDark ? 0.18 : 0.10),
              color2: c2.withOpacity(isDark ? 0.12 : 0.06),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // ✍️ PEN WRITING SECTION (with Ink Trail)
  // ============================================================
  Widget _buildPenWritingSection(
    bool isDark,
    Color senseColor,
    Color senseAccent,
  ) {
    const double totalWidth = 280;
    const double penWidth = 44;

    return SizedBox(
      width: totalWidth,
      height: 120,
      child: AnimatedBuilder(
        animation: _penController,
        builder: (context, _) {
          final progress = _penController.value;
          final penX = (totalWidth - penWidth) * progress;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // ============================================
              // 🖋️ INK TRAIL (behind everything)
              // ============================================
              Positioned.fill(
                child: CustomPaint(
                  painter: _InkTrailPainter(
                    progress: _penController.value,
                    color: senseColor,
                    accentColor: senseAccent,
                    isDark: isDark,
                    penX: penX + (penWidth / 2),
                    penY: 58,
                    maxTrailLength: totalWidth.toDouble(),
                  ),
                ),
              ),

              // النص
              Positioned.fill(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _textRevealController,
                    builder: (context, _) {
                      return _HandwrittenText(
                        text: _brandName,
                        progress: _textRevealController.value,
                        color: senseColor,
                        accentColor: senseAccent,
                        isDark: isDark,
                      );
                    },
                  ),
                ),
              ),

              // القلم
              Positioned(
                left: penX,
                top: 0,
                child: _PenWidget(
                  color: senseColor,
                  accentColor: senseAccent,
                  isDark: isDark,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // 🖼️ LOGO SECTION
  // ============================================================
  Widget _buildLogoSection(
    bool isDark,
    Color senseColor,
    Color senseAccent,
    Color senseLight,
  ) {
    return AnimatedBuilder(
      animation: _logoRevealController,
      builder: (context, child) {
        final t = _logoRevealController.value;
        if (t <= 0.01) return const SizedBox.shrink();

        final scale = 0.6 + (0.4 * Curves.easeOutBack.transform(t));
        final opacity = Curves.easeIn.transform(t);

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(scale: scale, child: child),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: senseAccent.withOpacity(isDark ? 0.45 : 0.25),
                  blurRadius: 60,
                  spreadRadius: 8,
                ),
                BoxShadow(
                  color: senseColor.withOpacity(isDark ? 0.30 : 0.15),
                  blurRadius: 100,
                  spreadRadius: 20,
                ),
              ],
            ),
            child: Image.asset(
              'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
              width: 190,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [senseAccent, senseColor, senseLight],
              ).createShader(bounds);
            },
            child: Text(
              _brandName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 8,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FLOATING PARTICLES
  // ============================================================
  List<Widget> _buildParticles(bool isDark, Color c1, Color c2) {
    final random = math.Random(42);
    return List.generate(14, (index) {
      final size = 2.0 + random.nextDouble() * 3.0;
      final left = random.nextDouble() * 400;
      final top = random.nextDouble() * 800;
      final delay = random.nextDouble();
      final color = index % 2 == 0 ? c1 : c2;

      return Positioned(
        left: left,
        top: top,
        child: AnimatedBuilder(
          animation: _particleController,
          builder: (context, child) {
            final t = (_particleController.value + delay) % 1.0;
            final opacity = (math.sin(t * math.pi)).clamp(0.0, 1.0);
            final offsetY = -20 * math.sin(t * math.pi * 2);

            return Transform.translate(
              offset: Offset(0, offsetY),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(opacity * (isDark ? 0.6 : 0.35)),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(opacity * 0.5),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

// =================================================================
// 🖋️ INK TRAIL PAINTER - أثر الحبر خلف القلم
// =================================================================

class _InkTrailPainter extends CustomPainter {
  final double progress; // 0 → 1
  final Color color;
  final Color accentColor;
  final bool isDark;
  final double penX; // موقع القلم الحالي
  final double penY;
  final double maxTrailLength;

  _InkTrailPainter({
    required this.progress,
    required this.color,
    required this.accentColor,
    required this.isDark,
    required this.penX,
    required this.penY,
    required this.maxTrailLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0) return;

    // ============================================================
    // 1) أثر الحبر الأساسي (خط متوهج ينمو مع حركة القلم)
    // ============================================================
    final trailStartX = 20.0; // بداية الأثر (عند أول حرف)
    final trailEndX = penX; // نهاية الأثر (موقع القلم الحالي)

    if (trailEndX <= trailStartX) return;

    // ============================================================
    // 2) رسم الخط الرئيسي بتدرج لوني (يتلاشى من البداية)
    // ============================================================
    final linePaint = Paint()
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    // تدرج: شفاف في البداية → لون قوي قرب القلم
    linePaint.shader =
        LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color.withOpacity(0.0),
            color.withOpacity(isDark ? 0.35 : 0.20),
            accentColor.withOpacity(isDark ? 0.85 : 0.65),
          ],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(
          Rect.fromLTWH(trailStartX, 0, trailEndX - trailStartX, size.height),
        );

    // خط مستقيم من البداية حتى موقع القلم (مع انحناءة طفيفة للأعلى)
    final path = Path()
      ..moveTo(trailStartX, penY + 2)
      ..quadraticBezierTo(
        (trailStartX + trailEndX) / 2,
        penY - 4, // انحناءة طفيفة للأعلى
        trailEndX,
        penY,
      );

    canvas.drawPath(path, linePaint);

    // ============================================================
    // 3) توهج ناعم حول الأثر (Glow Layer)
    // ============================================================
    final glowPaint = Paint()
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)
      ..isAntiAlias = true;

    glowPaint.shader =
        LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            accentColor.withOpacity(0.0),
            accentColor.withOpacity(isDark ? 0.30 : 0.15),
            accentColor.withOpacity(isDark ? 0.55 : 0.35),
          ],
          stops: const [0.0, 0.7, 1.0],
        ).createShader(
          Rect.fromLTWH(trailStartX, 0, trailEndX - trailStartX, size.height),
        );

    canvas.drawPath(path, glowPaint);

    // ============================================================
    // 4) نقطة الحبر الحالية (توهج عند موقع القلم)
    // ============================================================
    final dotPaint = Paint()
      ..color = accentColor.withOpacity(isDark ? 0.9 : 0.7)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawCircle(Offset(trailEndX, penY), 4.0, dotPaint);

    // نقطة صغيرة لامعة
    final brightDot = Paint()
      ..color = Colors.white.withOpacity(isDark ? 0.9 : 0.7)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(trailEndX, penY), 1.5, brightDot);

    // ============================================================
    // 5) رشّات حبر صغيرة على طول الأثر (Ink Splatter)
    // ============================================================
    final random = math.Random(7); // ثابت للاستقرار
    final trailLength = trailEndX - trailStartX;
    final splatterCount = (trailLength / 40).floor().clamp(0, 12);

    for (int i = 0; i < splatterCount; i++) {
      final t = random.nextDouble();
      final sx = trailStartX + (trailLength * t);
      final sy = penY + (random.nextDouble() - 0.5) * 10;
      final splatterSize = 0.6 + random.nextDouble() * 1.4;
      // شفافية الرشّة تقل كلما اقتربنا من البداية
      final splatterOpacity = t * (isDark ? 0.7 : 0.5);

      final splatterPaint = Paint()
        ..color = accentColor.withOpacity(splatterOpacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(sx, sy), splatterSize, splatterPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _InkTrailPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.penX != penX ||
        oldDelegate.color != color;
  }
}

// =================================================================
// ✨ DOT GRID PAINTER
// =================================================================

class _DotGridPainter extends CustomPainter {
  final Color color;
  final double spacing;
  final double dotSize;

  _DotGridPainter({required this.color, this.spacing = 40, this.dotSize = 1.2});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

// =================================================================
// ✨ LIGHT STREAK PAINTER
// =================================================================

class _LightStreakPainter extends CustomPainter {
  final double progress;
  final Color color1;
  final Color color2;

  _LightStreakPainter({
    required this.progress,
    required this.color1,
    required this.color2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawStreak(
      canvas,
      size,
      startX: -200 + progress * 800,
      width: 120,
      color: color1,
    );
    _drawStreak(
      canvas,
      size,
      startX: -400 + progress * 900,
      width: 80,
      color: color2,
    );
    _drawStreak(
      canvas,
      size,
      startX: -600 + progress * 1000,
      width: 160,
      color: color1.withOpacity(0.5),
    );
  }

  void _drawStreak(
    Canvas canvas,
    Size size, {
    required double startX,
    required double width,
    required Color color,
  }) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [color.withOpacity(0.0), color, color.withOpacity(0.0)],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(startX, 0, width, size.height));

    final path = Path()
      ..moveTo(startX, -50)
      ..lineTo(startX + width, -50)
      ..lineTo(startX + width + size.height, size.height + 50)
      ..lineTo(startX + size.height, size.height + 50)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LightStreakPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// =================================================================
// ✍️ HANDWRITTEN TEXT WIDGET
// =================================================================

class _HandwrittenText extends StatelessWidget {
  final String text;
  final double progress;
  final Color color;
  final Color accentColor;
  final bool isDark;

  const _HandwrittenText({
    required this.text,
    required this.progress,
    required this.color,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final chars = text.split('');
    final totalChars = chars.length;
    final charProgress = (progress * totalChars).clamp(
      0.0,
      totalChars.toDouble(),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalChars, (index) {
        final reveal = (charProgress - index).clamp(0.0, 1.0);

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 60),
          opacity: reveal,
          child: Transform.translate(
            offset: Offset(0, (1 - reveal) * 8),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [accentColor, color],
                ).createShader(bounds);
              },
              child: Text(
                chars[index],
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: Colors.white,
                  height: 1.0,
                  shadows: [
                    Shadow(
                      color: color.withOpacity(isDark ? 0.7 : 0.35),
                      blurRadius: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// =================================================================
// ✍️ PEN WIDGET
// =================================================================

class _PenWidget extends StatelessWidget {
  final Color color;
  final Color accentColor;
  final bool isDark;

  const _PenWidget({
    required this.color,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ],
      ),
      child: CustomPaint(
        painter: _PenPainter(color: color, accentColor: accentColor),
      ),
    );
  }
}

class _PenPainter extends CustomPainter {
  final Color color;
  final Color accentColor;

  _PenPainter({required this.color, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.35);
    canvas.translate(-size.width / 2, -size.height / 2);

    // جسم القلم
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(14, 0, 16, 42),
      const Radius.circular(3),
    );

    paint.shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [color.withOpacity(0.6), color, accentColor],
    ).createShader(bodyRect.outerRect);

    canvas.drawRRect(bodyRect, paint);

    // حلقة القلم
    paint.shader = null;
    paint.color = accentColor.withOpacity(0.9);
    canvas.drawRect(const Rect.fromLTWH(14, 36, 16, 3), paint);

    // رأس القلم
    final tipPath = Path()
      ..moveTo(14, 42)
      ..lineTo(30, 42)
      ..lineTo(22, 58)
      ..close();

    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color, accentColor],
    ).createShader(tipPath.getBounds());

    canvas.drawPath(tipPath, paint);

    // نقطة الحبر
    paint.shader = null;
    paint.color = accentColor;
    canvas.drawCircle(const Offset(22, 58), 2.0, paint);

    // وهج
    paint.color = accentColor.withOpacity(0.35);
    canvas.drawCircle(const Offset(22, 58), 6.0, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PenPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accentColor != accentColor;
  }
}
