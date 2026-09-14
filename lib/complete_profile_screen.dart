// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
// const Color kSenseColor = Color(0xFF990056);
//
// class CompleteProfileScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   const CompleteProfileScreen({super.key, required this.phoneNumber});
//
//   @override
//   State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
// }
//
// class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
//   final TextEditingController _nameController = TextEditingController();
//
//   final TextEditingController _emailController = TextEditingController();
//
//   final TextEditingController _birthDateController = TextEditingController();
//
//   final FocusNode _nameFocusNode = FocusNode();
//   final FocusNode _emailFocusNode = FocusNode();
//
//   DateTime? _selectedBirthDate;
//
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _birthDateController.dispose();
//
//     _nameFocusNode.dispose();
//     _emailFocusNode.dispose();
//
//     super.dispose();
//   }
//
//   bool get _isValid {
//     final name = _nameController.text.trim();
//
//     if (name.length < 2) {
//       return false;
//     }
//
//     if (_selectedBirthDate == null) {
//       return false;
//     }
//
//
//     final email = _emailController.text.trim();
//
//     if (email.isNotEmpty) {
//       final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
//
//       if (!emailRegex.hasMatch(email)) {
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   // ============================================================
//   // DATE PICKER
//   // ============================================================
//
//   Future<void> _selectBirthDate() async {
//     FocusScope.of(context).unfocus();
//
//     final DateTime now = DateTime.now();
//
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(now.year - 18, now.month, now.day),
//       firstDate: DateTime(1900),
//       lastDate: now,
//       helpText: 'Select your date of birth',
//       cancelText: 'Cancel',
//       confirmText: 'Confirm',
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: kSenseColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Color(0xFF171A2D),
//             ),
//             datePickerTheme: DatePickerThemeData(
//               backgroundColor: Colors.white,
//               headerBackgroundColor: kSenseColor,
//               headerForegroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(28),
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate == null) {
//       return;
//     }
//
//     setState(() {
//       _selectedBirthDate = pickedDate;
//
//       _birthDateController.text =
//           '${pickedDate.day.toString().padLeft(2, '0')}/'
//           '${pickedDate.month.toString().padLeft(2, '0')}/'
//           '${pickedDate.year}';
//     });
//   }
//
//   // ============================================================
//   // COMPLETE PROFILE
//   // ============================================================
//
//   Future<void> _completeProfile() async {
//     if (_isLoading) return;
//
//     FocusScope.of(context).unfocus();
//
//     if (!_isValid) {
//       _showMessage(
//         message: 'Please complete all fields',
//         icon: Icons.info_outline_rounded,
//       );
//
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     // ==========================================================
//     // SAVE DATA TO SHARED PREFERENCES 👈 جديد
//     // ==========================================================
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.setString('user_name', _nameController.text.trim());
//     await prefs.setString('user_email', _emailController.text.trim());
//     await prefs.setString('user_birth_date', _birthDateController.text);
//     await prefs.setString('user_phone', widget.phoneNumber);
//
//     // ==========================================================
//     // TEMPORARY API SIMULATION
//     // ==========================================================
//     //
//     // لاحقًا هنا سنرسل:
//     //
//     // name
//     // birthDate
//     // email (optional)
//     // phoneNumber
//     //
//     // إلى الـ API.
//     //
//
//     await Future.delayed(const Duration(milliseconds: 900));
//
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     // ==========================================================
//     // GO TO HOME
//     // ==========================================================
//
//     Navigator.of(context).pushReplacement(
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 600),
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return HomeScreen(userName: _nameController.text.trim());
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
//                 begin: const Offset(0, 0.03),
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
//         backgroundColor: kSenseColor,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   // ============================================================
//   // BUILD
//   // ============================================================
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F5F8),
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           // ======================================================
//           // BACKGROUND
//           // ======================================================
//           const _ProfileBackground(),
//
//           // ======================================================
//           // LOGO WATERMARK
//           // ======================================================
//           Positioned(
//             top: -45,
//             left: -30,
//             right: -30,
//             child: IgnorePointer(
//               child: Opacity(
//                 opacity: 0.055,
//                 child: Image.asset(
//                   'assets/logo.png',
//                   height: 320,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//
//           // ======================================================
//           // CONTENT
//           // ======================================================
//           SafeArea(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.fromLTRB(22, 25, 22, 30),
//               child: Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 430),
//                   child: Column(
//                     children: [
//                       // ==================================================
//                       // LOGO
//                       // ==================================================
//                       const SizedBox(height: 60),
//
//                       // ==================================================
//                       // TITLE
//                       // ==================================================
//                       const Text(
//                         'Complete Your Profile',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 29,
//                           fontWeight: FontWeight.w800,
//                           letterSpacing: -0.7,
//                           color: Color(0xFF171A2D),
//                         ),
//                       ),
//
//                       const SizedBox(height: 27),
//
//                       // ==================================================
//                       // CARD
//                       // ==================================================
//                       Container(
//                         padding: const EdgeInsets.fromLTRB(22, 25, 22, 23),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.88),
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(
//                             color: kSenseColor.withOpacity(0.10),
//                             width: 1.2,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.055),
//                               blurRadius: 35,
//                               spreadRadius: -6,
//                               offset: const Offset(0, 18),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // ============================================
//                             // SECTION TITLE
//                             // ============================================
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 42,
//                                   height: 42,
//                                   decoration: BoxDecoration(
//                                     color: kSenseColor.withOpacity(0.09),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(
//                                     Icons.person_outline_rounded,
//                                     color: kSenseColor,
//                                     size: 23,
//                                   ),
//                                 ),
//
//                                 const SizedBox(width: 12),
//
//                                 const Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Personal details',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w800,
//                                         color: Color(0xFF202235),
//                                       ),
//                                     ),
//                                     SizedBox(height: 2),
//                                     Text(
//                                       'Tell us a little about yourself',
//                                       style: TextStyle(
//                                         fontSize: 11.5,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xFF777C8D),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 25),
//
//                             // ============================================
//                             // NAME
//                             // ============================================
//                             _buildLabel('name', Icons.person_outline_rounded),
//
//                             const SizedBox(height: 8),
//
//                             TextField(
//                               controller: _nameController,
//                               focusNode: _nameFocusNode,
//                               enabled: !_isLoading,
//                               textCapitalization: TextCapitalization.words,
//                               textInputAction: TextInputAction.next,
//                               onChanged: (_) {
//                                 setState(() {});
//                               },
//                               onSubmitted: (_) {
//                                 _emailFocusNode.requestFocus();
//                               },
//                               style: _fieldTextStyle(),
//                               decoration: _fieldDecoration(
//                                 hint: 'Enter your name',
//                                 icon: Icons.person_outline_rounded,
//                               ),
//                             ),
//
//                             const SizedBox(height: 19),
//
//                             // ============================================
//                             // DATE OF BIRTH
//                             // ============================================
//                             _buildLabel('Date of birth', Icons.cake_outlined),
//
//                             const SizedBox(height: 8),
//
//                             GestureDetector(
//                               onTap: _isLoading ? null : _selectBirthDate,
//                               child: AbsorbPointer(
//                                 child: TextField(
//                                   controller: _birthDateController,
//                                   enabled: !_isLoading,
//                                   style: _fieldTextStyle(),
//                                   decoration: _fieldDecoration(
//                                     hint: 'Select your date of birth',
//                                     icon: Icons.calendar_month_outlined,
//                                     suffixIcon: const Icon(
//                                       Icons.keyboard_arrow_down_rounded,
//                                       color: kSenseColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             const SizedBox(height: 19),
//
//                             // ============================================
//                             // EMAIL (OPTIONAL)
//                             // ============================================
//                             _buildLabel(
//                               'Email address (optional)',
//                               Icons.email_outlined,
//                             ),
//
//                             const SizedBox(height: 8),
//
//                             TextField(
//                               controller: _emailController,
//                               focusNode: _emailFocusNode,
//                               enabled: !_isLoading,
//                               keyboardType: TextInputType.emailAddress,
//                               textInputAction: TextInputAction.done,
//                               autocorrect: false,
//                               onChanged: (_) {
//                                 setState(() {});
//                               },
//                               onSubmitted: (_) {
//                                 if (_isValid) {
//                                   _completeProfile();
//                                 }
//                               },
//                               style: _fieldTextStyle(),
//                               decoration: _fieldDecoration(
//                                 hint: 'Enter your email address (optional)',
//                                 icon: Icons.email_outlined,
//                               ),
//                             ),
//
//                             const SizedBox(height: 25),
//
//                             // ============================================
//                             // CONTINUE BUTTON
//                             // ============================================
//                             _buildContinueButton(),
//                           ],
//                         ),
//                       ),
//
//                       const SizedBox(height: 18),
//
//                       // ==================================================
//                       // PHONE INFO
//                       // ==================================================
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.phone_rounded,
//                             size: 14,
//                             color: kSenseColor,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             widget.phoneNumber,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF6D7282),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 9),
//
//                       // ==================================================
//                       // SECURITY
//                       // ==================================================
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.verified_user_rounded,
//                             size: 14,
//                             color: kSenseColor.withOpacity(0.75),
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             'Your information is secure',
//                             style: TextStyle(
//                               fontSize: 11.5,
//                               fontWeight: FontWeight.w600,
//                               color: const Color(0xFF777C8D).withOpacity(0.85),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // LABEL
//   // ============================================================
//
//   Widget _buildLabel(String text, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: kSenseColor),
//         const SizedBox(width: 7),
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF35394B),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // FIELD STYLE
//   // ============================================================
//
//   TextStyle _fieldTextStyle() {
//     return const TextStyle(
//       fontSize: 15.5,
//       fontWeight: FontWeight.w600,
//       color: Color(0xFF171A2D),
//     );
//   }
//
//   // ============================================================
//   // FIELD DECORATION
//   // ============================================================
//
//   InputDecoration _fieldDecoration({
//     required String hint,
//     required IconData icon,
//     Widget? suffixIcon,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.black.withOpacity(0.25),
//       ),
//
//       prefixIcon: Icon(icon, color: kSenseColor.withOpacity(0.75), size: 21),
//
//       suffixIcon: suffixIcon,
//
//       filled: true,
//
//       fillColor: kSenseColor.withOpacity(0.025),
//
//       contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
//
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.12),
//           width: 1.2,
//         ),
//       ),
//
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.14),
//           width: 1.2,
//         ),
//       ),
//
//       focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(17)),
//         borderSide: BorderSide(color: kSenseColor, width: 1.7),
//       ),
//
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.08),
//           width: 1.0,
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // CONTINUE BUTTON
//   // ============================================================
//
//   Widget _buildContinueButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: _isValid && !_isLoading ? _completeProfile : null,
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
//           child: _isLoading
//               ? const SizedBox(
//                   key: ValueKey('loading'),
//                   width: 23,
//                   height: 23,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.5,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 )
//               : const Row(
//                   key: ValueKey('continue'),
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Continue',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     SizedBox(width: 9),
//                     Icon(Icons.arrow_forward_rounded, size: 21),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
//
// // =================================================================
// // BACKGROUND
// // =================================================================
//
// class _ProfileBackground extends StatelessWidget {
//   const _ProfileBackground();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFFFFAFD), Color(0xFFF7F3F7), Color(0xFFFFF8FC)],
//         ),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: -130,
//             right: -120,
//             child: _GlowCircle(size: 350, color: const Color(0xFFF4C8DF)),
//           ),
//
//           Positioned(
//             top: 280,
//             left: -170,
//             child: _GlowCircle(size: 330, color: const Color(0xFFF8D9E9)),
//           ),
//
//           Positioned(
//             bottom: -160,
//             right: -100,
//             child: _GlowCircle(size: 380, color: const Color(0xFFF5D7E6)),
//           ),
//
//           Positioned(
//             bottom: -130,
//             left: -120,
//             child: _GlowCircle(size: 300, color: const Color(0xFFF9E5F0)),
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

// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
// const Color kSenseColor = Color(0xFF990056);
//
// class CompleteProfileScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   /// 👈 إذا true يعني المستخدم فاتح الشاشة من "تعديل البروفايل"
//   /// بدل التسجيل الأول مرة (بيغيّر عنوان الزر مثلاً)
//   final bool isEditing;
//
//   const CompleteProfileScreen({
//     super.key,
//     required this.phoneNumber,
//     this.isEditing = false,
//   });
//
//   @override
//   State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
// }
//
// class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
//   // ============================================================
//   // CONTROLLERS
//   // ============================================================
//
//   final TextEditingController _nameController = TextEditingController();
//
//   final TextEditingController _emailController = TextEditingController();
//
//   final TextEditingController _birthDateController = TextEditingController();
//
//   // ============================================================
//   // FOCUS NODES
//   // ============================================================
//
//   final FocusNode _nameFocusNode = FocusNode();
//   final FocusNode _emailFocusNode = FocusNode();
//
//   // ============================================================
//   // STATE
//   // ============================================================
//
//   DateTime? _selectedBirthDate;
//
//   bool _isLoading = false;
//
//   bool _isLoadingInitialData = true;
//
//   // ============================================================
//   // INIT STATE
//   // ============================================================
//
//   @override
//   void initState() {
//     super.initState();
//     _loadExistingProfile();
//   }
//
//   // ============================================================
//   // LOAD EXISTING PROFILE (إذا موجود)
//   // ============================================================
//
//   Future<void> _loadExistingProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final savedName = prefs.getString('user_name') ?? '';
//     final savedEmail = prefs.getString('user_email') ?? '';
//     final savedBirthDate = prefs.getString('user_birth_date') ?? '';
//
//     if (!mounted) return;
//
//     setState(() {
//       _nameController.text = savedName;
//       _emailController.text = savedEmail;
//       _birthDateController.text = savedBirthDate;
//
//       // نحاول نحول تاريخ الميلاد لـ DateTime
//       _selectedBirthDate = _parseDate(savedBirthDate);
//
//       _isLoadingInitialData = false;
//     });
//   }
//
//   // ============================================================
//   // PARSE DATE
//   // ============================================================
//
//   DateTime? _parseDate(String date) {
//     if (date.isEmpty) return null;
//
//     try {
//       final parts = date.split('/');
//       if (parts.length != 3) return null;
//
//       final day = int.parse(parts[0]);
//       final month = int.parse(parts[1]);
//       final year = int.parse(parts[2]);
//
//       return DateTime(year, month, day);
//     } catch (_) {
//       return null;
//     }
//   }
//
//   // ============================================================
//   // DISPOSE
//   // ============================================================
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _birthDateController.dispose();
//
//     _nameFocusNode.dispose();
//     _emailFocusNode.dispose();
//
//     super.dispose();
//   }
//
//   // ============================================================
//   // VALIDATION
//   // ============================================================
//
//   bool get _isValid {
//     final name = _nameController.text.trim();
//
//     if (name.length < 2) {
//       return false;
//     }
//
//     if (_selectedBirthDate == null) {
//       return false;
//     }
//
//     // الإيميل اختياري: نتحقق منه فقط إذا تم إدخاله
//     final email = _emailController.text.trim();
//
//     if (email.isNotEmpty) {
//       final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
//
//       if (!emailRegex.hasMatch(email)) {
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   // ============================================================
//   // DATE PICKER
//   // ============================================================
//
//   Future<void> _selectBirthDate() async {
//     FocusScope.of(context).unfocus();
//
//     final DateTime now = DateTime.now();
//
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate:
//           _selectedBirthDate ?? DateTime(now.year - 18, now.month, now.day),
//       firstDate: DateTime(1900),
//       lastDate: now,
//       helpText: 'Select your date of birth',
//       cancelText: 'Cancel',
//       confirmText: 'Confirm',
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: kSenseColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Color(0xFF171A2D),
//             ),
//             datePickerTheme: DatePickerThemeData(
//               backgroundColor: Colors.white,
//               headerBackgroundColor: kSenseColor,
//               headerForegroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(28),
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate == null) {
//       return;
//     }
//
//     setState(() {
//       _selectedBirthDate = pickedDate;
//
//       _birthDateController.text =
//           '${pickedDate.day.toString().padLeft(2, '0')}/'
//           '${pickedDate.month.toString().padLeft(2, '0')}/'
//           '${pickedDate.year}';
//     });
//   }
//
//   // ============================================================
//   // COMPLETE PROFILE / SAVE
//   // ============================================================
//
//   Future<void> _completeProfile() async {
//     if (_isLoading) return;
//
//     FocusScope.of(context).unfocus();
//
//     if (!_isValid) {
//       _showMessage(
//         message: 'Please complete all fields',
//         icon: Icons.info_outline_rounded,
//       );
//
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     // ==========================================================
//     // SAVE DATA TO SHARED PREFERENCES
//     // ==========================================================
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.setString('user_name', _nameController.text.trim());
//     await prefs.setString('user_email', _emailController.text.trim());
//     await prefs.setString('user_birth_date', _birthDateController.text);
//     await prefs.setString('user_phone', widget.phoneNumber);
//
//     // ==========================================================
//     // TEMPORARY API SIMULATION
//     // ==========================================================
//     //
//     // لاحقًا هنا سنرسل:
//     //
//     // name
//     // birthDate
//     // email (optional)
//     // phoneNumber
//     //
//     // إلى الـ API.
//     //
//
//     await Future.delayed(const Duration(milliseconds: 900));
//
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     // ==========================================================
//     // إذا كنا في وضع التعديل → نرجع للشاشة السابقة
//     // ==========================================================
//     if (widget.isEditing) {
//       _showMessage(
//         message: 'Profile updated successfully',
//         icon: Icons.check_circle_outline_rounded,
//       );
//
//       await Future.delayed(const Duration(milliseconds: 700));
//
//       if (!mounted) return;
//
//       Navigator.of(context).pop();
//
//       return;
//     }
//
//     // ==========================================================
//     // GO TO HOME (تسجيل أول مرة)
//     // ==========================================================
//
//     Navigator.of(context).pushReplacement(
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 600),
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return HomeScreen(userName: _nameController.text.trim());
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
//                 begin: const Offset(0, 0.03),
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
//         backgroundColor: kSenseColor,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   // ============================================================
//   // BUILD
//   // ============================================================
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F5F8),
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           // ======================================================
//           // BACKGROUND
//           // ======================================================
//           const _ProfileBackground(),
//
//           // ======================================================
//           // LOGO WATERMARK
//           // ======================================================
//           Positioned(
//             top: -45,
//             left: -30,
//             right: -30,
//             child: IgnorePointer(
//               child: Opacity(
//                 opacity: 0.055,
//                 child: Image.asset(
//                   'assets/logo.png',
//                   height: 320,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//
//           // ======================================================
//           // CONTENT
//           // ======================================================
//           SafeArea(
//             child: _isLoadingInitialData
//                 ? const Center(
//                     child: CircularProgressIndicator(color: kSenseColor),
//                   )
//                 : SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.fromLTRB(22, 25, 22, 30),
//                     child: Center(
//                       child: ConstrainedBox(
//                         constraints: const BoxConstraints(maxWidth: 430),
//                         child: Column(
//                           children: [
//                             // ==================================================
//                             // LOGO
//                             // ==================================================
//                             const SizedBox(height: 60),
//
//                             // ==================================================
//                             // TITLE
//                             // ==================================================
//                             Text(
//                               widget.isEditing
//                                   ? 'Edit Your Profile'
//                                   : 'Complete Your Profile',
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                 fontSize: 29,
//                                 fontWeight: FontWeight.w800,
//                                 letterSpacing: -0.7,
//                                 color: Color(0xFF171A2D),
//                               ),
//                             ),
//
//                             const SizedBox(height: 27),
//
//                             // ==================================================
//                             // CARD
//                             // ==================================================
//                             Container(
//                               padding: const EdgeInsets.fromLTRB(
//                                 22,
//                                 25,
//                                 22,
//                                 23,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.88),
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                   color: kSenseColor.withOpacity(0.10),
//                                   width: 1.2,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.055),
//                                     blurRadius: 35,
//                                     spreadRadius: -6,
//                                     offset: const Offset(0, 18),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // ============================================
//                                   // SECTION TITLE
//                                   // ============================================
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: 42,
//                                         height: 42,
//                                         decoration: BoxDecoration(
//                                           color: kSenseColor.withOpacity(0.09),
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: const Icon(
//                                           Icons.person_outline_rounded,
//                                           color: kSenseColor,
//                                           size: 23,
//                                         ),
//                                       ),
//
//                                       const SizedBox(width: 12),
//
//                                       const Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Personal details',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w800,
//                                               color: Color(0xFF202235),
//                                             ),
//                                           ),
//                                           SizedBox(height: 2),
//                                           Text(
//                                             'Tell us a little about yourself',
//                                             style: TextStyle(
//                                               fontSize: 11.5,
//                                               fontWeight: FontWeight.w500,
//                                               color: Color(0xFF777C8D),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//
//                                   const SizedBox(height: 25),
//
//                                   // ============================================
//                                   // NAME
//                                   // ============================================
//                                   _buildLabel(
//                                     'name',
//                                     Icons.person_outline_rounded,
//                                   ),
//
//                                   const SizedBox(height: 8),
//
//                                   TextField(
//                                     controller: _nameController,
//                                     focusNode: _nameFocusNode,
//                                     enabled: !_isLoading,
//                                     textCapitalization:
//                                         TextCapitalization.words,
//                                     textInputAction: TextInputAction.next,
//                                     onChanged: (_) {
//                                       setState(() {});
//                                     },
//                                     onSubmitted: (_) {
//                                       _emailFocusNode.requestFocus();
//                                     },
//                                     style: _fieldTextStyle(),
//                                     decoration: _fieldDecoration(
//                                       hint: 'Enter your name',
//                                       icon: Icons.person_outline_rounded,
//                                     ),
//                                   ),
//
//                                   const SizedBox(height: 19),
//
//                                   // ============================================
//                                   // DATE OF BIRTH
//                                   // ============================================
//                                   _buildLabel(
//                                     'Date of birth',
//                                     Icons.cake_outlined,
//                                   ),
//
//                                   const SizedBox(height: 8),
//
//                                   GestureDetector(
//                                     onTap: _isLoading ? null : _selectBirthDate,
//                                     child: AbsorbPointer(
//                                       child: TextField(
//                                         controller: _birthDateController,
//                                         enabled: !_isLoading,
//                                         style: _fieldTextStyle(),
//                                         decoration: _fieldDecoration(
//                                           hint: 'Select your date of birth',
//                                           icon: Icons.calendar_month_outlined,
//                                           suffixIcon: const Icon(
//                                             Icons.keyboard_arrow_down_rounded,
//                                             color: kSenseColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   const SizedBox(height: 19),
//
//                                   // ============================================
//                                   // EMAIL (OPTIONAL)
//                                   // ============================================
//                                   _buildLabel(
//                                     'Email address (optional)',
//                                     Icons.email_outlined,
//                                   ),
//
//                                   const SizedBox(height: 8),
//
//                                   TextField(
//                                     controller: _emailController,
//                                     focusNode: _emailFocusNode,
//                                     enabled: !_isLoading,
//                                     keyboardType: TextInputType.emailAddress,
//                                     textInputAction: TextInputAction.done,
//                                     autocorrect: false,
//                                     onChanged: (_) {
//                                       setState(() {});
//                                     },
//                                     onSubmitted: (_) {
//                                       if (_isValid) {
//                                         _completeProfile();
//                                       }
//                                     },
//                                     style: _fieldTextStyle(),
//                                     decoration: _fieldDecoration(
//                                       hint:
//                                           'Enter your email address (optional)',
//                                       icon: Icons.email_outlined,
//                                     ),
//                                   ),
//
//                                   const SizedBox(height: 25),
//
//                                   // ============================================
//                                   // CONTINUE / SAVE BUTTON
//                                   // ============================================
//                                   _buildContinueButton(),
//                                 ],
//                               ),
//                             ),
//
//                             const SizedBox(height: 18),
//
//                             // ==================================================
//                             // PHONE INFO
//                             // ==================================================
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.phone_rounded,
//                                   size: 14,
//                                   color: kSenseColor,
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   widget.phoneNumber,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF6D7282),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 9),
//
//                             // ==================================================
//                             // SECURITY
//                             // ==================================================
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.verified_user_rounded,
//                                   size: 14,
//                                   color: kSenseColor.withOpacity(0.75),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   'Your information is secure',
//                                   style: TextStyle(
//                                     fontSize: 11.5,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(
//                                       0xFF777C8D,
//                                     ).withOpacity(0.85),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // LABEL
//   // ============================================================
//
//   Widget _buildLabel(String text, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: kSenseColor),
//         const SizedBox(width: 7),
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF35394B),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // FIELD STYLE
//   // ============================================================
//
//   TextStyle _fieldTextStyle() {
//     return const TextStyle(
//       fontSize: 15.5,
//       fontWeight: FontWeight.w600,
//       color: Color(0xFF171A2D),
//     );
//   }
//
//   // ============================================================
//   // FIELD DECORATION
//   // ============================================================
//
//   InputDecoration _fieldDecoration({
//     required String hint,
//     required IconData icon,
//     Widget? suffixIcon,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.black.withOpacity(0.25),
//       ),
//
//       prefixIcon: Icon(icon, color: kSenseColor.withOpacity(0.75), size: 21),
//
//       suffixIcon: suffixIcon,
//
//       filled: true,
//
//       fillColor: kSenseColor.withOpacity(0.025),
//
//       contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
//
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.12),
//           width: 1.2,
//         ),
//       ),
//
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.14),
//           width: 1.2,
//         ),
//       ),
//
//       focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(17)),
//         borderSide: BorderSide(color: kSenseColor, width: 1.7),
//       ),
//
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.08),
//           width: 1.0,
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // CONTINUE BUTTON
//   // ============================================================
//
//   Widget _buildContinueButton() {
//     final buttonText = widget.isEditing ? 'Save Changes' : 'Continue';
//
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: _isValid && !_isLoading ? _completeProfile : null,
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
//           child: _isLoading
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
//                   key: const ValueKey('continue'),
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       buttonText,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(width: 9),
//                     Icon(
//                       widget.isEditing
//                           ? Icons.check_rounded
//                           : Icons.arrow_forward_rounded,
//                       size: 21,
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
//
// // =================================================================
// // BACKGROUND
// // =================================================================
//
// class _ProfileBackground extends StatelessWidget {
//   const _ProfileBackground();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFFFFAFD), Color(0xFFF7F3F7), Color(0xFFFFF8FC)],
//         ),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: -130,
//             right: -120,
//             child: _GlowCircle(size: 350, color: const Color(0xFFF4C8DF)),
//           ),
//
//           Positioned(
//             top: 280,
//             left: -170,
//             child: _GlowCircle(size: 330, color: const Color(0xFFF8D9E9)),
//           ),
//
//           Positioned(
//             bottom: -160,
//             right: -100,
//             child: _GlowCircle(size: 380, color: const Color(0xFFF5D7E6)),
//           ),
//
//           Positioned(
//             bottom: -130,
//             left: -120,
//             child: _GlowCircle(size: 300, color: const Color(0xFFF9E5F0)),
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

// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
// const Color kSenseColor = Color(0xFF990056);
//
// class CompleteProfileScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   /// 👈 إذا true يعني المستخدم فاتح الشاشة من "تعديل البروفايل"
//   /// بدل التسجيل الأول مرة (بيغيّر عنوان الزر مثلاً)
//   final bool isEditing;
//
//   const CompleteProfileScreen({
//     super.key,
//     required this.phoneNumber,
//     this.isEditing = false,
//   });
//
//   @override
//   State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
// }
//
// class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
//   // ============================================================
//   // CONTROLLERS
//   // ============================================================
//
//   final TextEditingController _nameController = TextEditingController();
//
//   final TextEditingController _emailController = TextEditingController();
//
//   final TextEditingController _birthDateController = TextEditingController();
//
//   // ============================================================
//   // FOCUS NODES
//   // ============================================================
//
//   final FocusNode _nameFocusNode = FocusNode();
//   final FocusNode _emailFocusNode = FocusNode();
//
//   // ============================================================
//   // STATE
//   // ============================================================
//
//   DateTime? _selectedBirthDate;
//
//   bool _isLoading = false;
//
//   bool _isLoadingInitialData = true;
//
//   // ============================================================
//   // INIT STATE
//   // ============================================================
//
//   @override
//   void initState() {
//     super.initState();
//     _loadExistingProfile();
//   }
//
//   // ============================================================
//   // LOAD EXISTING PROFILE (إذا موجود)
//   // ============================================================
//
//   Future<void> _loadExistingProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     // 👈 نجيب رقم التلفون المحفوظ من قبل
//     final savedPhone = prefs.getString('user_phone') ?? '';
//
//     // 👈 إذا الرقم الحالي **مختلف** عن المحفوظ
//     // يعني مستخدم جديد → ما نحمّل بيانات قديمة
//     if (savedPhone != widget.phoneNumber) {
//       if (!mounted) return;
//
//       setState(() {
//         _isLoadingInitialData = false;
//       });
//
//       return;
//     }
//
//     // 👈 نفس الرقم → نحمّل (وضع التعديل)
//     final savedName = prefs.getString('user_name') ?? '';
//     final savedEmail = prefs.getString('user_email') ?? '';
//     final savedBirthDate = prefs.getString('user_birth_date') ?? '';
//
//     if (!mounted) return;
//
//     setState(() {
//       _nameController.text = savedName;
//       _emailController.text = savedEmail;
//       _birthDateController.text = savedBirthDate;
//
//       // نحاول نحول تاريخ الميلاد لـ DateTime
//       _selectedBirthDate = _parseDate(savedBirthDate);
//
//       _isLoadingInitialData = false;
//     });
//   }
//
//   // ============================================================
//   // PARSE DATE
//   // ============================================================
//
//   DateTime? _parseDate(String date) {
//     if (date.isEmpty) return null;
//
//     try {
//       final parts = date.split('/');
//       if (parts.length != 3) return null;
//
//       final day = int.parse(parts[0]);
//       final month = int.parse(parts[1]);
//       final year = int.parse(parts[2]);
//
//       return DateTime(year, month, day);
//     } catch (_) {
//       return null;
//     }
//   }
//
//   // ============================================================
//   // DISPOSE
//   // ============================================================
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _birthDateController.dispose();
//
//     _nameFocusNode.dispose();
//     _emailFocusNode.dispose();
//
//     super.dispose();
//   }
//
//   // ============================================================
//   // VALIDATION
//   // ============================================================
//
//   bool get _isValid {
//     final name = _nameController.text.trim();
//
//     if (name.length < 2) {
//       return false;
//     }
//
//     if (_selectedBirthDate == null) {
//       return false;
//     }
//
//     // الإيميل اختياري: نتحقق منه فقط إذا تم إدخاله
//     final email = _emailController.text.trim();
//
//     if (email.isNotEmpty) {
//       final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
//
//       if (!emailRegex.hasMatch(email)) {
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   // ============================================================
//   // DATE PICKER
//   // ============================================================
//
//   Future<void> _selectBirthDate() async {
//     FocusScope.of(context).unfocus();
//
//     final DateTime now = DateTime.now();
//
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate:
//           _selectedBirthDate ?? DateTime(now.year - 18, now.month, now.day),
//       firstDate: DateTime(1900),
//       lastDate: now,
//       helpText: 'Select your date of birth',
//       cancelText: 'Cancel',
//       confirmText: 'Confirm',
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: kSenseColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Color(0xFF171A2D),
//             ),
//             datePickerTheme: DatePickerThemeData(
//               backgroundColor: Colors.white,
//               headerBackgroundColor: kSenseColor,
//               headerForegroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(28),
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate == null) {
//       return;
//     }
//
//     setState(() {
//       _selectedBirthDate = pickedDate;
//
//       _birthDateController.text =
//           '${pickedDate.day.toString().padLeft(2, '0')}/'
//           '${pickedDate.month.toString().padLeft(2, '0')}/'
//           '${pickedDate.year}';
//     });
//   }
//
//   // ============================================================
//   // COMPLETE PROFILE / SAVE
//   // ============================================================
//
//   Future<void> _completeProfile() async {
//     if (_isLoading) return;
//
//     FocusScope.of(context).unfocus();
//
//     if (!_isValid) {
//       _showMessage(
//         message: 'Please complete all fields',
//         icon: Icons.info_outline_rounded,
//       );
//
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     // ==========================================================
//     // SAVE DATA TO SHARED PREFERENCES
//     // ==========================================================
//     final prefs = await SharedPreferences.getInstance();
//
//     // 👈 إذا مستخدم جديد (مو وضع تعديل) → نمسح البيانات القديمة
//     // عشان ما تختلط بيانات مستخدم سابق
//     if (!widget.isEditing) {
//       await prefs.remove('user_name');
//       await prefs.remove('user_email');
//       await prefs.remove('user_birth_date');
//     }
//
//     // نحفظ البيانات الجديدة
//     await prefs.setString('user_name', _nameController.text.trim());
//     await prefs.setString('user_email', _emailController.text.trim());
//     await prefs.setString('user_birth_date', _birthDateController.text);
//     await prefs.setString('user_phone', widget.phoneNumber);
//
//     // ==========================================================
//     // TEMPORARY API SIMULATION
//     // ==========================================================
//     //
//     // لاحقًا هنا سنرسل:
//     //
//     // name
//     // birthDate
//     // email (optional)
//     // phoneNumber
//     //
//     // إلى الـ API.
//     //
//
//     await Future.delayed(const Duration(milliseconds: 900));
//
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     // ==========================================================
//     // إذا كنا في وضع التعديل → نرجع للشاشة السابقة
//     // ==========================================================
//     if (widget.isEditing) {
//       _showMessage(
//         message: 'Profile updated successfully',
//         icon: Icons.check_circle_outline_rounded,
//       );
//
//       await Future.delayed(const Duration(milliseconds: 700));
//
//       if (!mounted) return;
//
//       Navigator.of(context).pop();
//
//       return;
//     }
//
//     // ==========================================================
//     // GO TO HOME (تسجيل أول مرة)
//     // ==========================================================
//
//     Navigator.of(context).pushReplacement(
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 600),
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return HomeScreen(userName: _nameController.text.trim());
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
//                 begin: const Offset(0, 0.03),
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
//         backgroundColor: kSenseColor,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   // ============================================================
//   // BUILD
//   // ============================================================
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F5F8),
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           // ======================================================
//           // BACKGROUND
//           // ======================================================
//           const _ProfileBackground(),
//
//           // ======================================================
//           // LOGO WATERMARK
//           // ======================================================
//           Positioned(
//             top: -45,
//             left: -30,
//             right: -30,
//             child: IgnorePointer(
//               child: Opacity(
//                 opacity: 0.055,
//                 child: Image.asset(
//                   'assets/logo.png',
//                   height: 320,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//
//           // ======================================================
//           // CONTENT
//           // ======================================================
//           SafeArea(
//             child: _isLoadingInitialData
//                 ? const Center(
//                     child: CircularProgressIndicator(color: kSenseColor),
//                   )
//                 : SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.fromLTRB(22, 25, 22, 30),
//                     child: Center(
//                       child: ConstrainedBox(
//                         constraints: const BoxConstraints(maxWidth: 430),
//                         child: Column(
//                           children: [
//                             // ==================================================
//                             // LOGO
//                             // ==================================================
//                             const SizedBox(height: 60),
//
//                             // ==================================================
//                             // TITLE
//                             // ==================================================
//                             Text(
//                               widget.isEditing
//                                   ? 'Edit Your Profile'
//                                   : 'Complete Your Profile',
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                 fontSize: 29,
//                                 fontWeight: FontWeight.w800,
//                                 letterSpacing: -0.7,
//                                 color: Color(0xFF171A2D),
//                               ),
//                             ),
//
//                             const SizedBox(height: 27),
//
//                             // ==================================================
//                             // CARD
//                             // ==================================================
//                             Container(
//                               padding: const EdgeInsets.fromLTRB(
//                                 22,
//                                 25,
//                                 22,
//                                 23,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.88),
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                   color: kSenseColor.withOpacity(0.10),
//                                   width: 1.2,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.055),
//                                     blurRadius: 35,
//                                     spreadRadius: -6,
//                                     offset: const Offset(0, 18),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // ============================================
//                                   // SECTION TITLE
//                                   // ============================================
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: 42,
//                                         height: 42,
//                                         decoration: BoxDecoration(
//                                           color: kSenseColor.withOpacity(0.09),
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: const Icon(
//                                           Icons.person_outline_rounded,
//                                           color: kSenseColor,
//                                           size: 23,
//                                         ),
//                                       ),
//
//                                       const SizedBox(width: 12),
//
//                                       const Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Personal details',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w800,
//                                               color: Color(0xFF202235),
//                                             ),
//                                           ),
//                                           SizedBox(height: 2),
//                                           Text(
//                                             'Tell us a little about yourself',
//                                             style: TextStyle(
//                                               fontSize: 11.5,
//                                               fontWeight: FontWeight.w500,
//                                               color: Color(0xFF777C8D),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//
//                                   const SizedBox(height: 25),
//
//                                   // ============================================
//                                   // NAME
//                                   // ============================================
//                                   _buildLabel(
//                                     'name',
//                                     Icons.person_outline_rounded,
//                                   ),
//
//                                   const SizedBox(height: 8),
//
//                                   TextField(
//                                     controller: _nameController,
//                                     focusNode: _nameFocusNode,
//                                     enabled: !_isLoading,
//                                     textCapitalization:
//                                         TextCapitalization.words,
//                                     textInputAction: TextInputAction.next,
//                                     onChanged: (_) {
//                                       setState(() {});
//                                     },
//                                     onSubmitted: (_) {
//                                       _emailFocusNode.requestFocus();
//                                     },
//                                     style: _fieldTextStyle(),
//                                     decoration: _fieldDecoration(
//                                       hint: 'Enter your name',
//                                       icon: Icons.person_outline_rounded,
//                                     ),
//                                   ),
//
//                                   const SizedBox(height: 19),
//
//                                   // ============================================
//                                   // DATE OF BIRTH
//                                   // ============================================
//                                   _buildLabel(
//                                     'Date of birth',
//                                     Icons.cake_outlined,
//                                   ),
//
//                                   const SizedBox(height: 8),
//
//                                   GestureDetector(
//                                     onTap: _isLoading ? null : _selectBirthDate,
//                                     child: AbsorbPointer(
//                                       child: TextField(
//                                         controller: _birthDateController,
//                                         enabled: !_isLoading,
//                                         style: _fieldTextStyle(),
//                                         decoration: _fieldDecoration(
//                                           hint: 'Select your date of birth',
//                                           icon: Icons.calendar_month_outlined,
//                                           suffixIcon: const Icon(
//                                             Icons.keyboard_arrow_down_rounded,
//                                             color: kSenseColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   const SizedBox(height: 19),
//
//                                   // ============================================
//                                   // EMAIL (OPTIONAL)
//                                   // ============================================
//                                   _buildLabel(
//                                     'Email address (optional)',
//                                     Icons.email_outlined,
//                                   ),
//
//                                   const SizedBox(height: 8),
//
//                                   TextField(
//                                     controller: _emailController,
//                                     focusNode: _emailFocusNode,
//                                     enabled: !_isLoading,
//                                     keyboardType: TextInputType.emailAddress,
//                                     textInputAction: TextInputAction.done,
//                                     autocorrect: false,
//                                     onChanged: (_) {
//                                       setState(() {});
//                                     },
//                                     onSubmitted: (_) {
//                                       if (_isValid) {
//                                         _completeProfile();
//                                       }
//                                     },
//                                     style: _fieldTextStyle(),
//                                     decoration: _fieldDecoration(
//                                       hint:
//                                           'Enter your email address (optional)',
//                                       icon: Icons.email_outlined,
//                                     ),
//                                   ),
//
//                                   const SizedBox(height: 25),
//
//                                   // ============================================
//                                   // CONTINUE / SAVE BUTTON
//                                   // ============================================
//                                   _buildContinueButton(),
//                                 ],
//                               ),
//                             ),
//
//                             const SizedBox(height: 18),
//
//                             // ==================================================
//                             // PHONE INFO
//                             // ==================================================
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.phone_rounded,
//                                   size: 14,
//                                   color: kSenseColor,
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   widget.phoneNumber,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF6D7282),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 9),
//
//                             // ==================================================
//                             // SECURITY
//                             // ==================================================
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.verified_user_rounded,
//                                   size: 14,
//                                   color: kSenseColor.withOpacity(0.75),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   'Your information is secure',
//                                   style: TextStyle(
//                                     fontSize: 11.5,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(
//                                       0xFF777C8D,
//                                     ).withOpacity(0.85),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // LABEL
//   // ============================================================
//
//   Widget _buildLabel(String text, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: kSenseColor),
//         const SizedBox(width: 7),
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF35394B),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // FIELD STYLE
//   // ============================================================
//
//   TextStyle _fieldTextStyle() {
//     return const TextStyle(
//       fontSize: 15.5,
//       fontWeight: FontWeight.w600,
//       color: Color(0xFF171A2D),
//     );
//   }
//
//   // ============================================================
//   // FIELD DECORATION
//   // ============================================================
//
//   InputDecoration _fieldDecoration({
//     required String hint,
//     required IconData icon,
//     Widget? suffixIcon,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.black.withOpacity(0.25),
//       ),
//
//       prefixIcon: Icon(icon, color: kSenseColor.withOpacity(0.75), size: 21),
//
//       suffixIcon: suffixIcon,
//
//       filled: true,
//
//       fillColor: kSenseColor.withOpacity(0.025),
//
//       contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
//
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.12),
//           width: 1.2,
//         ),
//       ),
//
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.14),
//           width: 1.2,
//         ),
//       ),
//
//       focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(17)),
//         borderSide: BorderSide(color: kSenseColor, width: 1.7),
//       ),
//
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(17),
//         borderSide: BorderSide(
//           color: kSenseColor.withOpacity(0.08),
//           width: 1.0,
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // CONTINUE BUTTON
//   // ============================================================
//
//   Widget _buildContinueButton() {
//     final buttonText = widget.isEditing ? 'Save Changes' : 'Continue';
//
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: _isValid && !_isLoading ? _completeProfile : null,
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
//           child: _isLoading
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
//                   key: const ValueKey('continue'),
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       buttonText,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(width: 9),
//                     Icon(
//                       widget.isEditing
//                           ? Icons.check_rounded
//                           : Icons.arrow_forward_rounded,
//                       size: 21,
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
//
// // =================================================================
// // BACKGROUND
// // =================================================================
//
// class _ProfileBackground extends StatelessWidget {
//   const _ProfileBackground();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFFFFAFD), Color(0xFFF7F3F7), Color(0xFFFFF8FC)],
//         ),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: -130,
//             right: -120,
//             child: _GlowCircle(size: 350, color: const Color(0xFFF4C8DF)),
//           ),
//
//           Positioned(
//             top: 280,
//             left: -170,
//             child: _GlowCircle(size: 330, color: const Color(0xFFF8D9E9)),
//           ),
//
//           Positioned(
//             bottom: -160,
//             right: -100,
//             child: _GlowCircle(size: 380, color: const Color(0xFFF5D7E6)),
//           ),
//
//           Positioned(
//             bottom: -130,
//             left: -120,
//             child: _GlowCircle(size: 300, color: const Color(0xFFF9E5F0)),
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

const Color kSenseColor = Color(0xFF990056);

class CompleteProfileScreen extends StatefulWidget {
  final String phoneNumber;

  /// 👈 إذا true يعني المستخدم فاتح الشاشة من "تعديل البروفايل"
  /// بدل التسجيل الأول مرة (بيغيّر عنوان الزر مثلاً)
  final bool isEditing;

  const CompleteProfileScreen({
    super.key,
    required this.phoneNumber,
    this.isEditing = false,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _birthDateController = TextEditingController();

  // ============================================================
  // FOCUS NODES
  // ============================================================

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  // ============================================================
  // STATE
  // ============================================================

  DateTime? _selectedBirthDate;

  bool _isLoading = false;

  bool _isLoadingInitialData = true;

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();
    _loadExistingProfile();
  }

  // ============================================================
  // LOAD EXISTING PROFILE
  // ============================================================

  Future<void> _loadExistingProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final savedPhone = prefs.getString('user_phone') ?? '';

    // 👈 إذا الرقم الحالي مختلف → مستخدم جديد → ما نحمّل
    if (savedPhone != widget.phoneNumber) {
      if (!mounted) return;

      setState(() {
        _isLoadingInitialData = false;
      });

      return;
    }

    // 👈 نفس الرقم → نحمّل (وضع التعديل)
    final savedName = prefs.getString('user_name') ?? '';
    final savedEmail = prefs.getString('user_email') ?? '';
    final savedBirthDate = prefs.getString('user_birth_date') ?? '';

    if (!mounted) return;

    setState(() {
      _nameController.text = savedName;
      _emailController.text = savedEmail;
      _birthDateController.text = savedBirthDate;
      _selectedBirthDate = _parseDate(savedBirthDate);
      _isLoadingInitialData = false;
    });
  }

  // ============================================================
  // PARSE DATE
  // ============================================================

  DateTime? _parseDate(String date) {
    if (date.isEmpty) return null;

    try {
      final parts = date.split('/');
      if (parts.length != 3) return null;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  // ============================================================
  // VALIDATION
  // ============================================================

  bool get _isValid {
    final name = _nameController.text.trim();

    if (name.length < 2) return false;

    if (_selectedBirthDate == null) return false;

    final email = _emailController.text.trim();

    if (email.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
      if (!emailRegex.hasMatch(email)) return false;
    }

    return true;
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectBirthDate() async {
    FocusScope.of(context).unfocus();

    final DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          _selectedBirthDate ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Select your date of birth',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kSenseColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF171A2D),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              headerBackgroundColor: kSenseColor,
              headerForegroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedBirthDate = pickedDate;

      _birthDateController.text =
          '${pickedDate.day.toString().padLeft(2, '0')}/'
          '${pickedDate.month.toString().padLeft(2, '0')}/'
          '${pickedDate.year}';
    });
  }

  // ============================================================
  // COMPLETE PROFILE
  // ============================================================

  Future<void> _completeProfile() async {
    if (_isLoading) return;

    FocusScope.of(context).unfocus();

    if (!_isValid) {
      _showMessage(
        message: 'Please complete all fields',
        icon: Icons.info_outline_rounded,
      );
      return;
    }

    setState(() => _isLoading = true);

    // ==========================================================
    // SAVE DATA
    // ==========================================================
    final prefs = await SharedPreferences.getInstance();

    if (!widget.isEditing) {
      await prefs.remove('user_name');
      await prefs.remove('user_email');
      await prefs.remove('user_birth_date');
    }

    await prefs.setString('user_name', _nameController.text.trim());
    await prefs.setString('user_email', _emailController.text.trim());
    await prefs.setString('user_birth_date', _birthDateController.text);
    await prefs.setString('user_phone', widget.phoneNumber);

    // ==========================================================
    // TEMPORARY API SIMULATION
    // ==========================================================
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() => _isLoading = false);

    // ==========================================================
    // EDIT MODE → رجوع
    // ==========================================================
    if (widget.isEditing) {
      _showMessage(
        message: 'Profile updated successfully',
        icon: Icons.check_circle_outline_rounded,
      );

      await Future.delayed(const Duration(milliseconds: 700));

      if (!mounted) return;

      Navigator.of(context).pop();
      return;
    }

    // ==========================================================
    // GO TO HOME
    // ==========================================================
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomeScreen(userName: _nameController.text.trim());
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.03),
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
        backgroundColor: kSenseColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // HELPER: SMALL SCREEN
  // ============================================================

  bool _isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }

  bool _isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final isSmall = _isSmallScreen(context);
    final isKeyboardOpen = _isKeyboardOpen(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // 👈 أحجام responsive
    final horizontalPadding = isSmall ? 16.0 : 22.0;
    final verticalPadding = isSmall ? 16.0 : 25.0;
    final maxWidth = screenWidth < 600 ? screenWidth : 430.0;
    final topSpacing = isKeyboardOpen ? 10.0 : (isSmall ? 30.0 : 60.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F8),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ======================================================
          // BACKGROUND
          // ======================================================
          const _ProfileBackground(),

          // ======================================================
          // LOGO WATERMARK (يختفي لما الكيبورد يفتح)
          // ======================================================
          if (!isKeyboardOpen)
            Positioned(
              top: -45,
              left: -30,
              right: -30,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.055,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 320,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

          // ======================================================
          // CONTENT
          // ======================================================
          SafeArea(
            child: _isLoadingInitialData
                ? const Center(
                    child: CircularProgressIndicator(color: kSenseColor),
                  )
                : LayoutBuilder(
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: topSpacing),

                                  // ==========================================
                                  // TITLE
                                  // ==========================================
                                  Text(
                                    widget.isEditing
                                        ? 'Edit Your Profile'
                                        : 'Complete Your Profile',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: isSmall ? 24 : 29,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.7,
                                      color: const Color(0xFF171A2D),
                                    ),
                                  ),

                                  SizedBox(height: isSmall ? 20 : 27),

                                  // ==========================================
                                  // CARD
                                  // ==========================================
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                      isSmall ? 18 : 22,
                                      isSmall ? 20 : 25,
                                      isSmall ? 18 : 22,
                                      isSmall ? 18 : 23,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.88),
                                      borderRadius: BorderRadius.circular(
                                        isSmall ? 24 : 30,
                                      ),
                                      border: Border.all(
                                        color: kSenseColor.withOpacity(0.10),
                                        width: 1.2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            0.055,
                                          ),
                                          blurRadius: 35,
                                          spreadRadius: -6,
                                          offset: const Offset(0, 18),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // ==============================
                                        // SECTION TITLE
                                        // ==============================
                                        Row(
                                          children: [
                                            Container(
                                              width: isSmall ? 38 : 42,
                                              height: isSmall ? 38 : 42,
                                              decoration: BoxDecoration(
                                                color: kSenseColor.withOpacity(
                                                  0.09,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.person_outline_rounded,
                                                color: kSenseColor,
                                                size: isSmall ? 20 : 23,
                                              ),
                                            ),

                                            SizedBox(width: isSmall ? 10 : 12),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Personal details',
                                                    style: TextStyle(
                                                      fontSize: isSmall
                                                          ? 14
                                                          : 16,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: const Color(
                                                        0xFF202235,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    'Tell us a little about yourself',
                                                    style: TextStyle(
                                                      fontSize: isSmall
                                                          ? 10.5
                                                          : 11.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                        0xFF777C8D,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: isSmall ? 20 : 25),

                                        // ==============================
                                        // NAME
                                        // ==============================
                                        _buildLabel(
                                          'name',
                                          Icons.person_outline_rounded,
                                          isSmall,
                                        ),

                                        const SizedBox(height: 8),

                                        TextField(
                                          controller: _nameController,
                                          focusNode: _nameFocusNode,
                                          enabled: !_isLoading,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          textInputAction: TextInputAction.next,
                                          onChanged: (_) {
                                            setState(() {});
                                          },
                                          onSubmitted: (_) {
                                            _emailFocusNode.requestFocus();
                                          },
                                          style: _fieldTextStyle(isSmall),
                                          decoration: _fieldDecoration(
                                            hint: 'Enter your name',
                                            icon: Icons.person_outline_rounded,
                                            isSmall: isSmall,
                                          ),
                                        ),

                                        SizedBox(height: isSmall ? 16 : 19),

                                        // ==============================
                                        // DATE OF BIRTH
                                        // ==============================
                                        _buildLabel(
                                          'Date of birth',
                                          Icons.cake_outlined,
                                          isSmall,
                                        ),

                                        const SizedBox(height: 8),

                                        GestureDetector(
                                          onTap: _isLoading
                                              ? null
                                              : _selectBirthDate,
                                          child: AbsorbPointer(
                                            child: TextField(
                                              controller: _birthDateController,
                                              enabled: !_isLoading,
                                              style: _fieldTextStyle(isSmall),
                                              decoration: _fieldDecoration(
                                                hint:
                                                    'Select your date of birth',
                                                icon: Icons
                                                    .calendar_month_outlined,
                                                suffixIcon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: kSenseColor,
                                                ),
                                                isSmall: isSmall,
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: isSmall ? 16 : 19),

                                        // ==============================
                                        // EMAIL (OPTIONAL)
                                        // ==============================
                                        _buildLabel(
                                          'Email address (optional)',
                                          Icons.email_outlined,
                                          isSmall,
                                        ),

                                        const SizedBox(height: 8),

                                        TextField(
                                          controller: _emailController,
                                          focusNode: _emailFocusNode,
                                          enabled: !_isLoading,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.done,
                                          autocorrect: false,
                                          onChanged: (_) {
                                            setState(() {});
                                          },
                                          onSubmitted: (_) {
                                            if (_isValid) {
                                              _completeProfile();
                                            }
                                          },
                                          style: _fieldTextStyle(isSmall),
                                          decoration: _fieldDecoration(
                                            hint:
                                                'Enter your email address (optional)',
                                            icon: Icons.email_outlined,
                                            isSmall: isSmall,
                                          ),
                                        ),

                                        SizedBox(height: isSmall ? 20 : 25),

                                        // ==============================
                                        // CONTINUE / SAVE BUTTON
                                        // ==============================
                                        _buildContinueButton(isSmall),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: isSmall ? 14 : 18),

                                  // ==========================================
                                  // PHONE INFO
                                  // ==========================================
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.phone_rounded,
                                        size: 14,
                                        color: kSenseColor,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          widget.phoneNumber,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF6D7282),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 9),

                                  // ==========================================
                                  // SECURITY
                                  // ==========================================
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.verified_user_rounded,
                                        size: 14,
                                        color: kSenseColor.withOpacity(0.75),
                                      ),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        child: Text(
                                          'Your information is secure',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(
                                              0xFF777C8D,
                                            ).withOpacity(0.85),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: isSmall ? 14 : 20),
                                ],
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
  // LABEL
  // ============================================================

  Widget _buildLabel(String text, IconData icon, bool isSmall) {
    return Row(
      children: [
        Icon(icon, size: isSmall ? 14 : 16, color: kSenseColor),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: isSmall ? 12 : 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF35394B),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FIELD STYLE
  // ============================================================

  TextStyle _fieldTextStyle(bool isSmall) {
    return TextStyle(
      fontSize: isSmall ? 14 : 15.5,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF171A2D),
    );
  }

  // ============================================================
  // FIELD DECORATION
  // ============================================================

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData icon,
    required bool isSmall,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: isSmall ? 12.5 : 14,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.25),
      ),

      prefixIcon: Icon(
        icon,
        color: kSenseColor.withOpacity(0.75),
        size: isSmall ? 19 : 21,
      ),

      suffixIcon: suffixIcon,

      filled: true,

      fillColor: kSenseColor.withOpacity(0.025),

      contentPadding: EdgeInsets.symmetric(
        horizontal: isSmall ? 14 : 17,
        vertical: isSmall ? 14 : 17,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isSmall ? 15 : 17),
        borderSide: BorderSide(
          color: kSenseColor.withOpacity(0.12),
          width: 1.2,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isSmall ? 15 : 17),
        borderSide: BorderSide(
          color: kSenseColor.withOpacity(0.14),
          width: 1.2,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(isSmall ? 15 : 17)),
        borderSide: const BorderSide(color: kSenseColor, width: 1.7),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isSmall ? 15 : 17),
        borderSide: BorderSide(
          color: kSenseColor.withOpacity(0.08),
          width: 1.0,
        ),
      ),
    );
  }

  // ============================================================
  // CONTINUE BUTTON
  // ============================================================

  Widget _buildContinueButton(bool isSmall) {
    final buttonText = widget.isEditing ? 'Save Changes' : 'Continue';

    return SizedBox(
      width: double.infinity,
      height: isSmall ? 52 : 56,
      child: ElevatedButton(
        onPressed: _isValid && !_isLoading ? _completeProfile : null,
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
          child: _isLoading
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
                  key: const ValueKey('continue'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        buttonText,
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
                      widget.isEditing
                          ? Icons.check_rounded
                          : Icons.arrow_forward_rounded,
                      size: isSmall ? 19 : 21,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// =================================================================
// BACKGROUND
// =================================================================

class _ProfileBackground extends StatelessWidget {
  const _ProfileBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFAFD), Color(0xFFF7F3F7), Color(0xFFFFF8FC)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -130,
            right: -120,
            child: _GlowCircle(size: 350, color: const Color(0xFFF4C8DF)),
          ),
          Positioned(
            top: 280,
            left: -170,
            child: _GlowCircle(size: 330, color: const Color(0xFFF8D9E9)),
          ),
          Positioned(
            bottom: -160,
            right: -100,
            child: _GlowCircle(size: 380, color: const Color(0xFFF5D7E6)),
          ),
          Positioned(
            bottom: -130,
            left: -120,
            child: _GlowCircle(size: 300, color: const Color(0xFFF9E5F0)),
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
