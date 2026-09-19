// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../app_all/api_failure.dart';
// import '../app_all/repo.dart';
// import '../home.dart';
//
// const Color kSenseColor = Color(0xFF990056);
//
// class IdInputScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   const IdInputScreen({super.key, required this.phoneNumber});
//
//   @override
//   State<IdInputScreen> createState() => _IdInputScreenState();
// }
//
// class _IdInputScreenState extends State<IdInputScreen>
//     with TickerProviderStateMixin {
//   final AuthRepo _authRepo = AuthRepo();
//   final TextEditingController _idController = TextEditingController();
//   final FocusNode _idFocusNode = FocusNode();
//
//   bool _isLoading = false;
//
//   late final AnimationController _animationController;
//   late final Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 450),
//     );
//     _scaleAnimation = Tween<double>(begin: 0.96, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );
//     _animationController.forward();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) _idFocusNode.requestFocus();
//     });
//   }
//
//   @override
//   void dispose() {
//     _idController.dispose();
//     _idFocusNode.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   // ============================================================
//   // SUBMIT — يتحقق من الـ ID ويجيب البيانات
//   // ============================================================
//   Future<void> _submitId() async {
//     if (_isLoading) return;
//
//     final enteredId = _idController.text.trim();
//
//     if (enteredId.isEmpty) {
//       _showMessage(message: 'Please enter your ID', icon: Icons.badge_outlined);
//       return;
//     }
//
//     FocusScope.of(context).unfocus();
//     setState(() => _isLoading = true);
//
//     // ✅ نجيب بيانات المستخدم بالرقم
//     final result = await _authRepo.getUserByPhone(
//       mobile: widget.phoneNumber,
//       countryCode: '962',
//     );
//
//     if (!mounted) return;
//
//     result.fold(
//       (userData) async {
//         // ✅ نتحقق: هل الـ ID اللي دخله = Customer_No من الـ API؟
//         final customerNo = userData['Customer_No']?.toString() ?? '';
//
//         if (customerNo.isEmpty) {
//           setState(() => _isLoading = false);
//           _showMessage(
//             message: 'Customer data is incomplete',
//             icon: Icons.error_outline_rounded,
//           );
//           return;
//         }
//
//         if (customerNo != enteredId) {
//           setState(() => _isLoading = false);
//           _showMessage(
//             message: 'ID does not match this phone number',
//             icon: Icons.error_outline_rounded,
//           );
//           return;
//         }
//
//         // ✅ الـ ID مطابق → نخزن البيانات
//         final prefs = await SharedPreferences.getInstance();
//
//         await prefs.setString('user_id', enteredId);
//         await prefs.setString('user_phone', widget.phoneNumber);
//         await prefs.setString('user_customer_no', customerNo);
//
//         // نخزن كل بيانات المستخدم
//         userData.forEach((key, value) {
//           if (value != null) {
//             prefs.setString('user_$key', value.toString());
//           }
//         });
//
//         final userName =
//             userData['Customer_Arabic_Name'] ??
//             userData['CustomerName'] ??
//             userData['Customer_English_Name'] ??
//             'User';
//
//         await prefs.setString('user_name', userName.toString());
//
//         if (!mounted) return;
//
//         Navigator.of(context).pushReplacement(
//           PageRouteBuilder(
//             transitionDuration: const Duration(milliseconds: 650),
//             reverseTransitionDuration: const Duration(milliseconds: 300),
//             pageBuilder: (_, __, ___) =>
//                 HomeScreen(userName: userName.toString()),
//             transitionsBuilder: (_, animation, __, child) {
//               final curved = CurvedAnimation(
//                 parent: animation,
//                 curve: Curves.easeOutCubic,
//               );
//               return FadeTransition(
//                 opacity: curved,
//                 child: SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(0, 0.025),
//                     end: Offset.zero,
//                   ).animate(curved),
//                   child: child,
//                 ),
//               );
//             },
//           ),
//         );
//       },
//       (failure) {
//         setState(() => _isLoading = false);
//         final msg = failure is APIFailure
//             ? failure.message
//             : failure.toString();
//         _showMessage(message: msg, icon: Icons.error_outline_rounded);
//       },
//     );
//   }
//
//   void _showMessage({required String message, required IconData icon}) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmall = screenWidth < 360;
//     final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
//
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
//           const _PremiumBackground(),
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
//                               Text(
//                                 'Enter Your ID',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: isSmall ? 26 : 31,
//                                   fontWeight: FontWeight.w800,
//                                   letterSpacing: -0.8,
//                                   color: const Color(0xFF15182A),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 'Please enter your ID to continue',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: isSmall ? 13.5 : 14.5,
//                                   fontWeight: FontWeight.w500,
//                                   color: const Color(0xFF555B70),
//                                 ),
//                               ),
//                               SizedBox(height: isSmall ? 20 : 27),
//                               _buildIdCard(context, isSmall),
//                               const SizedBox(height: 22),
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
//                                   Text(
//                                     'Secure access',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(
//                                         0xFF687087,
//                                       ).withOpacity(0.75),
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
//   Widget _buildIdCard(BuildContext context, bool isSmall) {
//     final cardPadding = isSmall ? 20.0 : 24.0;
//     final iconSize = isSmall ? 60.0 : 72.0;
//     final radius = isSmall ? 26.0 : 32.0;
//
//     return ClipRRect(
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
//                   Icons.badge_rounded,
//                   size: isSmall ? 28 : 32,
//                   color: kSenseColor,
//                 ),
//               ),
//               const SizedBox(height: 17),
//               Text(
//                 'Enter your ID',
//                 style: TextStyle(
//                   fontSize: isSmall ? 13 : 14,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF596075),
//                 ),
//               ),
//               const SizedBox(height: 19),
//               TextField(
//                 controller: _idController,
//                 focusNode: _idFocusNode,
//                 enabled: !_isLoading,
//                 keyboardType: TextInputType.number,
//                 textInputAction: TextInputAction.done,
//                 onSubmitted: (_) {
//                   if (!_isLoading) _submitId();
//                 },
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 onChanged: (_) {
//                   if (mounted) setState(() {});
//                 },
//                 style: TextStyle(
//                   fontSize: isSmall ? 16 : 18,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF171A2D),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: '471240',
//                   hintStyle: TextStyle(
//                     fontSize: isSmall ? 14 : 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withOpacity(0.20),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.badge_outlined,
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
//               const SizedBox(height: 23),
//               SizedBox(
//                 width: double.infinity,
//                 height: isSmall ? 52 : 56,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _submitId,
//                   style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     backgroundColor: kSenseColor,
//                     disabledBackgroundColor: Colors.black.withOpacity(0.07),
//                     foregroundColor: Colors.white,
//                     disabledForegroundColor: Colors.black.withOpacity(0.25),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                           width: 23,
//                           height: 23,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2.5,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Colors.white,
//                             ),
//                           ),
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 'Continue',
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: isSmall ? 14 : 16,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 9),
//                             Icon(
//                               Icons.arrow_forward_rounded,
//                               size: isSmall ? 19 : 21,
//                             ),
//                           ],
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_all/api_failure.dart';
import '../app_all/repo.dart';
import '../home.dart';

const Color kSenseColor = Color(0xFF990056);

class IdInputScreen extends StatefulWidget {
  final String phoneNumber;

  const IdInputScreen({super.key, required this.phoneNumber});

  @override
  State<IdInputScreen> createState() => _IdInputScreenState();
}

class _IdInputScreenState extends State<IdInputScreen>
    with TickerProviderStateMixin {
  final AuthRepo _authRepo = AuthRepo();
  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();

  bool _isLoading = false;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

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
    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _idFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _idFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // ============================================================
  // SUBMIT — يتحقق من الـ ID ويجيب البيانات
  // ============================================================
  Future<void> _submitId() async {
    if (_isLoading) return;

    final enteredId = _idController.text.trim();

    if (enteredId.isEmpty) {
      _showMessage(message: 'Please enter your ID', icon: Icons.badge_outlined);
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    // ✅ نجيب بيانات المستخدم بالرقم
    final result = await _authRepo.getUserByPhone(
      mobile: widget.phoneNumber,
      countryCode: '962',
    );

    if (!mounted) return;

    result.fold(
      (userData) async {
        // ✅ نتحقق: هل الـ ID اللي دخله = Customer_No من الـ API؟
        final customerNo = userData['Customer_No']?.toString() ?? '';

        if (customerNo.isEmpty) {
          setState(() => _isLoading = false);
          _showMessage(
            message: 'Customer data is incomplete',
            icon: Icons.error_outline_rounded,
          );
          return;
        }

        if (customerNo != enteredId) {
          setState(() => _isLoading = false);
          _showMessage(
            message: 'ID does not match this phone number',
            icon: Icons.error_outline_rounded,
          );
          return;
        }

        // ✅ الـ ID مطابق → نمرر رقم العميل مباشرة إلى HomeScreen
        debugPrint('✅ ID matched → customerNo=$customerNo');

        if (!mounted) return;

        final userName =
            userData['Customer_Name']?.toString() ??
            userData['CustomerName']?.toString() ??
            'User';

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 650),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => HomeScreen(
              userName: userName,
              customerNo: customerNo,
              phoneNumber: '',
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
      (failure) {
        setState(() => _isLoading = false);
        final msg = failure is APIFailure
            ? failure.message
            : failure.toString();
        _showMessage(message: msg, icon: Icons.error_outline_rounded);
      },
    );
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

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
                              Text(
                                'Enter Your ID',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isSmall ? 26 : 31,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.8,
                                  color: const Color(0xFF15182A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Please enter your ID to continue',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isSmall ? 13.5 : 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF555B70),
                                ),
                              ),
                              SizedBox(height: isSmall ? 20 : 27),
                              _buildIdCard(context, isSmall),
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
                                  Text(
                                    'Secure access',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(
                                        0xFF687087,
                                      ).withOpacity(0.75),
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

  Widget _buildIdCard(BuildContext context, bool isSmall) {
    final cardPadding = isSmall ? 20.0 : 24.0;
    final iconSize = isSmall ? 60.0 : 72.0;
    final radius = isSmall ? 26.0 : 32.0;

    return ClipRRect(
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
                  Icons.badge_rounded,
                  size: isSmall ? 28 : 32,
                  color: kSenseColor,
                ),
              ),
              const SizedBox(height: 17),
              Text(
                'Enter your ID',
                style: TextStyle(
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF596075),
                ),
              ),
              const SizedBox(height: 19),
              TextField(
                controller: _idController,
                focusNode: _idFocusNode,
                enabled: !_isLoading,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (!_isLoading) _submitId();
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) {
                  if (mounted) setState(() {});
                },
                style: TextStyle(
                  fontSize: isSmall ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF171A2D),
                ),
                decoration: InputDecoration(
                  hintText: '471240',
                  hintStyle: TextStyle(
                    fontSize: isSmall ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.20),
                  ),
                  prefixIcon: Icon(
                    Icons.badge_outlined,
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
              SizedBox(
                width: double.infinity,
                height: isSmall ? 52 : 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitId,
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
                  child: _isLoading
                      ? const SizedBox(
                          width: 23,
                          height: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Continue',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: isSmall ? 14 : 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 9),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: isSmall ? 19 : 21,
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
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
