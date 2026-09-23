import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinks {
  static const String facebook = 'https://www.facebook.com/Sense.accessoriesjo';

  static const String instagram = 'https://www.instagram.com/sense.makeupjo';

  static const String whatsapp =
      'https://api.whatsapp.com/send/?phone=962799509995&text&type=phone_number&app_absent=0';

  static const String snapchat = 'https://t.snapchat.com/JbtPjSu6';

  static const String email = 'mailto:e.senseacc@gmail.com';

  static const String website = 'https://sensemakeupjo.com';

  static Future<void> _openUrl(String link) async {
    try {
      final Uri url = Uri.parse(link);

      final bool canOpen = await canLaunchUrl(url);

      debugPrint('🔗 Trying to open: $url');
      debugPrint('🔗 Can launch: $canOpen');

      if (!canOpen) {
        debugPrint('❌ Cannot launch URL: $url');
        return;
      }

      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      debugPrint('🔗 Launch result: $launched');
    } catch (e) {
      debugPrint('❌ Error opening URL: $link');
      debugPrint('❌ Error: $e');
    }
  }

  static Future<void> openFacebook() async {
    await _openUrl(facebook);
  }

  static Future<void> openInstagram() async {
    await _openUrl(instagram);
  }

  static Future<void> openWhatsApp() async {
    await _openUrl(whatsapp);
  }

  static Future<void> openSnapchat() async {
    await _openUrl(snapchat);
  }

  static Future<void> openEmail() async {
    await _openUrl(email);
  }

  static Future<void> openWebsite() async {
    await _openUrl(website);
  }
}
