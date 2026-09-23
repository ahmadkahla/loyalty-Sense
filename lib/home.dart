import 'dart:async';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loyalty/settings/SettingsScreen.dart';
import 'package:loyalty/slider/app_slide_model.dart';
import 'package:loyalty/socialMediaLinks/socialMediaLinksScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HomeDataRepo.dart';
import 'app_all/api_failure.dart';
import 'app_all/repo.dart';
import 'app_bar.dart';
import 'bottom_navigation.dart';
import 'branches/branch_screen.dart';
import 'loyalty/loyalty_card.dart';
import 'order/MyOrdersScreen.dart';
import 'transaction/transactionScreen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String customerNo;
  final String phoneNumber;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.customerNo,
    required this.phoneNumber,
  });

  static const Color primaryColor = Color(0xFFCC007A);
  static const Color primaryLight = Color(0xFFFF33AD);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final AuthRepo _authRepo = AuthRepo();
  final HomeDataRepo _homeDataRepo = HomeDataRepo();

  bool _isLoadingCard = true;
  String? _cardError;

  int _points = 0;
  double _pointValue = 0.01;
  String _cardCode = '';
  String _cardLevel = '';
  int _nextLevelPoints = 0;

  double get _moneyValue => _points * _pointValue;

  bool _dailyRewardClaimed = false;
  bool _isClaimingReward = false;

  late String _userName;

  List<AppSlide> _slides = [];
  bool _isLoadingSlides = true;

  final PageController _bannerPageController = PageController();
  Timer? _bannerTimer;
  int _currentBannerIndex = 0;

  late final AnimationController _rewardController;
  late final Animation<double> _rewardScale;
  late final Animation<double> _rewardRotation;
  late final Animation<double> _rewardOpacity;

  @override
  void initState() {
    super.initState();

    _userName = widget.userName;

    final customerNo = widget.customerNo.trim();
    if (customerNo.isNotEmpty) {
      try {
        final box = GetStorage();
        box.write('user_customer_no', customerNo);
        box.write('customerNo', customerNo);
        box.write('Customer_No', customerNo);
        debugPrint('💾 [Home] Saved customerNo: $customerNo');
      } catch (e) {
        debugPrint('❌ [Home] Failed to save customerNo: $e');
      }
    }

    _loadLoyaltyCardFromApi();
    _loadSliders();

    _rewardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _rewardScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.4,
          end: 1.25,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.25,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 45,
      ),
    ]).animate(_rewardController);

    _rewardRotation =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: -0.15, end: 0.15),
            weight: 25,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 0.15, end: -0.10),
            weight: 25,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: -0.10, end: 0.0),
            weight: 50,
          ),
        ]).animate(
          CurvedAnimation(parent: _rewardController, curve: Curves.easeInOut),
        );

    _rewardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rewardController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerPageController.dispose();
    _rewardController.dispose();
    super.dispose();
  }

  Future<void> _loadLoyaltyCardFromApi() async {
    if (mounted) {
      setState(() {
        _isLoadingCard = true;
        _cardError = null;
      });
    }

    final customerNo = widget.customerNo.trim();

    debugPrint('💳 [LoyaltyCard] customerNo = "$customerNo"');

    if (customerNo.isEmpty) {
      if (mounted) {
        setState(() {
          _isLoadingCard = false;
          _cardError = 'No customer ID found';
        });
      }
      return;
    }

    final result = await _authRepo.getLoyaltyCard(customerNo: customerNo);

    if (!mounted) return;

    result.fold(
      (data) {
        setState(() {
          _isLoadingCard = false;
          _cardError = null;

          final balance =
              data['Loyalty_Card_CurrentBalance'] ??
              data['Loyalty_Card_Balance'] ??
              0;

          _points = balance is num
              ? balance.toInt()
              : int.tryParse(balance.toString()) ?? 0;

          _cardCode = (data['Loyalty_Card_Code'] ?? '').toString();

          final pointVal = data['Loyalty_Level_1PointsEqualMoney'];

          _pointValue = pointVal is num
              ? pointVal.toDouble()
              : double.tryParse(pointVal.toString()) ?? 0.01;

          final minEx = data['Loyalty_Level_Minmum_Exchange'];

          _nextLevelPoints = minEx is num
              ? minEx.toInt()
              : int.tryParse(minEx.toString()) ?? 0;

          final levelDesc = data['Loyalty_Level_Desc'];

          if (levelDesc != null && levelDesc.toString().isNotEmpty) {
            _cardLevel = levelDesc.toString();
          }

          final custName = data['Customer_Name'];

          if (custName != null && custName.toString().trim().isNotEmpty) {
            _userName = custName.toString().trim();
          }

          final canClaim = data['Can_Claim_Daily_Reward'];

          _dailyRewardClaimed = canClaim is bool ? !canClaim : false;
        });
      },
      (failure) {
        setState(() {
          _isLoadingCard = false;
          _cardError = failure.toString();
        });
      },
    );
  }

  Future<void> _loadSliders() async {
    if (mounted) {
      setState(() => _isLoadingSlides = true);
    }

    final result = await _homeDataRepo.fetchSliders();

    if (!mounted) return;

    result.fold(
      (slides) {
        debugPrint('✅ عدد البانرات: ${slides.length}');

        setState(() {
          _isLoadingSlides = false;
          _slides = slides;
          _currentBannerIndex = 0;
        });

        _startBannerAutoSlide();
      },
      (failure) {
        debugPrint('❌ فشل تحميل البانرات: $failure');

        setState(() {
          _isLoadingSlides = false;
          _slides = [];
        });
      },
    );
  }

  void _startBannerAutoSlide() {
    _bannerTimer?.cancel();

    if (_slides.length <= 1) return;

    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_slides.isEmpty) return;

      final nextIndex = (_currentBannerIndex + 1) % _slides.length;

      if (_bannerPageController.hasClients) {
        _bannerPageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _onRefresh() async {
    await Future.wait([_loadLoyaltyCardFromApi(), _loadSliders()]);
  }

  // ============================================================
  // DAILY REWARD
  // ============================================================

  Future<void> _claimDailyReward() async {
    if (_isClaimingReward) return;

    final customerNo = widget.customerNo.trim();

    if (customerNo.isEmpty) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم العثور على رقم العميل')),
      );

      return;
    }

    setState(() => _isClaimingReward = true);

    final result = await _authRepo.redeemExtraPoints(
      customerNo: customerNo,
      pointsId: '3',
    );

    if (!mounted) return;

    setState(() => _isClaimingReward = false);

    result.fold(
      (success) async {
        if (!success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('I have already received it.'.tr()),
              backgroundColor: Colors.orange,
            ),
          );

          await _loadLoyaltyCardFromApi();
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 +5 Points added!'),
            backgroundColor: Color(0xFFFF0099),
          ),
        );

        await _loadLoyaltyCardFromApi();

        await _rewardController.forward(from: 0);

        if (!mounted) return;

        await Future.delayed(const Duration(milliseconds: 250));

        if (!mounted) return;

        _rewardController.reset();
      },
      (failure) {
        final msg = failure is APIFailure
            ? failure.message
            : failure.toString();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $msg'), backgroundColor: Colors.red),
        );
      },
    );
  }

  void _onBottomNavigationChanged(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _loadLoyaltyCardFromApi();
        _loadSliders();
      }
    });
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();

      case 1:
        return MyOrdersScreen(customerNo: widget.customerNo);

      case 2:
        return TransactionsScreen(customerNo: widget.customerNo);

      case 3:
        return SettingsScreen(
          userName: _userName,
          customerNo: widget.customerNo,
          phoneNumber: widget.phoneNumber,
        );
      case 4:
        return const BranchScreen();

      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: HomeScreen.primaryColor,
      backgroundColor: Theme.of(context).cardColor,
      strokeWidth: 3,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        child: Column(
          children: [
            if (_isLoadingCard)
              const SizedBox(
                height: 360,
                child: Center(
                  child: CircularProgressIndicator(
                    color: HomeScreen.primaryColor,
                  ),
                ),
              )
            else if (_cardError != null)
              SizedBox(
                height: 360,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.grey.shade400,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'تعذر تحميل البطاقة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _loadLoyaltyCardFromApi,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('إعادة المحاولة'),
                        style: TextButton.styleFrom(
                          foregroundColor: HomeScreen.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              LoyaltyCard(
                points: _points,
                moneyValue: _moneyValue,
                cardCode: _cardCode,
                cardLevel: _cardLevel,
                nextLevelPoints: _nextLevelPoints,
                dailyRewardClaimed: _dailyRewardClaimed,
                isClaiming: _isClaimingReward,
                rewardController: _rewardController,
                rewardScale: _rewardScale,
                rewardRotation: _rewardRotation,
                rewardOpacity: _rewardOpacity,
                onClaimDailyReward: _claimDailyReward,
              ),

            const SizedBox(height: 10),

            _buildSliders(),

            const SizedBox(height: 6),

            const _SocialMediaSection(),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSliders() {
    if (_isLoadingSlides) {
      return const SizedBox(
        height: 150,
        child: Center(
          child: CircularProgressIndicator(color: HomeScreen.primaryColor),
        ),
      );
    }

    if (_slides.isEmpty) {
      return const SizedBox(height: 150);
    }

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _bannerPageController,
            itemCount: _slides.length,
            onPageChanged: (index) {
              setState(() => _currentBannerIndex = index);

              _bannerTimer?.cancel();
              _startBannerAutoSlide();
            },
            itemBuilder: (context, index) {
              final slide = _slides[index];
              final Uint8List? bytes = slide.arabicImageBytes;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  onTap: slide.hasLink ? () => _openSlideLink(slide) : null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        bytes == null
                            ? Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Image.memory(
                                bytes,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                gaplessPlayback: true,
                              ),
                        if (slide.hasLink)
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.open_in_new_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        if (_slides.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slides.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentBannerIndex == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentBannerIndex == index
                      ? HomeScreen.primaryColor
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _openSlideLink(AppSlide slide) async {
    final link = slide.externalLink;

    if (link == null || link.isEmpty) return;

    try {
      final uri = Uri.parse(link);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('تعذر فتح الرابط: $link')));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في الرابط: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    String? title;
    IconData? icon;

    switch (_currentIndex) {
      case 0:
        title = null;
        icon = null;
        break;

      case 1:
        title = 'My_Orders'.tr();
        icon = Icons.shopping_bag_rounded;
        break;

      case 2:
        title = 'Transactions'.tr();
        icon = Icons.receipt_long_rounded;
        break;

      case 3:
        title = 'settings'.tr();
        icon = Icons.settings_rounded;
        break;

      case 4:
        title = 'our_branches'.tr();
        icon = Icons.location_on_rounded;
        break;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        userName: _userName,
        customerNo: widget.customerNo,
        phoneNumber: widget.phoneNumber,
        screenTitle: title,
        screenIcon: icon,
        onSettingsClosed: _loadLoyaltyCardFromApi,
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onItemSelected: _onBottomNavigationChanged,
      ),
    );
  }
}

class _SocialMediaSection extends StatefulWidget {
  const _SocialMediaSection();

  @override
  State<_SocialMediaSection> createState() => _SocialMediaSectionState();
}

class _SocialMediaSectionState extends State<_SocialMediaSection> {
  final ScrollController _scrollController = ScrollController();

  bool _showArrow = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_updateArrowVisibility);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateArrowVisibility);

    _scrollController.dispose();

    super.dispose();
  }

  void _updateArrowVisibility() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;

    final currentScroll = _scrollController.offset;

    final shouldShow = currentScroll < maxScroll - 5;

    if (shouldShow != _showArrow) {
      setState(() => _showArrow = shouldShow);
    }
  }

  void _scrollForward() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;

    final currentScroll = _scrollController.offset;

    if (currentScroll >= maxScroll - 5) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return;
    }

    final target = (currentScroll + 150).clamp(0.0, maxScroll);

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Follow_SENSE'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: HomeScreen.primaryColor,
              ),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 56,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _SocialIconButton(
                    icon: Icons.language_rounded,
                    tooltip: 'Website',
                    onTap: () async => SocialMediaLinks.openWebsite(),
                  ),
                  const SizedBox(width: 12),
                  _SocialIconButton(
                    imagePath: 'assets/icon/icons8-facebook-logo-48.png',
                    tooltip: 'Facebook',
                    onTap: () async => SocialMediaLinks.openFacebook(),
                  ),
                  const SizedBox(width: 12),
                  _SocialIconButton(
                    imagePath: 'assets/icon/icons8-instagram-48.png',
                    tooltip: 'Instagram',
                    onTap: () async => SocialMediaLinks.openInstagram(),
                  ),
                  const SizedBox(width: 12),
                  _SocialIconButton(
                    imagePath: 'assets/icon/icons8-whatsapp-logo-94.png',
                    tooltip: 'WhatsApp',
                    onTap: () async => SocialMediaLinks.openWhatsApp(),
                  ),
                  const SizedBox(width: 12),
                  _SocialIconButton(
                    imagePath: 'assets/icon/icons8-snapchat-48.png',
                    tooltip: 'Snapchat',
                    onTap: () async => SocialMediaLinks.openSnapchat(),
                  ),
                  const SizedBox(width: 12),
                  _SocialIconButton(
                    imagePath: 'assets/icon/icons8-gmail-logo-48.png',
                    tooltip: 'Email',
                    onTap: () async => SocialMediaLinks.openEmail(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIconButton({
    this.icon,
    this.imagePath,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 42,
          height: 42,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : HomeScreen.primaryColor.withOpacity(0.08),
          ),
          child: imagePath != null
              ? Image.asset(imagePath!, fit: BoxFit.contain)
              : Icon(icon, size: 24, color: HomeScreen.primaryColor),
        ),
      ),
    );
  }
}
