import 'dart:math' as math;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoyaltyCardColors {
  static const Color primary = Color(0xFF9C0E4F);
  static const Color primaryLight = Color(0xFFC2185B);
}

enum CardSide { front, qr, barcode }

class LoyaltyCard extends StatefulWidget {
  final int points;
  final double moneyValue;
  final String cardCode;
  final String cardLevel;
  final int nextLevelPoints;
  final bool dailyRewardClaimed;
  final bool isClaiming;
  final AnimationController rewardController;
  final Animation<double> rewardScale;
  final Animation<double> rewardRotation;
  final Animation<double> rewardOpacity;
  final VoidCallback onClaimDailyReward;

  const LoyaltyCard({
    super.key,
    required this.points,
    required this.moneyValue,
    required this.cardCode,
    required this.cardLevel,
    required this.nextLevelPoints,
    required this.dailyRewardClaimed,
    this.isClaiming = false,
    required this.rewardController,
    required this.rewardScale,
    required this.rewardRotation,
    required this.rewardOpacity,
    required this.onClaimDailyReward,
  });

  @override
  State<LoyaltyCard> createState() => _LoyaltyCardState();
}

class _LoyaltyCardState extends State<LoyaltyCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  CardSide _currentSide = CardSide.front;
  CardSide _targetSide = CardSide.front;
  CardSide _backSide = CardSide.qr;

  static const double cardHeight = 290;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _controller.addStatusListener((status) {
      if (!mounted) return;
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentSide = _targetSide;
          if (_targetSide != CardSide.front) {
            _backSide = _targetSide;
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _currentSide = CardSide.front;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _flipTo(CardSide side) async {
    if (_controller.isAnimating) return;
    if (side == _currentSide) return;

    if (_currentSide == CardSide.front) {
      _targetSide = side;
      _backSide = side;
      await _controller.forward(from: 0);
      return;
    }

    _targetSide = side;
    _backSide = side;
    await _controller.reverse(from: 1);
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 30));
    if (!mounted) return;
    _targetSide = side;
    _backSide = side;
    await _controller.forward(from: 0);
  }

  Future<void> _goToFront() async {
    if (_controller.isAnimating) return;
    if (_currentSide == CardSide.front) return;
    _targetSide = CardSide.front;
    await _controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: cardHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value = _controller.value;

          if (value <= 0.5) {
            final angle = value * math.pi;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: _buildFrontCard(),
            );
          }

          final angle = (value - 1) * math.pi;
          final Widget backChild;
          if (_backSide == CardSide.qr) {
            backChild = _buildQrCard();
          } else {
            backChild = _buildBarcodeCard();
          }

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: backChild,
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    final progress = widget.nextLevelPoints > 0
        ? math.min(widget.points / widget.nextLevelPoints, 1.0)
        : 0.0;
    final pointsToNext = math.max(widget.nextLevelPoints - widget.points, 0);

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [LoyaltyCardColors.primary, LoyaltyCardColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: LoyaltyCardColors.primary.withOpacity(0.30),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CURRENT BALANCE
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Current_Balance'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${widget.moneyValue.toStringAsFixed(1)}\$',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // POINTS
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.stars_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${widget.points} ${"Points".tr()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // LEVEL
          Row(
            children: [
              Text(
                widget.cardLevel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                '$pointsToNext ${"points to next level".tr()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // PROGRESS
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 7,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              _buildCodeButton(
                icon: Image.asset(
                  'assets/icon/icons8-qr-code-50.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
                label: 'QR Code',
                onTap: () => _flipTo(CardSide.qr),
              ),
              const SizedBox(width: 10),
              _buildCodeButton(
                icon: Image.asset(
                  'assets/icon/icons8-barcode-50.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
                label: 'Barcode',
                onTap: () => _flipTo(CardSide.barcode),
              ),
            ],
          ),
          // todo test now
          const SizedBox(height: 12),

          _buildDailyRewardButton(),
        ],
      ),
    );
  }

  Widget _buildDailyRewardButton() {
    final canClaim = !widget.dailyRewardClaimed && !widget.isClaiming;
    final showLoading = widget.isClaiming;

    return GestureDetector(
      onTap: canClaim ? widget.onClaimDailyReward : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            if (showLoading)
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: LoyaltyCardColors.primary,
                ),
              )
            else
              Icon(
                widget.dailyRewardClaimed
                    ? Icons.check_circle_rounded
                    : Icons.card_giftcard_rounded,
                color: widget.dailyRewardClaimed
                    ? Colors.grey.shade400
                    : LoyaltyCardColors.primary,
                size: 22,
              ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Reward'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: LoyaltyCardColors.primary,
                    ),
                  ),
                  Text(
                    showLoading
                        ? 'Processing...'
                        : widget.dailyRewardClaimed
                        ? 'Already claimed'
                        : '+5 Points',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            if (!showLoading)
              Icon(
                widget.dailyRewardClaimed
                    ? Icons.check_rounded
                    : Icons.arrow_forward_ios_rounded,
                size: 14,
                color: widget.dailyRewardClaimed
                    ? Colors.grey.shade400
                    : LoyaltyCardColors.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeButton({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 28, height: 28, child: icon),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: LoyaltyCardColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrCard() {
    return Container(
      width: double.infinity,
      height: cardHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [LoyaltyCardColors.primary, LoyaltyCardColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: LoyaltyCardColors.primary.withOpacity(0.30),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: _buildFlipButton(onTap: _goToFront),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: QrImageView(
                    data: widget.cardCode.isNotEmpty
                        ? widget.cardCode
                        : '0000-0000-0000-0000',
                    version: QrVersions.auto,
                    size: 180,
                    backgroundColor: Colors.white,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.cardCode.isNotEmpty ? widget.cardCode : 'No Card',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeCard() {
    final membershipNumber = widget.cardCode.isNotEmpty
        ? widget.cardCode
        : '0000-0000-0000-0000';

    return Container(
      width: double.infinity,
      height: cardHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [LoyaltyCardColors.primary, LoyaltyCardColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: LoyaltyCardColors.primary.withOpacity(0.30),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: _buildFlipButton(onTap: _goToFront),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 290,
                  height: 110,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: membershipNumber,
                    drawText: false,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    errorBuilder: (context, error) => Center(
                      child: Text(
                        'Invalid barcode',
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  membershipNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlipButton({VoidCallback? onTap}) {
    return Material(
      color: Colors.white.withOpacity(0.92),
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap ?? _goToFront,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            Icons.flip_rounded,
            size: 22,
            color: LoyaltyCardColors.primary,
          ),
        ),
      ),
    );
  }
}
