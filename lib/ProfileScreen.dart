// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../complete_profile_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   // ============================================================
//   // DATA
//   // ============================================================
//
//   String _userName = '';
//   String _email = '';
//   String _birthDate = '';
//   String _phone = '';
//
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }
//
//   // ============================================================
//   // LOAD PROFILE
//   // ============================================================
//
//   Future<void> _loadProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     if (!mounted) return;
//
//     setState(() {
//       _userName = prefs.getString('user_name') ?? '';
//       _email = prefs.getString('user_email') ?? '';
//       _birthDate = prefs.getString('user_birth_date') ?? '';
//       _phone = prefs.getString('user_phone') ?? '';
//       _isLoading = false;
//     });
//   }
//
//   // ============================================================
//   // OPEN EDIT PROFILE
//   // ============================================================
//
//   Future<void> _openEditProfile() async {
//     await Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) =>
//             CompleteProfileScreen(phoneNumber: _phone, isEditing: true),
//       ),
//     );
//
//     // بعد الرجوع → نعيد تحميل البيانات
//     if (!mounted) return;
//     setState(() {
//       _isLoading = true;
//     });
//     _loadProfile();
//   }
//
//   // ============================================================
//   // BUILD
//   // ============================================================
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'My Profile',
//           style: TextStyle(fontWeight: FontWeight.w700),
//         ),
//       ),
//
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator(color: primaryColor))
//           : SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // ==========================================
//                   // AVATAR
//                   // ==========================================
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: primaryColor.withOpacity(0.10),
//                       border: Border.all(
//                         color: primaryColor.withOpacity(0.20),
//                         width: 2,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         _getInitials(_userName),
//                         style: const TextStyle(
//                           fontSize: 34,
//                           fontWeight: FontWeight.w800,
//                           color: primaryColor,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // ==========================================
//                   // USER NAME
//                   // ==========================================
//                   Text(
//                     _userName.isEmpty ? 'No name' : _userName,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: -0.3,
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // ==========================================
//                   // EDIT BUTTON 👈 جديد
//                   // ==========================================
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton.icon(
//                       onPressed: _openEditProfile,
//                       icon: const Icon(Icons.edit_outlined, size: 19),
//                       label: const Text(
//                         'Edit Profile',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         backgroundColor: primaryColor,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // ==========================================
//                   // DETAILS CARD
//                   // ==========================================
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: theme.cardColor,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: isDark
//                             ? Colors.white.withOpacity(0.08)
//                             : Colors.grey.shade200,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
//                           blurRadius: 15,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         // ==========================================
//                         // NAME
//                         // ==========================================
//                         _ProfileRow(
//                           icon: Icons.person_outline_rounded,
//                           label: 'Name',
//                           value: _userName.isEmpty ? 'Not set' : _userName,
//                         ),
//
//                         const SizedBox(height: 16),
//                         Divider(
//                           height: 1,
//                           color: isDark
//                               ? Colors.white.withOpacity(0.06)
//                               : Colors.grey.shade200,
//                         ),
//                         const SizedBox(height: 16),
//
//                         // ==========================================
//                         // EMAIL (يظهر فقط إذا موجود)
//                         // ==========================================
//                         if (_email.isNotEmpty) ...[
//                           _ProfileRow(
//                             icon: Icons.email_outlined,
//                             label: 'Email',
//                             value: _email,
//                           ),
//
//                           const SizedBox(height: 16),
//                           Divider(
//                             height: 1,
//                             color: isDark
//                                 ? Colors.white.withOpacity(0.06)
//                                 : Colors.grey.shade200,
//                           ),
//                           const SizedBox(height: 16),
//                         ],
//
//                         // ==========================================
//                         // BIRTH DATE
//                         // ==========================================
//                         _ProfileRow(
//                           icon: Icons.cake_outlined,
//                           label: 'Date of birth',
//                           value: _birthDate.isEmpty ? 'Not set' : _birthDate,
//                         ),
//
//                         // ==========================================
//                         // PHONE (يظهر فقط إذا موجود)
//                         // ==========================================
//                         if (_phone.isNotEmpty) ...[
//                           const SizedBox(height: 16),
//                           Divider(
//                             height: 1,
//                             color: isDark
//                                 ? Colors.white.withOpacity(0.06)
//                                 : Colors.grey.shade200,
//                           ),
//                           const SizedBox(height: 16),
//
//                           _ProfileRow(
//                             icon: Icons.phone_outlined,
//                             label: 'Phone',
//                             value: _phone,
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   // ============================================================
//   // INITIALS
//   // ============================================================
//
//   String _getInitials(String name) {
//     if (name.trim().isEmpty) return '?';
//
//     final parts = name.trim().split(' ');
//
//     if (parts.length == 1) {
//       return parts[0].substring(0, 1).toUpperCase();
//     }
//
//     return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
//   }
// }
//
// // ================================================================
// // PROFILE ROW
// // ================================================================
//
// class _ProfileRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//
//   const _ProfileRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Row(
//       children: [
//         // ICON
//         Container(
//           width: 42,
//           height: 42,
//           decoration: BoxDecoration(
//             color: primaryColor.withOpacity(0.10),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: primaryColor, size: 20),
//         ),
//
//         const SizedBox(width: 14),
//
//         // LABEL + VALUE
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 11.5,
//                   fontWeight: FontWeight.w600,
//                   color: isDark ? Colors.white54 : Colors.grey.shade500,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                   color: isDark ? Colors.white : const Color(0xFF242124),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../complete_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color primaryColor = Color(0xFFA5005A);

  // ============================================================
  // DATA
  // ============================================================

  String _userName = '';
  String _email = '';
  String _birthDate = '';
  String _phone = '';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // ============================================================
  // LOAD PROFILE
  // ============================================================

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _userName = prefs.getString('user_name') ?? '';
      _email = prefs.getString('user_email') ?? '';
      _birthDate = prefs.getString('user_birth_date') ?? '';
      _phone = prefs.getString('user_phone') ?? '';
      _isLoading = false;
    });
  }

  // ============================================================
  // OPEN EDIT PROFILE
  // ============================================================

  Future<void> _openEditProfile() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            CompleteProfileScreen(phoneNumber: _phone, isEditing: true),
      ),
    );

    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    _loadProfile();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Profile'.tr(),
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ==========================================
                  // AVATAR
                  // ==========================================
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor.withOpacity(0.10),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.20),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(_userName),
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==========================================
                  // USER NAME
                  // ==========================================
                  Text(
                    _userName.isEmpty ? 'No name' : _userName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==========================================
                  // EDIT BUTTON
                  // ==========================================
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _openEditProfile,
                      icon: const Icon(Icons.edit_outlined, size: 19),
                      label: Text(
                        'Edit Profile'.tr(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==========================================
                  // DETAILS CARD
                  // ==========================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.grey.shade200,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: _buildDetailsList(isDark),
                  ),
                ],
              ),
            ),
    );
  }

  // ============================================================
  // DETAILS LIST (ديناميكي — يعرض فقط الحقول الموجودة)
  // ============================================================

  Widget _buildDetailsList(bool isDark) {
    final List<Widget> rows = [];

    // 👤 الاسم (دايماً)
    rows.add(
      _ProfileRow(
        icon: Icons.person_outline_rounded,
        label: 'Name'.tr(),
        value: _userName.isEmpty ? 'Not set' : _userName,
      ),
    );

    // 📧 الإيميل (فقط إذا موجود)
    if (_email.isNotEmpty) {
      rows.add(
        _ProfileRow(
          icon: Icons.email_outlined,
          label: 'Email'.tr(),
          value: _email,
        ),
      );
    }

    // 🎂 تاريخ الميلاد (فقط إذا موجود)
    if (_birthDate.isNotEmpty) {
      rows.add(
        _ProfileRow(
          icon: Icons.cake_outlined,
          label: 'Date of birth'.tr(),
          value: _birthDate,
        ),
      );
    }

    // 📱 الهاتف (فقط إذا موجود)
    if (_phone.isNotEmpty) {
      rows.add(
        _ProfileRow(
          icon: Icons.phone_outlined,
          label: 'Phone'.tr(),
          value: _phone,
        ),
      );
    }

    // بناء الـ column مع Dividers
    return Column(
      children: [
        for (int i = 0; i < rows.length; i++) ...[
          if (i > 0) ...[
            const SizedBox(height: 16),
            Divider(
              height: 1,
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.grey.shade200,
            ),
            const SizedBox(height: 16),
          ],
          rows[i],
        ],
      ],
    );
  }

  // ============================================================
  // INITIALS
  // ============================================================

  String _getInitials(String name) {
    if (name.trim().isEmpty) return '?';

    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }

    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}

// ================================================================
// PROFILE ROW
// ================================================================

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        // ICON
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryColor, size: 20),
        ),

        const SizedBox(width: 14),

        // LABEL + VALUE
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white54 : Colors.grey.shade500,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
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
