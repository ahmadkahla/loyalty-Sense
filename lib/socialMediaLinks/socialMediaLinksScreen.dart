import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinks {
  // ============================================================
  // LINKS
  // ============================================================

  static const String facebook = 'https://www.facebook.com/Sense.accessoriesjo';

  static const String instagram = 'https://www.instagram.com/sense.makeupjo';

  static const String whatsapp =
      'https://api.whatsapp.com/send/?phone=962799509995&text&type=phone_number&app_absent=0';

  static const String snapchat = 'https://t.snapchat.com/JbtPjSu6';

  static const String email = 'mailto:e.senseacc@gmail.com';
  static const String Website = 'https://sense-makeupjo.com';

  // ============================================================
  // OPEN FACEBOOK
  // ============================================================

  static Future<void> openFacebook() async {
    final Uri url = Uri.parse(facebook);

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // ============================================================
  // OPEN INSTAGRAM
  // ============================================================

  static Future<void> openInstagram() async {
    final Uri url = Uri.parse(instagram);

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // ============================================================
  // OPEN WHATSAPP
  // ============================================================

  static Future<void> openWhatsApp() async {
    final Uri url = Uri.parse(whatsapp);

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // ============================================================
  // OPEN SNAPCHAT
  // ============================================================

  static Future<void> openSnapchat() async {
    final Uri url = Uri.parse(snapchat);

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // ============================================================
  // OPEN EMAIL
  // ============================================================

  static Future<void> openEmail() async {
    final Uri url = Uri.parse(email);

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  static Future<void> openWebsite() async {
    final Uri url = Uri.parse(Website);

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
