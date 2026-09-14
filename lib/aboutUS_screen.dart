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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 👈 خلفية الشاشة حسب الثيم (Light/Dark)
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // 👈 AppBar مع زر رجوع تلقائي
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : primaryColor,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'about_us'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0xFF242124),
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ==================================================
            // LOGO
            // ==================================================
            Image.asset(
              'assets/7767de42-0a90-4833-add1-bc5a2a20b6f2.png',
              width: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 24),

            // ==================================================
            // TITLE
            // ==================================================
            Text(
              'about_us'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // DESCRIPTION
            // ==================================================
            Text(
              'about_us_description'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
