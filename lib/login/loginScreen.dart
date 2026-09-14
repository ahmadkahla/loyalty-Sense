//
//
// import 'dart:async';
// import 'dart:ui';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../complete_profile_screen.dart';
// import '../home.dart';
//
// const Color kSenseColor = Color(0xFF990056);
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen>
//     with TickerProviderStateMixin {
//   // ============================================================
//   // SETTINGS
//   // ============================================================
//
//   static const String testOtp = '1234';
//
//   // ============================================================
//   // CONTROLLERS
//   // ============================================================
//
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//
//   final FocusNode _phoneFocusNode = FocusNode();
//   final FocusNode _otpFocusNode = FocusNode();
//
//   // ============================================================
//   // STATE
//   // ============================================================
//
//   bool _isLoading = false;
//   bool _showOtpScreen = false;
//   bool _otpVerified = false;
//
//   // ============================================================
//   // TIMER
//   // ============================================================
//
//   Timer? _otpTimer;
//   int _secondsRemaining = 60;
//
//   // ============================================================
//   // MAIN ANIMATION
//   // ============================================================
//
//   late final AnimationController _animationController;
//   late final Animation<double> _scaleAnimation;
//
//   // ============================================================
//   // SUCCESS ANIMATION
//   // ============================================================
//
//   late final AnimationController _successAnimationController;
//   late final Animation<double> _successScaleAnimation;
//   late final Animation<double> _successRotationAnimation;
//   late final Animation<double> _successGlowAnimation;
//
//   // ============================================================
//   // INIT
//   // ============================================================
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 450),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.96, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );
//
//     _successAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 850),
//     );
//
//     _successScaleAnimation = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween<double>(
//           begin: 0.75,
//           end: 1.18,
//         ).chain(CurveTween(curve: Curves.easeOutBack)),
//         weight: 55,
//       ),
//       TweenSequenceItem(
//         tween: Tween<double>(
//           begin: 1.18,
//           end: 1.0,
//         ).chain(CurveTween(curve: Curves.elasticOut)),
//         weight: 45,
//       ),
//     ]).animate(_successAnimationController);
//
//     _successRotationAnimation = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween<double>(
//           begin: -0.12,
//           end: 0.035,
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 55,
//       ),
//       TweenSequenceItem(
//         tween: Tween<double>(
//           begin: 0.035,
//           end: 0.0,
//         ).chain(CurveTween(curve: Curves.easeOutBack)),
//         weight: 45,
//       ),
//     ]).animate(_successAnimationController);
//
//     _successGlowAnimation = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween<double>(
//           begin: 0.0,
//           end: 1.0,
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 45,
//       ),
//       TweenSequenceItem(
//         tween: Tween<double>(
//           begin: 1.0,
//           end: 0.55,
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 55,
//       ),
//     ]).animate(_successAnimationController);
//
//     _animationController.forward();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         _phoneFocusNode.requestFocus();
//       }
//     });
//   }
//
//   // ============================================================
//   // DISPOSE
//   // ============================================================
//
//   @override
//   void dispose() {
//     _otpTimer?.cancel();
//
//     _phoneController.dispose();
//     _otpController.dispose();
//
//     _phoneFocusNode.dispose();
//     _otpFocusNode.dispose();
//
//     _animationController.dispose();
//     _successAnimationController.dispose();
//
//     super.dispose();
//   }
//
//   // ============================================================
//   // PHONE VALIDATION
//   // ============================================================
//
//   bool _isValidPhone() {
//     final phone = _phoneController.text.trim();
//     final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
//
//     return digitsOnly.length >= 8 && digitsOnly.length <= 15;
//   }
//
//   // ============================================================
//   // SEND OTP
//   // ============================================================
//
//   Future<void> _sendOtp() async {
//     if (_isLoading) return;
//
//     if (!_isValidPhone()) {
//       _showMessage(
//         message: 'Pleaseـenterـaـvalidـphoneـnumber'.tr(),
//         icon: Icons.phone_outlined,
//       );
//
//       return;
//     }
//
//     FocusScope.of(context).unfocus();
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     await Future.delayed(const Duration(milliseconds: 700));
//
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = false;
//       _showOtpScreen = true;
//       _otpVerified = false;
//       _secondsRemaining = 60;
//     });
//
//     _otpController.clear();
//
//     _startOtpTimer();
//
//     _animationController.reset();
//     _animationController.forward();
//
//     Future.delayed(const Duration(milliseconds: 250), () {
//       if (mounted) {
//         _otpFocusNode.requestFocus();
//       }
//     });
//   }
//
//   // ============================================================
//   // OTP TIMER
//   // ============================================================
//
//   void _startOtpTimer() {
//     _otpTimer?.cancel();
//
//     _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (!mounted) {
//         timer.cancel();
//         return;
//       }
//
//       if (_secondsRemaining <= 1) {
//         timer.cancel();
//
//         setState(() {
//           _secondsRemaining = 0;
//         });
//       } else {
//         setState(() {
//           _secondsRemaining--;
//         });
//       }
//     });
//   }
//
//   // ============================================================
//   // VERIFY OTP
//   // ============================================================
//
//   Future<void> _verifyOtp() async {
//     if (_isLoading) return;
//
//     final otp = _otpController.text.trim();
//
//     if (otp.length != 4) {
//       _showMessage(
//         message: 'Please_enter_the_4-digit_verification_code'.tr(),
//         icon: Icons.lock_outline_rounded,
//       );
//
//       return;
//     }
//
//     if (otp != testOtp) {
//       _showMessage(
//         message: 'Incorrect_verification_code'.tr(),
//         icon: Icons.error_outline_rounded,
//       );
//
//       _otpController.clear();
//
//       Future.delayed(const Duration(milliseconds: 100), () {
//         if (mounted) {
//           _otpFocusNode.requestFocus();
//         }
//       });
//
//       return;
//     }
//
//     FocusScope.of(context).unfocus();
//
//     setState(() {
//       _isLoading = true;
//       _otpVerified = true;
//     });
//
//     _successAnimationController.reset();
//
//     await _successAnimationController.forward();
//
//     if (!mounted) return;
//
//     await Future.delayed(const Duration(milliseconds: 350));
//
//     if (!mounted) return;
//
//     // ==========================================================
//     // ✅ تحقق: هل الرقم مسجل من قبل؟
//     // ==========================================================
//     final prefs = await SharedPreferences.getInstance();
//     final savedPhone = prefs.getString('user_phone') ?? '';
//     final currentPhone = _displayPhone();
//
//     if (!mounted) return;
//
//     if (savedPhone == currentPhone && savedPhone.isNotEmpty) {
//       final savedName = prefs.getString('user_name') ?? 'User';
//
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           transitionDuration: const Duration(milliseconds: 650),
//           reverseTransitionDuration: const Duration(milliseconds: 300),
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return HomeScreen(userName: savedName);
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             final curved = CurvedAnimation(
//               parent: animation,
//               curve: Curves.easeOutCubic,
//             );
//
//             return FadeTransition(
//               opacity: curved,
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(0, 0.025),
//                   end: Offset.zero,
//                 ).animate(curved),
//                 child: child,
//               ),
//             );
//           },
//         ),
//       );
//
//       return;
//     }
//
//     Navigator.of(context).pushReplacement(
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 650),
//         reverseTransitionDuration: const Duration(milliseconds: 300),
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return CompleteProfileScreen(phoneNumber: currentPhone);
//         },
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           final curved = CurvedAnimation(
//             parent: animation,
//             curve: Curves.easeOutCubic,
//           );
//
//           return FadeTransition(
//             opacity: curved,
//             child: SlideTransition(
//               position: Tween<Offset>(
//                 begin: const Offset(0, 0.025),
//                 end: Offset.zero,
//               ).animate(curved),
//               child: child,
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ============================================================
//   // BACK TO PHONE
//   // ============================================================
//
//   void _backToPhone() {
//     if (_isLoading) return;
//
//     FocusScope.of(context).unfocus();
//
//     _otpTimer?.cancel();
//
//     _successAnimationController.reset();
//
//     setState(() {
//       _showOtpScreen = false;
//       _otpVerified = false;
//       _secondsRemaining = 60;
//     });
//
//     _otpController.clear();
//
//     _animationController.reset();
//     _animationController.forward();
//
//     Future.delayed(const Duration(milliseconds: 200), () {
//       if (mounted) {
//         _phoneFocusNode.requestFocus();
//       }
//     });
//   }
//
//   // ============================================================
//   // RESEND OTP
//   // ============================================================
//
//   Future<void> _resendOtp() async {
//     if (_isLoading || _secondsRemaining > 0) {
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     await Future.delayed(const Duration(milliseconds: 600));
//
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = false;
//       _secondsRemaining = 60;
//     });
//
//     _startOtpTimer();
//
//     _showMessage(
//       message: 'A_new_verification_code_has_been_sent'.tr(),
//       icon: Icons.check_circle_outline_rounded,
//     );
//   }
//
//   // ============================================================
//   // MESSAGE
//   // ============================================================
//
//   void _showMessage({required String message, required IconData icon}) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(icon, color: Colors.white, size: 21),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 message,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   // ============================================================
//   // DISPLAY PHONE
//   // ============================================================
//
//   String _displayPhone() {
//     final phone = _phoneController.text.trim();
//
//     if (phone.isEmpty) {
//       return '';
//     }
//
//     return phone;
//   }
//
//   // ============================================================
//   // ✅ HELPER: هل الشاشة صغيرة؟
//   // ============================================================
//
//   bool _isSmallScreen(BuildContext context) {
//     return MediaQuery.of(context).size.width < 360;
//   }
//
//   bool _isKeyboardOpen(BuildContext context) {
//     return MediaQuery.of(context).viewInsets.bottom > 0;
//   }
//
//   // ============================================================
//   // BUILD
//   // ============================================================
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmall = _isSmallScreen(context);
//     final isKeyboardOpen = _isKeyboardOpen(context);
//
//     // 👈 أحجام responsive
//     final horizontalPadding = isSmall ? 16.0 : 22.0;
//     final verticalPadding = isSmall ? 16.0 : 24.0;
//     final maxWidth = isSmall ? screenWidth : 430.0;
//     final topSpacing = isKeyboardOpen ? 16.0 : (isSmall ? 30.0 : 60.0);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FC),
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // ======================================================
//           // BACKGROUND
//           // ======================================================
//           const _PremiumBackground(),
//
//           // ======================================================
//           // LARGE LOGO (يختفي لما الكيبورد يفتح)
//           // ======================================================
//           if (!isKeyboardOpen)
//             Positioned(
//               top: -40,
//               left: -30,
//               right: -30,
//               child: IgnorePointer(
//                 child: Opacity(
//                   opacity: 0.075,
//                   child: Image.asset(
//                     'assets/logo.png',
//                     height: 390,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//
//           // ======================================================
//           // CONTENT
//           // ======================================================
//           // 👈 ملاحظة: Center جوّا الـ SingleChildScrollView
//           // عشان نتجنب الـ overflow
//           // ======================================================
//           SafeArea(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: horizontalPadding,
//                     vertical: verticalPadding,
//                   ),
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight - (verticalPadding * 2),
//                     ),
//                     child: Center(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(maxWidth: maxWidth),
//                         child: ScaleTransition(
//                           scale: _scaleAnimation,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SizedBox(height: topSpacing),
//
//                               // ==================================================
//                               // TITLE
//                               // ==================================================
//                               AnimatedSwitcher(
//                                 duration: const Duration(milliseconds: 300),
//                                 child: Text(
//                                   _showOtpScreen
//                                       ? 'Verify_Your_Phone'.tr()
//                                       : 'Welcome_Back'.tr(),
//                                   key: ValueKey(_showOtpScreen),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: isSmall ? 26 : 31,
//                                     fontWeight: FontWeight.w800,
//                                     letterSpacing: -0.8,
//                                     color: const Color(0xFF15182A),
//                                   ),
//                                 ),
//                               ),
//
//                               const SizedBox(height: 8),
//
//                               // ==================================================
//                               // SUBTITLE
//                               // ==================================================
//                               AnimatedSwitcher(
//                                 duration: const Duration(milliseconds: 300),
//                                 child: _showOtpScreen
//                                     ? Text(
//                                         '${'Enter_the_4-digit_code_sent_to'.tr()}\n${_displayPhone()}',
//                                         key: const ValueKey('otpSubtitle'),
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: isSmall ? 13.5 : 14.5,
//                                           fontWeight: FontWeight.w500,
//                                           height: 1.5,
//                                           color: const Color(
//                                             0xFF555B70,
//                                           ).withOpacity(0.9),
//                                         ),
//                                       )
//                                     : Text(
//                                         'Enter_your_phone_number_to_continue'
//                                             .tr(),
//                                         key: ValueKey('phoneSubtitle'.tr()),
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontSize: isSmall ? 13.5 : 14.5,
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xFF555B70),
//                                         ),
//                                       ),
//                               ),
//
//                               SizedBox(height: isSmall ? 20 : 27),
//
//                               // ==================================================
//                               // CARD
//                               // ==================================================
//                               AnimatedSwitcher(
//                                 duration: const Duration(milliseconds: 350),
//                                 switchInCurve: Curves.easeOutBack,
//                                 switchOutCurve: Curves.easeIn,
//                                 child: _showOtpScreen
//                                     ? _buildOtpCard(context, isSmall)
//                                     : _buildPhoneCard(context, isSmall),
//                               ),
//
//                               const SizedBox(height: 22),
//
//                               // ==================================================
//                               // SECURITY
//                               // ==================================================
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.verified_user_rounded,
//                                     size: 15,
//                                     color: const Color(
//                                       0xFF687087,
//                                     ).withOpacity(0.75),
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Flexible(
//                                     child: Text(
//                                       'Secure_access'.tr(),
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: const Color(
//                                           0xFF687087,
//                                         ).withOpacity(0.75),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // PHONE CARD
//   // ============================================================
//
//   Widget _buildPhoneCard(BuildContext context, bool isSmall) {
//     final cardPadding = isSmall ? 20.0 : 24.0;
//     final iconSize = isSmall ? 60.0 : 72.0;
//     final radius = isSmall ? 26.0 : 32.0;
//
//     return ClipRRect(
//       key: const ValueKey('phoneCard'),
//       borderRadius: BorderRadius.circular(radius),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//         child: Container(
//           padding: EdgeInsets.fromLTRB(
//             cardPadding,
//             cardPadding + 3,
//             cardPadding,
//             cardPadding - 2,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.62),
//             borderRadius: BorderRadius.circular(radius),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.90),
//               width: 1.2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.07),
//                 blurRadius: 40,
//                 spreadRadius: -5,
//                 offset: const Offset(0, 22),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ==================================================
//               // PHONE ICON
//               // ==================================================
//               Container(
//                 width: iconSize,
//                 height: iconSize,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [Color(0xFFFFE6F3), Color(0xFFF8D0E4)],
//                   ),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.95),
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.phone_rounded,
//                   size: isSmall ? 28 : 32,
//                   color: kSenseColor,
//                 ),
//               ),
//
//               const SizedBox(height: 17),
//
//               Text(
//                 'Enter your phone number',
//                 style: TextStyle(
//                   fontSize: isSmall ? 13 : 14,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF596075),
//                 ),
//               ),
//
//               const SizedBox(height: 19),
//
//               // ==================================================
//               // PHONE FIELD
//               // ==================================================
//               TextField(
//                 controller: _phoneController,
//                 focusNode: _phoneFocusNode,
//                 enabled: !_isLoading,
//                 keyboardType: TextInputType.phone,
//                 textInputAction: TextInputAction.done,
//                 onSubmitted: (_) {
//                   if (!_isLoading) {
//                     _sendOtp();
//                   }
//                 },
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'[0-9+\- ()]')),
//                 ],
//                 onChanged: (_) {
//                   if (mounted) {
//                     setState(() {});
//                   }
//                 },
//                 style: TextStyle(
//                   fontSize: isSmall ? 16 : 18,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF171A2D),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: '07X XXX XXXX',
//                   hintStyle: TextStyle(
//                     fontSize: isSmall ? 14 : 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.20),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.phone_outlined,
//                     color: kSenseColor.withOpacity(0.70),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.55),
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: isSmall ? 14 : 18,
//                     vertical: isSmall ? 14 : 18,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(19),
//                     borderSide: BorderSide(
//                       color: kSenseColor.withOpacity(0.18),
//                       width: 1.2,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(19),
//                     borderSide: BorderSide(
//                       color: kSenseColor.withOpacity(0.22),
//                       width: 1.2,
//                     ),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(19)),
//                     borderSide: BorderSide(color: kSenseColor, width: 1.6),
//                   ),
//                   disabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(19),
//                     borderSide: BorderSide(
//                       color: kSenseColor.withOpacity(0.10),
//                       width: 1.0,
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 23),
//
//               // ==================================================
//               // CONTINUE
//               // ==================================================
//               _buildPrimaryButton(
//                 text: 'Continue',
//                 icon: Icons.arrow_forward_rounded,
//                 loading: _isLoading,
//                 enabled: !_isLoading && _isValidPhone(),
//                 onPressed: _sendOtp,
//                 isSmall: isSmall,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // OTP CARD
//   // ============================================================
//
//   Widget _buildOtpCard(BuildContext context, bool isSmall) {
//     final cardPadding = isSmall ? 20.0 : 24.0;
//     final iconSize = isSmall ? 60.0 : 72.0;
//     final radius = isSmall ? 26.0 : 32.0;
//
//     // 👈 OTP box sizes - responsive
//     final otpBoxWidth = isSmall ? 62.0 : 76.0;
//     final otpBoxHeight = isSmall ? 56.0 : 68.0;
//     final otpBoxSpacing = isSmall ? 8.0 : 12.0;
//
//     return ClipRRect(
//       key: const ValueKey('otpCard'),
//       borderRadius: BorderRadius.circular(radius),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//         child: Container(
//           padding: EdgeInsets.fromLTRB(
//             cardPadding,
//             cardPadding + 3,
//             cardPadding,
//             cardPadding - 2,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.62),
//             borderRadius: BorderRadius.circular(radius),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.90),
//               width: 1.2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.07),
//                 blurRadius: 40,
//                 spreadRadius: -5,
//                 offset: const Offset(0, 22),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ==================================================
//               // OTP ICON
//               // ==================================================
//               _buildOtpIcon(isSmall),
//
//               const SizedBox(height: 17),
//
//               // ==================================================
//               // STATUS
//               // ==================================================
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 250),
//                 child: Text(
//                   _otpVerified
//                       ? 'Phone number verified!'
//                       : 'Enter your 4-digit verification code',
//                   key: ValueKey(_otpVerified),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: isSmall ? 13 : 14,
//                     fontWeight: FontWeight.w600,
//                     color: _otpVerified ? kSenseColor : const Color(0xFF596075),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 19),
//
//               // ==================================================
//               // OTP FIELD - 4 SEPARATE BOXES
//               // ==================================================
//               SizedBox(
//                 height: otpBoxHeight + 6,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // الإدخال الحقيقي
//                     Positioned.fill(
//                       child: Opacity(
//                         opacity: 0.01,
//                         child: TextField(
//                           controller: _otpController,
//                           focusNode: _otpFocusNode,
//                           enabled: !_isLoading,
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.done,
//                           maxLength: 4,
//                           autofocus: false,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                             LengthLimitingTextInputFormatter(4),
//                           ],
//                           onSubmitted: (_) {
//                             if (!_isLoading &&
//                                 _otpController.text.length == 4) {
//                               _verifyOtp();
//                             }
//                           },
//                           onChanged: (_) {
//                             if (mounted) {
//                               setState(() {});
//                             }
//                           },
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             counterText: '',
//                             contentPadding: EdgeInsets.zero,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // ==================================================
//                     // FOUR OTP BOXES
//                     // ==================================================
//                     IgnorePointer(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: List.generate(4, (index) {
//                           final String otp = _otpController.text;
//                           final bool hasValue = index < otp.length;
//                           final bool isCurrent =
//                               _otpFocusNode.hasFocus &&
//                               index == otp.length.clamp(0, 3);
//
//                           return AnimatedContainer(
//                             duration: const Duration(milliseconds: 180),
//                             curve: Curves.easeOut,
//                             width: otpBoxWidth,
//                             height: otpBoxHeight,
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.72),
//                               borderRadius: BorderRadius.circular(
//                                 isSmall ? 16 : 19,
//                               ),
//                               border: Border.all(
//                                 color: isCurrent
//                                     ? kSenseColor
//                                     : kSenseColor.withOpacity(0.12),
//                                 width: isCurrent ? 1.8 : 1.2,
//                               ),
//                               boxShadow: isCurrent
//                                   ? [
//                                       BoxShadow(
//                                         color: kSenseColor.withOpacity(0.14),
//                                         blurRadius: 10,
//                                         spreadRadius: 1,
//                                       ),
//                                     ]
//                                   : [],
//                             ),
//                             child: Center(
//                               child: Text(
//                                 hasValue ? otp[index] : '',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: isSmall ? 22 : 27,
//                                   fontWeight: FontWeight.w700,
//                                   color: const Color(0xFF171A2D),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 14),
//
//               // ==================================================
//               // OTP PROGRESS
//               // ==================================================
//               _buildOtpProgress(),
//
//               const SizedBox(height: 16),
//
//               // ==================================================
//               // RESEND
//               // ==================================================
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       'Didn’t receive the code?',
//                       style: TextStyle(
//                         fontSize: isSmall ? 11 : 12,
//                         fontWeight: FontWeight.w500,
//                         color: const Color(0xFF687087).withOpacity(0.85),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(width: 6),
//
//                   GestureDetector(
//                     onTap: _secondsRemaining == 0 && !_isLoading
//                         ? _resendOtp
//                         : null,
//                     child: Text(
//                       _secondsRemaining > 0
//                           ? 'Resend in ${_secondsRemaining}s'
//                           : 'Resend',
//                       style: TextStyle(
//                         fontSize: isSmall ? 11 : 12,
//                         fontWeight: FontWeight.w700,
//                         color: _secondsRemaining == 0 && !_isLoading
//                             ? kSenseColor
//                             : Colors.grey.shade400,
//                         decoration: _secondsRemaining == 0 && !_isLoading
//                             ? TextDecoration.underline
//                             : null,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 23),
//
//               // ==================================================
//               // VERIFY BUTTON
//               // ==================================================
//               _buildPrimaryButton(
//                 text: 'Verify & Continue',
//                 icon: Icons.arrow_forward_rounded,
//                 loading: _isLoading,
//                 enabled: !_isLoading && _otpController.text.length == 4,
//                 onPressed: _verifyOtp,
//                 isSmall: isSmall,
//               ),
//
//               const SizedBox(height: 8),
//
//               // ==================================================
//               // CHANGE PHONE
//               // ==================================================
//               TextButton(
//                 onPressed: _isLoading ? null : _backToPhone,
//                 style: TextButton.styleFrom(foregroundColor: kSenseColor),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.arrow_back_rounded, size: 17),
//                     const SizedBox(width: 5),
//                     Text(
//                       'Change phone number',
//                       style: TextStyle(
//                         fontSize: isSmall ? 12 : 13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // OTP ICON SUCCESS ANIMATION
//   // ============================================================
//
//   Widget _buildOtpIcon(bool isSmall) {
//     final size = isSmall ? 60.0 : 72.0;
//
//     return AnimatedBuilder(
//       animation: _successAnimationController,
//       builder: (context, child) {
//         final double scale = _otpVerified ? _successScaleAnimation.value : 1.0;
//         final double rotation = _otpVerified
//             ? _successRotationAnimation.value
//             : 0.0;
//         final double glow = _otpVerified ? _successGlowAnimation.value : 0.0;
//
//         return Transform.scale(
//           scale: scale,
//           child: Transform.rotate(
//             angle: rotation,
//             child: Container(
//               width: size,
//               height: size,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: _otpVerified
//                     ? const LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [Color(0xFFFFE6F3), Color(0xFFF4C4DB)],
//                       )
//                     : const LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [Color(0xFFFFE6F3), Color(0xFFF8D0E4)],
//                       ),
//                 border: Border.all(
//                   color: Colors.white.withOpacity(0.95),
//                   width: 1.5,
//                 ),
//                 boxShadow: _otpVerified
//                     ? [
//                         BoxShadow(
//                           color: kSenseColor.withOpacity(0.28 * glow),
//                           blurRadius: 28,
//                           spreadRadius: 6 * glow,
//                           offset: const Offset(0, 5),
//                         ),
//                       ]
//                     : [],
//               ),
//               child: Center(
//                 child: AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 350),
//                   switchInCurve: Curves.elasticOut,
//                   switchOutCurve: Curves.easeIn,
//                   transitionBuilder: (child, animation) {
//                     return ScaleTransition(
//                       scale: animation,
//                       child: FadeTransition(opacity: animation, child: child),
//                     );
//                   },
//                   child: Icon(
//                     _otpVerified ? Icons.check_rounded : Icons.verified_rounded,
//                     key: ValueKey(_otpVerified),
//                     size: _otpVerified
//                         ? (isSmall ? 32 : 39)
//                         : (isSmall ? 26 : 32),
//                     color: kSenseColor,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // ============================================================
//   // PRIMARY BUTTON
//   // ============================================================
//
//   Widget _buildPrimaryButton({
//     required String text,
//     required IconData icon,
//     required bool loading,
//     required bool enabled,
//     required VoidCallback onPressed,
//     required bool isSmall,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: isSmall ? 52 : 56,
//       child: ElevatedButton(
//         onPressed: enabled ? onPressed : null,
//         style: ElevatedButton.styleFrom(
//           elevation: 0,
//           backgroundColor: kSenseColor,
//           disabledBackgroundColor: Colors.black.withOpacity(0.07),
//           foregroundColor: Colors.white,
//           disabledForegroundColor: Colors.black.withOpacity(0.25),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18),
//           ),
//         ),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 250),
//           child: loading
//               ? const SizedBox(
//                   key: ValueKey('loading'),
//                   width: 23,
//                   height: 23,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.5,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 )
//               : Row(
//                   key: ValueKey(text),
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         text,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: isSmall ? 14 : 16,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 9),
//                     Icon(icon, size: isSmall ? 19 : 21),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // OTP PROGRESS
//   // ============================================================
//
//   Widget _buildOtpProgress() {
//     final int length = _otpController.text.length;
//
//     return Row(
//       children: List.generate(4, (index) {
//         final bool active = index < length;
//
//         return Expanded(
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 220),
//             curve: Curves.easeOut,
//             height: 4.5,
//             margin: EdgeInsets.only(right: index == 3 ? 0 : 7),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               gradient: active
//                   ? const LinearGradient(
//                       colors: [kSenseColor, Color(0xFFB82A78)],
//                     )
//                   : null,
//               color: active ? null : Colors.black.withOpacity(0.08),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//
// // =================================================================
// // PREMIUM BACKGROUND
// // =================================================================
//
// class _PremiumBackground extends StatelessWidget {
//   const _PremiumBackground();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFF7F8FF), Color(0xFFF0F2FB), Color(0xFFFFF8FC)],
//         ),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: -150,
//             right: -120,
//             child: _GlowCircle(size: 380, color: const Color(0xFFF4C8DF)),
//           ),
//           Positioned(
//             top: 120,
//             left: -180,
//             child: _GlowCircle(size: 340, color: const Color(0xFFF7D9E9)),
//           ),
//           Positioned(
//             bottom: -170,
//             right: -100,
//             child: _GlowCircle(size: 390, color: const Color(0xFFF8DDEB)),
//           ),
//           Positioned(
//             bottom: -160,
//             left: -140,
//             child: _GlowCircle(size: 320, color: const Color(0xFFF3D5E5)),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // =================================================================
// // GLOW CIRCLE
// // =================================================================
//
// class _GlowCircle extends StatelessWidget {
//   final double size;
//   final Color color;
//
//   const _GlowCircle({required this.size, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return ImageFiltered(
//       imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
//       child: Container(
//         width: size,
//         height: size,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: color.withOpacity(0.45),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_all/api_failure.dart';
import '../app_all/repo.dart';
import 'id_input_screen.dart';

const Color kSenseColor = Color(0xFF990056);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // ============================================================
  // SETTINGS
  // ============================================================

  static const String testOtp = '1234';
  static const String defaultCountryCode = '962'; // ← عدّل حسب بلدك

  // ============================================================
  // REPO
  // ============================================================

  final AuthRepo _authRepo = AuthRepo();

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _otpFocusNode = FocusNode();

  // ============================================================
  // STATE
  // ============================================================

  bool _isLoading = false;
  bool _showOtpScreen = false;
  bool _otpVerified = false;

  // ============================================================
  // TIMER
  // ============================================================

  Timer? _otpTimer;
  int _secondsRemaining = 60;

  // ============================================================
  // MAIN ANIMATION
  // ============================================================

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  // ============================================================
  // SUCCESS ANIMATION
  // ============================================================

  late final AnimationController _successAnimationController;
  late final Animation<double> _successScaleAnimation;
  late final Animation<double> _successRotationAnimation;
  late final Animation<double> _successGlowAnimation;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _successAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _successScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.75,
          end: 1.18,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.18,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 45,
      ),
    ]).animate(_successAnimationController);

    _successRotationAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -0.12,
          end: 0.035,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.035,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 45,
      ),
    ]).animate(_successAnimationController);

    _successGlowAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.55,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 55,
      ),
    ]).animate(_successAnimationController);

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _phoneFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _otpTimer?.cancel();
    _phoneController.dispose();
    _otpController.dispose();
    _phoneFocusNode.dispose();
    _otpFocusNode.dispose();
    _animationController.dispose();
    _successAnimationController.dispose();
    super.dispose();
  }

  // ============================================================
  // PHONE VALIDATION
  // ============================================================

  bool _isValidPhone() {
    final phone = _phoneController.text.trim();
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 8 && digitsOnly.length <= 15;
  }

  // ============================================================
  // SEND OTP — API حقيقي
  // ============================================================

  Future<void> _sendOtp() async {
    if (_isLoading) return;

    if (!_isValidPhone()) {
      _showMessage(
        message: 'Pleaseـenterـaـvalidـphoneـnumber'.tr(),
        icon: Icons.phone_outlined,
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() => _isLoading = true);

    final mobile = _phoneController.text.trim();

    final result = await _authRepo.sendOTP(
      mobile: mobile,
      countryCode: defaultCountryCode,
    );

    if (!mounted) return;

    result.fold(
      // ✅ Success
      (success) {
        setState(() {
          _isLoading = false;
          _showOtpScreen = true;
          _otpVerified = false;
          _secondsRemaining = 60;
        });

        _otpController.clear();
        _startOtpTimer();

        _animationController.reset();
        _animationController.forward();

        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) _otpFocusNode.requestFocus();
        });
      },
      // ❌ Failure
      (failure) {
        setState(() => _isLoading = false);
        final msg = failure is APIFailure
            ? failure.message
            : failure.toString();
        _showMessage(message: msg, icon: Icons.error_outline_rounded);
      },
    );
  }

  // ============================================================
  // OTP TIMER
  // ============================================================

  void _startOtpTimer() {
    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  // ============================================================
  // VERIFY OTP — محلي (1234)
  // ============================================================

  Future<void> _verifyOtp() async {
    if (_isLoading) return;

    final otp = _otpController.text.trim();

    if (otp.length != 4) {
      _showMessage(
        message: 'Please_enter_the_4-digit_verification_code'.tr(),
        icon: Icons.lock_outline_rounded,
      );
      return;
    }

    // ⚠️ تحقق محلي (لأنو OTP الحقيقي مو شغال)
    if (otp != testOtp) {
      _showMessage(
        message: 'Incorrect_verification_code'.tr(),
        icon: Icons.error_outline_rounded,
      );
      _otpController.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _otpFocusNode.requestFocus();
      });
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _otpVerified = true;
    });

    _successAnimationController.reset();
    await _successAnimationController.forward();

    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;

    // نخزن الرقم مؤقتًا ونروح لشاشة الـ ID
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pending_phone', _displayPhone());

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) =>
            IdInputScreen(phoneNumber: _displayPhone()),
        transitionsBuilder: (_, animation, __, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.025),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // BACK TO PHONE
  // ============================================================

  void _backToPhone() {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    _otpTimer?.cancel();
    _successAnimationController.reset();
    setState(() {
      _showOtpScreen = false;
      _otpVerified = false;
      _secondsRemaining = 60;
    });
    _otpController.clear();
    _animationController.reset();
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _phoneFocusNode.requestFocus();
    });
  }

  // ============================================================
  // RESEND OTP — API حقيقي
  // ============================================================

  Future<void> _resendOtp() async {
    if (_isLoading || _secondsRemaining > 0) return;

    setState(() => _isLoading = true);

    final result = await _authRepo.sendOTP(
      mobile: _phoneController.text.trim(),
      countryCode: defaultCountryCode,
    );

    if (!mounted) return;

    result.fold(
      (_) {
        setState(() {
          _isLoading = false;
          _secondsRemaining = 60;
        });
        _startOtpTimer();
        _showMessage(
          message: 'A_new_verification_code_has_been_sent'.tr(),
          icon: Icons.check_circle_outline_rounded,
        );
      },
      (failure) {
        setState(() => _isLoading = false);
        final msg = failure is APIFailure
            ? failure.message
            : failure.toString();
        _showMessage(message: msg, icon: Icons.error_outline_rounded);
      },
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage({required String message, required IconData icon}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 21),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // DISPLAY PHONE
  // ============================================================

  String _displayPhone() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return '';
    return phone;
  }

  bool _isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 360;

  bool _isKeyboardOpen(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = _isSmallScreen(context);
    final isKeyboardOpen = _isKeyboardOpen(context);

    final horizontalPadding = isSmall ? 16.0 : 22.0;
    final verticalPadding = isSmall ? 16.0 : 24.0;
    final maxWidth = isSmall ? screenWidth : 430.0;
    final topSpacing = isKeyboardOpen ? 16.0 : (isSmall ? 30.0 : 60.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _PremiumBackground(),
          if (!isKeyboardOpen)
            Positioned(
              top: -40,
              left: -30,
              right: -30,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.075,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 390,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - (verticalPadding * 2),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: topSpacing),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Text(
                                  _showOtpScreen
                                      ? 'Verify_Your_Phone'.tr()
                                      : 'Welcome_Back'.tr(),
                                  key: ValueKey(_showOtpScreen),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isSmall ? 26 : 31,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.8,
                                    color: const Color(0xFF15182A),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: _showOtpScreen
                                    ? Text(
                                        '${'Enter_the_4-digit_code_sent_to'.tr()}\n${_displayPhone()}',
                                        key: const ValueKey('otpSubtitle'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: isSmall ? 13.5 : 14.5,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5,
                                          color: const Color(
                                            0xFF555B70,
                                          ).withOpacity(0.9),
                                        ),
                                      )
                                    : Text(
                                        'Enter_your_phone_number_to_continue'
                                            .tr(),
                                        key: const ValueKey('phoneSubtitle'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: isSmall ? 13.5 : 14.5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF555B70),
                                        ),
                                      ),
                              ),
                              SizedBox(height: isSmall ? 20 : 27),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 350),
                                switchInCurve: Curves.easeOutBack,
                                switchOutCurve: Curves.easeIn,
                                child: _showOtpScreen
                                    ? _buildOtpCard(context, isSmall)
                                    : _buildPhoneCard(context, isSmall),
                              ),
                              const SizedBox(height: 22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.verified_user_rounded,
                                    size: 15,
                                    color: const Color(
                                      0xFF687087,
                                    ).withOpacity(0.75),
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      'Secure_access'.tr(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(
                                          0xFF687087,
                                        ).withOpacity(0.75),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PHONE CARD
  // ============================================================

  Widget _buildPhoneCard(BuildContext context, bool isSmall) {
    final cardPadding = isSmall ? 20.0 : 24.0;
    final iconSize = isSmall ? 60.0 : 72.0;
    final radius = isSmall ? 26.0 : 32.0;

    return ClipRRect(
      key: const ValueKey('phoneCard'),
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            cardPadding,
            cardPadding + 3,
            cardPadding,
            cardPadding - 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.62),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.white.withOpacity(0.90),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 40,
                spreadRadius: -5,
                offset: const Offset(0, 22),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFE6F3), Color(0xFFF8D0E4)],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.95),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.phone_rounded,
                  size: isSmall ? 28 : 32,
                  color: kSenseColor,
                ),
              ),
              const SizedBox(height: 17),
              Text(
                'Enter your phone number',
                style: TextStyle(
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF596075),
                ),
              ),
              const SizedBox(height: 19),
              TextField(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                enabled: !_isLoading,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (!_isLoading) _sendOtp();
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\- ()]')),
                ],
                onChanged: (_) {
                  if (mounted) setState(() {});
                },
                style: TextStyle(
                  fontSize: isSmall ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF171A2D),
                ),
                decoration: InputDecoration(
                  hintText: '07X XXX XXXX',
                  hintStyle: TextStyle(
                    fontSize: isSmall ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.20),
                  ),
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: kSenseColor.withOpacity(0.70),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.55),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 14 : 18,
                    vertical: isSmall ? 14 : 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      color: kSenseColor.withOpacity(0.18),
                      width: 1.2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      color: kSenseColor.withOpacity(0.22),
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(19)),
                    borderSide: BorderSide(color: kSenseColor, width: 1.6),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      color: kSenseColor.withOpacity(0.10),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 23),
              _buildPrimaryButton(
                text: 'Continue',
                icon: Icons.arrow_forward_rounded,
                loading: _isLoading,
                enabled: !_isLoading && _isValidPhone(),
                onPressed: _sendOtp,
                isSmall: isSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // OTP CARD
  // ============================================================

  Widget _buildOtpCard(BuildContext context, bool isSmall) {
    final cardPadding = isSmall ? 20.0 : 24.0;
    final radius = isSmall ? 26.0 : 32.0;
    final otpBoxWidth = isSmall ? 62.0 : 76.0;
    final otpBoxHeight = isSmall ? 56.0 : 68.0;

    return ClipRRect(
      key: const ValueKey('otpCard'),
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            cardPadding,
            cardPadding + 3,
            cardPadding,
            cardPadding - 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.62),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.white.withOpacity(0.90),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 40,
                spreadRadius: -5,
                offset: const Offset(0, 22),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOtpIcon(isSmall),
              const SizedBox(height: 17),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  _otpVerified
                      ? 'Phone number verified!'
                      : 'Enter your 4-digit verification code',
                  key: ValueKey(_otpVerified),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmall ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: _otpVerified ? kSenseColor : const Color(0xFF596075),
                  ),
                ),
              ),
              const SizedBox(height: 19),
              SizedBox(
                height: otpBoxHeight + 6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.01,
                        child: TextField(
                          controller: _otpController,
                          focusNode: _otpFocusNode,
                          enabled: !_isLoading,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          maxLength: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          onSubmitted: (_) {
                            if (!_isLoading &&
                                _otpController.text.length == 4) {
                              _verifyOtp();
                            }
                          },
                          onChanged: (_) {
                            if (mounted) setState(() {});
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          final otp = _otpController.text;
                          final hasValue = index < otp.length;
                          final isCurrent =
                              _otpFocusNode.hasFocus &&
                              index == otp.length.clamp(0, 3);

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOut,
                            width: otpBoxWidth,
                            height: otpBoxHeight,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.72),
                              borderRadius: BorderRadius.circular(
                                isSmall ? 16 : 19,
                              ),
                              border: Border.all(
                                color: isCurrent
                                    ? kSenseColor
                                    : kSenseColor.withOpacity(0.12),
                                width: isCurrent ? 1.8 : 1.2,
                              ),
                              boxShadow: isCurrent
                                  ? [
                                      BoxShadow(
                                        color: kSenseColor.withOpacity(0.14),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                hasValue ? otp[index] : '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isSmall ? 22 : 27,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF171A2D),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _buildOtpProgress(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Didn’t receive the code?',
                      style: TextStyle(
                        fontSize: isSmall ? 11 : 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF687087).withOpacity(0.85),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: _secondsRemaining == 0 && !_isLoading
                        ? _resendOtp
                        : null,
                    child: Text(
                      _secondsRemaining > 0
                          ? 'Resend in ${_secondsRemaining}s'
                          : 'Resend',
                      style: TextStyle(
                        fontSize: isSmall ? 11 : 12,
                        fontWeight: FontWeight.w700,
                        color: _secondsRemaining == 0 && !_isLoading
                            ? kSenseColor
                            : Colors.grey.shade400,
                        decoration: _secondsRemaining == 0 && !_isLoading
                            ? TextDecoration.underline
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 23),
              _buildPrimaryButton(
                text: 'Verify & Continue',
                icon: Icons.arrow_forward_rounded,
                loading: _isLoading,
                enabled: !_isLoading && _otpController.text.length == 4,
                onPressed: _verifyOtp,
                isSmall: isSmall,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _isLoading ? null : _backToPhone,
                style: TextButton.styleFrom(foregroundColor: kSenseColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_rounded, size: 17),
                    const SizedBox(width: 5),
                    Text(
                      'Change phone number',
                      style: TextStyle(
                        fontSize: isSmall ? 12 : 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpIcon(bool isSmall) {
    final size = isSmall ? 60.0 : 72.0;

    return AnimatedBuilder(
      animation: _successAnimationController,
      builder: (context, child) {
        final scale = _otpVerified ? _successScaleAnimation.value : 1.0;
        final rotation = _otpVerified ? _successRotationAnimation.value : 0.0;
        final glow = _otpVerified ? _successGlowAnimation.value : 0.0;

        return Transform.scale(
          scale: scale,
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _otpVerified
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFE6F3), Color(0xFFF4C4DB)],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFE6F3), Color(0xFFF8D0E4)],
                      ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.95),
                  width: 1.5,
                ),
                boxShadow: _otpVerified
                    ? [
                        BoxShadow(
                          color: kSenseColor.withOpacity(0.28 * glow),
                          blurRadius: 28,
                          spreadRadius: 6 * glow,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.elasticOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Icon(
                    _otpVerified ? Icons.check_rounded : Icons.verified_rounded,
                    key: ValueKey(_otpVerified),
                    size: _otpVerified
                        ? (isSmall ? 32 : 39)
                        : (isSmall ? 26 : 32),
                    color: kSenseColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required IconData icon,
    required bool loading,
    required bool enabled,
    required VoidCallback onPressed,
    required bool isSmall,
  }) {
    return SizedBox(
      width: double.infinity,
      height: isSmall ? 52 : 56,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kSenseColor,
          disabledBackgroundColor: Colors.black.withOpacity(0.07),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: loading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 23,
                  height: 23,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  key: ValueKey(text),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isSmall ? 14 : 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Icon(icon, size: isSmall ? 19 : 21),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildOtpProgress() {
    final length = _otpController.text.length;

    return Row(
      children: List.generate(4, (index) {
        final active = index < length;

        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            height: 4.5,
            margin: EdgeInsets.only(right: index == 3 ? 0 : 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: active
                  ? const LinearGradient(
                      colors: [kSenseColor, Color(0xFFB82A78)],
                    )
                  : null,
              color: active ? null : Colors.black.withOpacity(0.08),
            ),
          ),
        );
      }),
    );
  }
}

class _PremiumBackground extends StatelessWidget {
  const _PremiumBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF7F8FF), Color(0xFFF0F2FB), Color(0xFFFFF8FC)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -120,
            child: _GlowCircle(size: 380, color: const Color(0xFFF4C8DF)),
          ),
          Positioned(
            top: 120,
            left: -180,
            child: _GlowCircle(size: 340, color: const Color(0xFFF7D9E9)),
          ),
          Positioned(
            bottom: -170,
            right: -100,
            child: _GlowCircle(size: 390, color: const Color(0xFFF8DDEB)),
          ),
          Positioned(
            bottom: -160,
            left: -140,
            child: _GlowCircle(size: 320, color: const Color(0xFFF3D5E5)),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.45),
        ),
      ),
    );
  }
}
