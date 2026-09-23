import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../app_all/api_failure.dart';
import '../app_all/repo.dart';
import '../complete_profile_screen.dart';
import '../home.dart';

const Color kSenseColor = Color(0xFF990056);

class _AppColors {
  static const Color lightBackground = Color(0xFFF4F6FC);
  static const Color lightTitle = Color(0xFF15182A);
  static const Color lightSubtitle = Color(0xFF555B70);
  static const Color lightCaption = Color(0xFF596075);
  static const Color lightTextSecondary = Color(0xFF687087);
  static const Color lightFieldFill = Colors.white;
  static const Color lightFieldText = Color(0xFF171A2D);
  static const Color lightFieldBorder = Color(0xFFE0E0E0);
  static const Color lightCardBorder = Colors.white;
  static const Color lightSuccessCardBg = Colors.white;

  static const Color darkBackground = Color(0xFF0F0F15);
  static const Color darkTitle = Colors.white;
  static const Color darkSubtitle = Color(0xFFB0B5C7);
  static const Color darkCaption = Color(0xFF9A9FB0);
  static const Color darkTextSecondary = Color(0xFFA0A5B8);
  static const Color darkFieldFill = Color(0xFF1E1E2A);
  static const Color darkFieldText = Colors.white;
  static const Color darkFieldBorder = Color(0xFF2A2A3A);
  static const Color darkCardBorder = Color(0xFF2A2A3A);
  static const Color darkSuccessCardBg = Color(0xFF1E1E2A);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  static const String testOtp = '1234';
  static const String defaultCountryCode = '962';

  final AuthRepo _authRepo = AuthRepo();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _otpFocusNode = FocusNode();

  bool _isLoading = false;
  bool _showOtpScreen = false;
  bool _otpVerified = false;
  bool _isVerifying = false;
  bool _showSuccessScreen = false;

  Timer? _otpTimer;
  int _secondsRemaining = 60;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  late final AnimationController _successAnimationController;
  late final Animation<double> _successScaleAnimation;
  late final Animation<double> _successRotationAnimation;
  late final Animation<double> _successGlowAnimation;

  late final AnimationController _circularRotationController;

  late final AnimationController _confettiController;
  late final List<_ConfettiPiece> _confettiPieces;

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

    _circularRotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _confettiPieces = List.generate(60, (index) {
      final random = math.Random(index);
      return _ConfettiPiece(
        x: random.nextDouble(),
        delay: random.nextDouble() * 0.4,
        color: [
          const Color(0xFF4CAF50),
          const Color(0xFF66BB6A),
          const Color(0xFFFFD700),
          const Color(0xFFFF0099),
          Colors.white,
        ][index % 5],
        size: 6 + random.nextDouble() * 10,
        rotation: random.nextDouble() * math.pi * 2,
      );
    });

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
    _circularRotationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  bool _isValidPhone() {
    final phone = _phoneController.text.trim();
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 8 && digitsOnly.length <= 15;
  }

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
      (success) {
        setState(() {
          _isLoading = false;
          _showOtpScreen = true;
          _otpVerified = false;
          _isVerifying = false;
          _showSuccessScreen = false;
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
      (failure) {
        setState(() => _isLoading = false);
        final msg = failure is APIFailure
            ? failure.message
            : failure.toString();
        _showMessage(message: msg, icon: Icons.error_outline_rounded);
      },
    );
  }

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

  Future<void> _verifyOtp() async {
    if (_isLoading || _isVerifying) return;

    final otp = _otpController.text.trim();

    if (otp.length != 4) {
      _showMessage(
        message: 'Please_enter_the_4-digit_verification_code'.tr(),
        icon: Icons.lock_outline_rounded,
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isVerifying = true;
      _otpVerified = false;
      _showSuccessScreen = false;
    });

    _circularRotationController.repeat();

    const minimumRotationDuration = Duration(milliseconds: 1500);

    final verificationStartTime = DateTime.now();

    final bool isOtpValid = otp == testOtp;

    final verificationEndTime = DateTime.now();
    final verificationDuration = verificationEndTime.difference(
      verificationStartTime,
    );

    final remainingRotationTime =
        minimumRotationDuration - verificationDuration;

    if (remainingRotationTime > Duration.zero) {
      await Future.delayed(remainingRotationTime);
    }

    if (!mounted) return;

    _circularRotationController.stop();
    _circularRotationController.reset();

    if (!isOtpValid) {
      setState(() {
        _isVerifying = false;
        _otpVerified = false;
        _showSuccessScreen = false;
      });

      _showMessage(
        message: 'Incorrect_verification_code'.tr(),
        icon: Icons.error_outline_rounded,
      );

      _otpController.clear();

      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return;
      _otpFocusNode.requestFocus();

      return;
    }

    setState(() {
      _isVerifying = false;
      _otpVerified = false;
      _showSuccessScreen = true;
    });

    _confettiController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    final phone = _phoneController.text.trim();

    setState(() => _isLoading = true);

    final result = await _authRepo.getUserByPhone(
      mobile: phone,
      countryCode: defaultCountryCode,
    );

    if (!mounted) return;

    await result.fold(
      (userData) async {
        debugPrint('🟢 [getUserByPhone] USER DATA: $userData');

        final customerName =
            userData['Customer_Name']?.toString() ??
            userData['CustomerName']?.toString() ??
            '';

        final customerNo =
            userData['Loyalty_Customer_No']?.toString() ??
            userData['Customer_No']?.toString() ??
            userData['CustomerNo']?.toString() ??
            userData['Id']?.toString() ??
            '';

        debugPrint(
          '🟢 [getUserByPhone] customerNo = "$customerNo" | '
          'customerName = "$customerName"',
        );

        if (customerNo.isNotEmpty) {
          try {
            final box = GetStorage();
            await box.write('user_customer_no', customerNo);
            await box.write('customerNo', customerNo);
            await box.write('Customer_No', customerNo);
            debugPrint('💾 Saved customerNo to GetStorage: $customerNo');
          } catch (e) {
            debugPrint('❌ Failed to save customerNo: $e');
          }
        }

        if (customerNo.isEmpty) {
          debugPrint(
            '🆕 customerNo فاضي → CompleteProfileScreen (isNewUser: true)',
          );

          if (!mounted) return;
          setState(() => _isLoading = false);

          if (!mounted) return;

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 650),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, __, ___) =>
                  CompleteProfileScreen(phoneNumber: phone, isNewUser: true),
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
          return;
        }

        debugPrint('✅ المستخدم موجود → HomeScreen');

        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 650),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => HomeScreen(
              userName: customerName.isNotEmpty ? customerName : 'User',
              customerNo: customerNo,
              phoneNumber: phone,
            ),
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
      },
      (failure) async {
        debugPrint('🔴 [getUserByPhone] FAILURE: $failure');

        String msg = '';
        int? statusCode;

        if (failure is APIFailure) {
          debugPrint('🔴 message: ${failure.message}');
          debugPrint('🔴 statusCode: ${failure.statusCode}');
          msg = failure.message.toLowerCase();
          statusCode = failure.statusCode;
        } else {
          msg = failure.toString().toLowerCase();
        }

        final isNotFound =
            statusCode == 404 ||
            msg.contains('no customer') ||
            msg.contains('not found') ||
            msg.contains('no data') ||
            msg.contains('لا يوجد') ||
            msg.contains('غير موجود');

        if (isNotFound) {
          debugPrint(
            '🆕 المستخدم غير موجود → CompleteProfileScreen (isNewUser: true)',
          );

          if (!mounted) return;
          setState(() => _isLoading = false);

          if (!mounted) return;

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 650),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, __, ___) =>
                  CompleteProfileScreen(phoneNumber: phone, isNewUser: true),
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
          return;
        }

        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _showSuccessScreen = false;
        });
        final displayMsg = failure is APIFailure
            ? failure.message
            : failure.toString();
        _showMessage(message: displayMsg, icon: Icons.error_outline_rounded);
      },
    );
  }

  void _backToPhone() {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    _otpTimer?.cancel();
    _successAnimationController.reset();
    _circularRotationController.stop();
    _circularRotationController.reset();
    _confettiController.reset();
    setState(() {
      _showOtpScreen = false;
      _otpVerified = false;
      _isVerifying = false;
      _showSuccessScreen = false;
      _secondsRemaining = 60;
    });
    _otpController.clear();
    _animationController.reset();
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _phoneFocusNode.requestFocus();
    });
  }

  Future<void> _resendOtp() async {
    if (_isLoading || _secondsRemaining > 0) return;

    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      _showMessage(
        message: 'Please_enter_your_phone_number'.tr(),
        icon: Icons.phone_outlined,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _authRepo.sendOTP(
        mobile: phone,
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
    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoading = false);

      _showMessage(message: e.toString(), icon: Icons.error_outline_rounded);
    }
  }

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

  String _displayPhone() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return '';
    return phone;
  }

  bool _isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 360;

  bool _isKeyboardOpen(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = _isSmallScreen(context);
    final isKeyboardOpen = _isKeyboardOpen(context);

    final horizontalPadding = isSmall ? 16.0 : 22.0;
    final verticalPadding = isSmall ? 16.0 : 24.0;
    final maxWidth = isSmall ? screenWidth : 430.0;
    final topSpacing = isKeyboardOpen ? 16.0 : (isSmall ? 30.0 : 60.0);

    return Scaffold(
      backgroundColor: isDark
          ? _AppColors.darkBackground
          : _AppColors.lightBackground,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _PremiumBackground(isDark: isDark),

          if (_showSuccessScreen)
            _SuccessVerificationScreen(isDark: isDark)
          else ...[
            if (!isKeyboardOpen)
              Positioned(
                top: -40,
                left: -30,
                right: -30,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: isDark ? 0.15 : 0.075,
                    child: Image.asset(
                      'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
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
                        minHeight:
                            constraints.maxHeight - (verticalPadding * 2),
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
                                      color: isDark
                                          ? _AppColors.darkTitle
                                          : _AppColors.lightTitle,
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
                                            color: isDark
                                                ? _AppColors.darkSubtitle
                                                : _AppColors.lightSubtitle
                                                      .withOpacity(0.9),
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
                                            color: isDark
                                                ? _AppColors.darkSubtitle
                                                : _AppColors.lightSubtitle,
                                          ),
                                        ),
                                ),
                                SizedBox(height: isSmall ? 20 : 27),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 350),
                                  switchInCurve: Curves.easeOutBack,
                                  switchOutCurve: Curves.easeIn,
                                  child: _showOtpScreen
                                      ? _buildOtpCard(context, isSmall, isDark)
                                      : _buildPhoneCard(
                                          context,
                                          isSmall,
                                          isDark,
                                        ),
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.verified_user_rounded,
                                      size: 15,
                                      color: isDark
                                          ? _AppColors.darkTextSecondary
                                                .withOpacity(0.85)
                                          : _AppColors.lightTextSecondary
                                                .withOpacity(0.75),
                                    ),
                                    const SizedBox(width: 6),
                                    Flexible(
                                      child: Text(
                                        'Secure_access'.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? _AppColors.darkTextSecondary
                                                    .withOpacity(0.85)
                                              : _AppColors.lightTextSecondary
                                                    .withOpacity(0.75),
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
        ],
      ),
    );
  }

  Widget _buildPhoneCard(BuildContext context, bool isSmall, bool isDark) {
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
            color: isDark
                ? const Color(0xFF1E1E2A).withOpacity(0.85)
                : Colors.white.withOpacity(0.62),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: isDark
                  ? _AppColors.darkCardBorder.withOpacity(0.9)
                  : Colors.white.withOpacity(0.90),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.25 : 0.07),
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
                  gradient: isDark
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF3A1A2E), Color(0xFF2A1220)],
                        )
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFE6F3), Color(0xFFF8D0E4)],
                        ),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.10)
                        : Colors.white.withOpacity(0.95),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.phone_rounded,
                  size: isSmall ? 28 : 32,
                  color: isDark ? const Color(0xFFFF6FB5) : kSenseColor,
                ),
              ),
              SizedBox(height: 17),
              Text(
                'Enter your phone number'.tr(),
                style: TextStyle(
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? _AppColors.darkCaption
                      : _AppColors.lightCaption,
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
                  color: isDark
                      ? _AppColors.darkFieldText
                      : _AppColors.lightFieldText,
                ),
                decoration: InputDecoration(
                  hintText: '07X XXX XXXX',
                  hintStyle: TextStyle(
                    fontSize: isSmall ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? Colors.white.withOpacity(0.30)
                        : Colors.black.withOpacity(0.20),
                  ),
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: isDark
                        ? const Color(0xFFFF6FB5).withOpacity(0.75)
                        : kSenseColor.withOpacity(0.70),
                  ),
                  filled: true,
                  fillColor: isDark
                      ? _AppColors.darkFieldFill
                      : Colors.white.withOpacity(0.55),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 14 : 18,
                    vertical: isSmall ? 14 : 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      color: isDark
                          ? _AppColors.darkFieldBorder
                          : kSenseColor.withOpacity(0.18),
                      width: 1.2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      color: isDark
                          ? _AppColors.darkFieldBorder
                          : kSenseColor.withOpacity(0.22),
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(19)),
                    borderSide: BorderSide(
                      color: isDark ? const Color(0xFFFF6FB5) : kSenseColor,
                      width: 1.6,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      color: isDark
                          ? _AppColors.darkFieldBorder.withOpacity(0.5)
                          : kSenseColor.withOpacity(0.10),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 23),
              _buildPrimaryButton(
                text: 'Continue'.tr(),
                icon: Icons.arrow_forward_rounded,
                loading: _isLoading,
                enabled: !_isLoading && _isValidPhone(),
                onPressed: _sendOtp,
                isSmall: isSmall,
                isDark: isDark,
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

  Widget _buildOtpCard(BuildContext context, bool isSmall, bool isDark) {
    final cardPadding = isSmall ? 20.0 : 24.0;
    final radius = isSmall ? 26.0 : 32.0;
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
            color: isDark
                ? const Color(0xFF1E1E2A).withOpacity(0.85)
                : Colors.white.withOpacity(0.62),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: isDark
                  ? _AppColors.darkCardBorder.withOpacity(0.9)
                  : Colors.white.withOpacity(0.90),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.25 : 0.07),
                blurRadius: 40,
                spreadRadius: -5,
                offset: const Offset(0, 22),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOtpIcon(isSmall, isDark),
              const SizedBox(height: 17),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _otpVerified
                      ? 'Phone number verified!'
                      : _isVerifying
                      ? 'Verifying...'
                      : 'Enter your 4-digit verification code'.tr(),
                  key: ValueKey('$_otpVerified-$_isVerifying'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmall ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: _otpVerified
                        ? (isDark ? const Color(0xFFFF6FB5) : kSenseColor)
                        : (isDark
                              ? _AppColors.darkCaption
                              : _AppColors.lightCaption),
                  ),
                ),
              ),

              const SizedBox(height: 19),

              _buildOtpBoxes(isSmall, otpBoxHeight, isDark),

              const SizedBox(height: 14),

              _buildOtpProgress(isDark),

              const SizedBox(height: 16),

              if (!_isVerifying && !_otpVerified)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Didn\'t receive the code?',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isSmall ? 11 : 12,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? _AppColors.darkTextSecondary.withOpacity(0.85)
                              : _AppColors.lightTextSecondary.withOpacity(0.85),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: GestureDetector(
                        onTap: _secondsRemaining == 0 && !_isLoading
                            ? _resendOtp
                            : null,
                        child: Text(
                          _secondsRemaining > 0
                              ? 'Resend in ${_secondsRemaining}s'
                              : 'Resend'.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isSmall ? 11 : 12,
                            fontWeight: FontWeight.w700,
                            color: _secondsRemaining == 0 && !_isLoading
                                ? (isDark
                                      ? const Color(0xFFFF6FB5)
                                      : kSenseColor)
                                : (isDark
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400),
                            decoration: _secondsRemaining == 0 && !_isLoading
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              if (!_isVerifying && !_otpVerified) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          _backToPhone();
                        },
                  style: TextButton.styleFrom(
                    foregroundColor: isDark
                        ? const Color(0xFFFF6FB5)
                        : kSenseColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_rounded, size: 17),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'Change phone number'.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isSmall ? 12 : 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBoxes(bool isSmall, double otpBoxHeight, bool isDark) {
    final bool isInVerificationMode = _isVerifying;

    return SizedBox(
      height: otpBoxHeight * 2.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.01,
              child: TextField(
                controller: _otpController,
                focusNode: _otpFocusNode,
                enabled: !_isLoading && !isInVerificationMode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 4,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: (_) {
                  if (mounted) setState(() {});

                  if (_otpController.text.length == 4 &&
                      !_isVerifying &&
                      !_otpVerified) {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (mounted &&
                          _otpController.text.length == 4 &&
                          !_isVerifying &&
                          !_otpVerified) {
                        _verifyOtp();
                      }
                    });
                  }
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),

          if (isInVerificationMode)
            SizedBox(
              width: otpBoxHeight * 2.4,
              height: otpBoxHeight * 2.4,
              child: CustomPaint(
                painter: _DashedCirclePainter(
                  color: isDark
                      ? const Color(0xFFFF6FB5).withOpacity(0.35)
                      : kSenseColor.withOpacity(0.30),
                  strokeWidth: 1.5,
                  dashLength: 6,
                  gapLength: 4,
                ),
              ),
            ),

          AnimatedBuilder(
            animation: _circularRotationController,
            builder: (context, _) {
              if (!isInVerificationMode) {
                return IgnorePointer(
                  child: Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: index == 3 ? 0 : 8),
                          child: SizedBox(
                            height: otpBoxHeight,
                            child: _buildSingleOtpBox(
                              index: index,
                              isSmall: isSmall,
                              isInVerificationMode: false,
                              isDark: isDark,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }

              return _buildCircularOtpBoxes(
                isSmall: isSmall,
                otpBoxHeight: otpBoxHeight,
                isDark: isDark,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircularOtpBoxes({
    required bool isSmall,
    required double otpBoxHeight,
    required bool isDark,
  }) {
    final double radius = otpBoxHeight * 0.85;

    final double rotationAngle =
        _circularRotationController.value * 2 * math.pi;

    final double adjustedBoxSize = otpBoxHeight * 0.72;

    return SizedBox(
      width: otpBoxHeight * 2.4,
      height: otpBoxHeight * 2.4,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(4, (index) {
          final double baseAngle = index * (math.pi / 2);

          final double totalAngle = baseAngle + rotationAngle;

          final double dx = radius * math.cos(totalAngle);
          final double dy = radius * math.sin(totalAngle);

          return Transform.translate(
            offset: Offset(dx, dy),
            child: SizedBox(
              width: adjustedBoxSize,
              height: adjustedBoxSize,
              child: _buildSingleOtpBox(
                index: index,
                isSmall: isSmall,
                isInVerificationMode: true,
                isDark: isDark,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSingleOtpBox({
    required int index,
    required bool isSmall,
    required bool isInVerificationMode,
    required bool isDark,
  }) {
    final otp = _otpController.text;
    final hasValue = index < otp.length;
    final isCurrent = _otpFocusNode.hasFocus && index == otp.length.clamp(0, 3);

    final Color boxColor;
    if (_otpVerified) {
      boxColor = isDark ? const Color(0xFF3A1A2E) : const Color(0xFFFFE6F3);
    } else if (isInVerificationMode) {
      boxColor = isDark
          ? const Color(0xFF1E1E2A).withOpacity(0.95)
          : Colors.white.withOpacity(0.85);
    } else {
      boxColor = isDark
          ? const Color(0xFF1E1E2A)
          : Colors.white.withOpacity(0.72);
    }

    final Color borderColor;
    final Color accentColor = isDark ? const Color(0xFFFF6FB5) : kSenseColor;

    if (_otpVerified) {
      borderColor = accentColor.withOpacity(0.50);
    } else if (isInVerificationMode) {
      borderColor = accentColor.withOpacity(0.40);
    } else if (isCurrent) {
      borderColor = accentColor;
    } else {
      borderColor = isDark
          ? _AppColors.darkFieldBorder
          : kSenseColor.withOpacity(0.12);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(isSmall ? 14 : 16),
        border: Border.all(
          color: borderColor,
          width: _otpVerified
              ? 2.0
              : isInVerificationMode
              ? 2.0
              : isCurrent
              ? 1.8
              : 1.2,
        ),
        boxShadow: _otpVerified
            ? [
                BoxShadow(
                  color: accentColor.withOpacity(0.28),
                  blurRadius: 20,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
                ),
              ]
            : isInVerificationMode
            ? [
                BoxShadow(
                  color: accentColor.withOpacity(0.18),
                  blurRadius: 14,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ]
            : isCurrent
            ? [
                BoxShadow(
                  color: accentColor.withOpacity(0.14),
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
            fontSize: isSmall ? 18 : 22,
            fontWeight: FontWeight.w700,
            color: _otpVerified
                ? accentColor
                : (isDark ? Colors.white : const Color(0xFF171A2D)),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpIcon(bool isSmall, bool isDark) {
    final size = isSmall ? 60.0 : 72.0;
    final accentColor = isDark ? const Color(0xFFFF6FB5) : kSenseColor;

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
                    ? (isDark
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF3A1A2E), Color(0xFF2A1220)],
                            )
                          : const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFE6F3), Color(0xFFF4C4DB)],
                            ))
                    : (isDark
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF3A1A2E), Color(0xFF2A1220)],
                            )
                          : const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFE6F3), Color(0xFFF8D0E4)],
                            )),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.10)
                      : Colors.white.withOpacity(0.95),
                  width: 1.5,
                ),
                boxShadow: _otpVerified
                    ? [
                        BoxShadow(
                          color: accentColor.withOpacity(0.28 * glow),
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
                    color: accentColor,
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
    required bool isDark,
  }) {
    return SizedBox(
      width: double.infinity,
      height: isSmall ? 52 : 56,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDark ? const Color(0xFFFF6FB5) : kSenseColor,
          disabledBackgroundColor: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.07),
          foregroundColor: Colors.white,
          disabledForegroundColor: isDark
              ? Colors.white.withOpacity(0.30)
              : Colors.black.withOpacity(0.25),
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

  Widget _buildOtpProgress(bool isDark) {
    if (_isVerifying || _otpVerified) {
      return const SizedBox(height: 4.5);
    }

    final length = _otpController.text.length;
    final accentColor = isDark ? const Color(0xFFFF6FB5) : kSenseColor;

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
                  ? LinearGradient(
                      colors: [
                        accentColor,
                        isDark
                            ? const Color(0xFFB82A78)
                            : const Color(0xFFB82A78),
                      ],
                    )
                  : null,
              color: active
                  ? null
                  : (isDark
                        ? Colors.white.withOpacity(0.10)
                        : Colors.black.withOpacity(0.08)),
            ),
          ),
        );
      }),
    );
  }
}

class _SuccessVerificationScreen extends StatefulWidget {
  final bool isDark;

  const _SuccessVerificationScreen({required this.isDark});

  @override
  State<_SuccessVerificationScreen> createState() =>
      _SuccessVerificationScreenState();
}

class _SuccessVerificationScreenState extends State<_SuccessVerificationScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  late final AnimationController _confettiController;
  late final List<_ConfettiPiece> _confettiPieces;

  static const Color successColor = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF66BB6A);

  bool get isDark => widget.isDark;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.3,
          end: 1.1,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.1,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
    ]).animate(_entryController);

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _confettiPieces = List.generate(60, (index) {
      final random = math.Random(index);
      return _ConfettiPiece(
        x: random.nextDouble(),
        delay: random.nextDouble() * 0.4,
        color: [
          successColor,
          successLight,
          const Color(0xFFFFD700),
          const Color(0xFFFF0099),
          Colors.white,
        ][index % 5],
        size: 6 + random.nextDouble() * 10,
        rotation: random.nextDouble() * math.pi * 2,
      );
    });

    _entryController.forward();
    _confettiController.forward();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: _confettiController,
          builder: (context, _) {
            return CustomPaint(
              painter: _ConfettiPainter(
                pieces: _confettiPieces,
                progress: _confettiController.value,
              ),
            );
          },
        ),

        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 20 : 28,
                vertical: 20,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: _buildSuccessCard(isSmall, isDark),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessCard(bool isSmall, bool isDark) {
    final cardPadding = isSmall ? 28.0 : 36.0;

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: isDark ? _AppColors.darkSuccessCardBg : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: isDark
            ? Border.all(color: _AppColors.darkCardBorder, width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: successColor.withOpacity(isDark ? 0.20 : 0.15),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.30 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Verified Successfully'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmall ? 20 : 23,
              fontWeight: FontWeight.w800,
              color: successColor,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your number has been verified.'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmall ? 13 : 14.5,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? _AppColors.darkTextSecondary
                  : const Color(0xFF687087),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 32),

          _buildCheckmarkCircle(isSmall, isDark),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_rounded,
                size: isSmall ? 16 : 18,
                color: successColor,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Verified and Secure'.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isSmall ? 13 : 14,
                    fontWeight: FontWeight.w700,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckmarkCircle(bool isSmall, bool isDark) {
    final outerSize = isSmall ? 140.0 : 170.0;
    final innerSize = isSmall ? 90.0 : 110.0;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: outerSize,
            height: outerSize,
            child: CustomPaint(
              painter: _DashedCirclePainter(
                color: successColor.withOpacity(isDark ? 0.45 : 0.35),
                strokeWidth: 1.5,
                dashLength: 6,
                gapLength: 5,
              ),
            ),
          ),

          Container(
            width: outerSize * 0.75,
            height: outerSize * 0.75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: successColor.withOpacity(isDark ? 0.25 : 0.15),
                width: 1,
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: child,
              );
            },
            child: Container(
              width: innerSize,
              height: innerSize,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(innerSize * 0.30),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [successColor, successLight],
                ),
                boxShadow: [
                  BoxShadow(
                    color: successColor.withOpacity(isDark ? 0.55 : 0.45),
                    blurRadius: 30,
                    spreadRadius: 4,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.check_rounded,
                  size: isSmall ? 48 : 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  _DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashLength = 6,
    this.gapLength = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final double circumference = 2 * math.pi * radius;
    final int dashCount = (circumference / (dashLength + gapLength)).floor();
    final double angleStep = 2 * math.pi / dashCount;
    final double dashAngle = (dashLength / circumference) * 2 * math.pi;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * angleStep;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ConfettiPiece {
  final double x;
  final double delay;
  final Color color;
  final double size;
  final double rotation;

  _ConfettiPiece({
    required this.x,
    required this.delay,
    required this.color,
    required this.size,
    required this.rotation,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiPiece> pieces;
  final double progress;

  _ConfettiPainter({required this.pieces, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final piece in pieces) {
      final double pieceProgress =
          ((progress - piece.delay) / (1 - piece.delay)).clamp(0.0, 1.0);

      if (pieceProgress <= 0) continue;

      final double startX = piece.x * size.width;
      final double startY = -20;
      final double endY = size.height * 0.9;

      final double y = startY + (endY - startY) * pieceProgress;
      final double x = startX + math.sin(pieceProgress * math.pi * 3) * 30;

      final paint = Paint()
        ..color = piece.color.withOpacity(1 - pieceProgress * 0.5)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(piece.rotation + pieceProgress * math.pi * 4);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: piece.size,
          height: piece.size * 0.6,
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _PremiumBackground extends StatelessWidget {
  final bool isDark;

  const _PremiumBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF0F0F15), Color(0xFF14101A), Color(0xFF1A0F1A)]
              : const [Color(0xFFF7F8FF), Color(0xFFF0F2FB), Color(0xFFFFF8FC)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -120,
            child: _GlowCircle(
              size: 380,
              color: isDark ? const Color(0xFF3A1A2E) : const Color(0xFFF4C8DF),
              isDark: isDark,
            ),
          ),
          Positioned(
            top: 120,
            left: -180,
            child: _GlowCircle(
              size: 340,
              color: isDark ? const Color(0xFF2A1525) : const Color(0xFFF7D9E9),
              isDark: isDark,
            ),
          ),
          Positioned(
            bottom: -170,
            right: -100,
            child: _GlowCircle(
              size: 390,
              color: isDark ? const Color(0xFF2A1220) : const Color(0xFFF8DDEB),
              isDark: isDark,
            ),
          ),
          Positioned(
            bottom: -160,
            left: -140,
            child: _GlowCircle(
              size: 320,
              color: isDark ? const Color(0xFF351828) : const Color(0xFFF3D5E5),
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
      imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(isDark ? 0.55 : 0.45),
        ),
      ),
    );
  }
}
