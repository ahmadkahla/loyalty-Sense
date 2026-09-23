import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app_all/api_failure.dart';
import '../app_all/repo.dart';
import 'home.dart';

const Color kSenseColor = Color(0xFF990056);

class CompleteProfileScreen extends StatefulWidget {
  final String phoneNumber;

  final String customerNo;

  final bool isEditing;

  final bool isNewUser;

  const CompleteProfileScreen({
    super.key,
    required this.phoneNumber,
    this.customerNo = '',
    this.isEditing = false,
    this.isNewUser = false,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final AuthRepo _authRepo = AuthRepo();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _birthDateController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  DateTime? _selectedBirthDate;

  bool _isLoading = false;
  bool _isLoadingInitialData = true;

  @override
  void initState() {
    super.initState();

    _loadExistingProfile();
  }

  Future<void> _loadExistingProfile() async {
    if (widget.isNewUser) {
      debugPrint('🆕 isNewUser=true → start with empty profile');

      if (!mounted) return;

      setState(() {
        _nameController.clear();
        _emailController.clear();
        _birthDateController.clear();
        _selectedBirthDate = null;
        _isLoadingInitialData = false;
      });

      return;
    }

    if (widget.isEditing) {
      final phone = widget.phoneNumber.trim();
      final customerNo = widget.customerNo.trim();

      if (phone.isEmpty) {
        debugPrint('🔴 [EditProfile] phoneNumber is empty');

        if (!mounted) return;

        setState(() {
          _isLoadingInitialData = false;
        });

        _showMessage(
          message: 'Failed to load your profile',
          icon: Icons.error_outline_rounded,
        );

        return;
      }

      debugPrint(
        '✏️ [EditProfile] Loading customer data by phone=$phone '
        'customerNo=$customerNo',
      );

      try {
        final result = await _authRepo.getUserByPhone(
          mobile: phone,
          countryCode: '962',
        );

        if (!mounted) return;

        result.fold(
          (data) {
            debugPrint('✅ [EditProfile] Customer API data = $data');

            final apiName =
                data['Customer_Name']?.toString() ??
                data['CustomerName']?.toString() ??
                data['Customer_Arabic_Name']?.toString() ??
                '';

            final apiEmail =
                data['Customer_Email']?.toString() ??
                data['CustomerEmail']?.toString() ??
                data['Email']?.toString() ??
                '';

            final apiBirthday =
                data['Customer_Birthday']?.toString() ??
                data['Customer_BirthDate']?.toString() ??
                data['CustomerBirthDate']?.toString() ??
                data['BirthDate']?.toString() ??
                '';

            final apiPhone =
                data['Customer_Phone1']?.toString() ??
                data['Customer_Phone']?.toString() ??
                data['Customer_Mobile']?.toString() ??
                data['CustomerPhone']?.toString() ??
                data['Mobile']?.toString() ??
                data['Phone']?.toString() ??
                phone;

            debugPrint(
              '✏️ [EditProfile] name=$apiName | '
              'email=$apiEmail | '
              'birthday=$apiBirthday | '
              'phone=$apiPhone',
            );

            final parsedDate = _parseApiDate(apiBirthday);

            setState(() {
              _nameController.text = apiName.trim().isNotEmpty
                  ? apiName.trim()
                  : '';

              _emailController.text = apiEmail.trim();

              _birthDateController.text = _formatBirthDateForDisplay(
                apiBirthday,
                parsedDate,
              );

              _selectedBirthDate = parsedDate;

              _isLoadingInitialData = false;
            });
          },
          (failure) {
            debugPrint(
              '🔴 [EditProfile] Failed to load customer profile: $failure',
            );

            if (!mounted) return;

            setState(() {
              _isLoadingInitialData = false;
            });

            _showMessage(
              message: 'Failed to load your profile',
              icon: Icons.error_outline_rounded,
            );
          },
        );
      } catch (e) {
        debugPrint('🔴 [EditProfile] Exception: $e');

        if (!mounted) return;

        setState(() {
          _isLoadingInitialData = false;
        });

        _showMessage(
          message: 'Failed to load your profile',
          icon: Icons.error_outline_rounded,
        );
      }

      return;
    }

    if (!mounted) return;

    setState(() {
      _isLoadingInitialData = false;
    });
  }

  DateTime? _parseApiDate(String date) {
    final value = date.trim();

    if (value.isEmpty) {
      return null;
    }

    try {
      final parts = value.split('/');

      if (parts.length == 3) {
        final first = int.tryParse(parts[0]);
        final second = int.tryParse(parts[1]);
        final third = int.tryParse(parts[2]);

        if (first != null && second != null && third != null) {
          if (third >= 1900) {
            return DateTime(third, second, first);
          }

          if (first >= 1900) {
            return DateTime(first, second, third);
          }
        }
      }
    } catch (_) {}

    try {
      return DateTime.tryParse(value);
    } catch (_) {
      return null;
    }
  }

  String _formatBirthDateForDisplay(String original, DateTime? parsedDate) {
    if (parsedDate == null) {
      return original.trim();
    }

    return '${parsedDate.day.toString().padLeft(2, '0')}/'
        '${parsedDate.month.toString().padLeft(2, '0')}/'
        '${parsedDate.year}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  bool get _isValid {
    final name = _nameController.text.trim();

    if (name.length < 2) {
      return false;
    }

    if (_selectedBirthDate == null) {
      return false;
    }

    if (_emailController.text.trim().isNotEmpty) {
      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

      if (!emailRegex.hasMatch(_emailController.text.trim())) {
        return false;
      }
    }

    return true;
  }

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

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedBirthDate = pickedDate;

      _birthDateController.text =
          '${pickedDate.day.toString().padLeft(2, '0')}/'
          '${pickedDate.month.toString().padLeft(2, '0')}/'
          '${pickedDate.year}';
    });
  }

  void _goBack() {
    if (_isLoading) {
      return;
    }

    FocusScope.of(context).unfocus();

    Navigator.of(context).pop();
  }

  Future<void> _completeProfile() async {
    if (_isLoading) {
      return;
    }

    FocusScope.of(context).unfocus();

    if (!_isValid) {
      _showMessage(
        message: 'Please complete all fields',
        icon: Icons.info_outline_rounded,
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (widget.isNewUser) {
      debugPrint(
        '🆕 [register] '
        'name=${_nameController.text.trim()} '
        'phone=${widget.phoneNumber}',
      );

      final result = await _authRepo.register(
        name: _nameController.text.trim(),
        mobile: widget.phoneNumber,
        countryCode: '962',
        birthdate: _selectedBirthDate,
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
      );

      if (!mounted) return;

      bool success = false;

      result.fold(
        (isSuccess) {
          debugPrint('✅ [register] success=$isSuccess');

          success = isSuccess;
        },
        (failure) {
          debugPrint('🔴 [register] failure=$failure');

          if (failure is APIFailure) {
            debugPrint('🔴 [register] message=${failure.message}');

            debugPrint('🔴 [register] statusCode=${failure.statusCode}');
          }

          success = false;
        },
      );

      if (!success) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _showMessage(
          message: 'Failed to create your profile. Please try again.',
          icon: Icons.error_outline_rounded,
        );

        return;
      }

      await Future.delayed(const Duration(milliseconds: 600));

      if (!mounted) return;

      final userResult = await _authRepo.getUserByPhone(
        mobile: widget.phoneNumber,
        countryCode: '962',
      );

      if (!mounted) return;

      await userResult.fold(
        (userData) async {
          debugPrint('✅ [getUserByPhone] userData=$userData');

          final apiName =
              userData['Customer_Name']?.toString() ??
              userData['CustomerName']?.toString() ??
              userData['Customer_Arabic_Name']?.toString() ??
              '';

          final apiCustomerNo =
              userData['Loyalty_Customer_No']?.toString() ??
              userData['Customer_No']?.toString() ??
              userData['CustomerNo']?.toString() ??
              userData['Id']?.toString() ??
              '';

          final apiEmail =
              userData['Customer_Email']?.toString() ??
              userData['CustomerEmail']?.toString() ??
              userData['Email']?.toString() ??
              '';

          final apiBirthday =
              userData['Customer_Birthday']?.toString() ??
              userData['Customer_BirthDate']?.toString() ??
              userData['CustomerBirthDate']?.toString() ??
              userData['BirthDate']?.toString() ??
              '';

          debugPrint(
            '✅ customerNo=$apiCustomerNo | '
            'name=$apiName | '
            'email=$apiEmail | '
            'birthday=$apiBirthday',
          );

          if (!mounted) return;

          setState(() {
            _isLoading = false;
          });

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 600),
              pageBuilder: (_, __, ___) => HomeScreen(
                userName: apiName.isNotEmpty
                    ? apiName
                    : _nameController.text.trim(),
                customerNo: apiCustomerNo,
                phoneNumber: widget.phoneNumber,
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
                      begin: const Offset(0, 0.03),
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
          debugPrint('🔴 [getUserByPhone] failure=$failure');

          if (!mounted) return;

          setState(() {
            _isLoading = false;
          });

          _showMessage(
            message:
                'Profile created but failed to load it. '
                'Please login again.',
            icon: Icons.warning_amber_rounded,
          );
        },
      );

      return;
    }

    if (widget.isEditing) {
      final customerNo = widget.customerNo.trim();

      if (customerNo.isEmpty) {
        debugPrint('🔴 [updateProfile] Customer_No is empty');

        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _showMessage(
          message: 'Unable to update your profile',
          icon: Icons.error_outline_rounded,
        );

        return;
      }

      final customerId = int.tryParse(customerNo);

      if (customerId == null) {
        debugPrint('🔴 [updateProfile] Invalid Customer_No=$customerNo');

        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _showMessage(
          message: 'Unable to update your profile',
          icon: Icons.error_outline_rounded,
        );

        return;
      }

      debugPrint(
        '✏️ [updateProfile] '
        'Customer_No=$customerId '
        'name=${_nameController.text.trim()} '
        'phone=${widget.phoneNumber}',
      );

      // ========================================================
      // UPDATE
      // ========================================================

      final result = await _authRepo.updateProfile(
        id: customerId,
        name: _nameController.text.trim(),
        mobile: widget.phoneNumber,
        countryCode: '962',
        birthdate: _selectedBirthDate,
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
      );

      if (!mounted) return;

      bool success = false;

      result.fold(
        (isSuccess) {
          debugPrint('✅ [updateProfile] success=$isSuccess');

          success = isSuccess;
        },
        (failure) {
          debugPrint('🔴 [updateProfile] failure=$failure');

          if (failure is APIFailure) {
            debugPrint('🔴 [updateProfile] message=${failure.message}');

            debugPrint('🔴 [updateProfile] statusCode=${failure.statusCode}');

            debugPrint('🔴 [updateProfile] rawData=${failure.rawData}');
          }

          success = false;
        },
      );

      if (!success) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _showMessage(
          message: 'Failed to update your profile. Please try again.',
          icon: Icons.error_outline_rounded,
        );

        return;
      }

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showMessage(
        message: 'Profile updated successfully',
        icon: Icons.check_circle_outline_rounded,
      );

      await Future.delayed(const Duration(milliseconds: 700));

      if (!mounted) return;

      Navigator.of(context).pop();

      return;
    }

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
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
        backgroundColor: kSenseColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool _isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }

  bool _isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSmall = _isSmallScreen(context);

    final isKeyboardOpen = _isKeyboardOpen(context);

    final screenWidth = MediaQuery.of(context).size.width;

    final horizontalPadding = isSmall ? 16.0 : 22.0;

    final verticalPadding = isSmall ? 16.0 : 25.0;

    final maxWidth = screenWidth < 600 ? screenWidth : 430.0;

    final topSpacing = isKeyboardOpen ? 10.0 : (isSmall ? 30.0 : 60.0);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF101014)
          : const Color(0xFFF8F5F8),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const _ProfileBackground(),

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

                                  if (widget.isEditing) ...[
                                    Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: _goBack,
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          child: Container(
                                            width: 46,
                                            height: 46,
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.white.withOpacity(
                                                      0.08,
                                                    )
                                                  : Colors.white.withOpacity(
                                                      0.85,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: kSenseColor.withOpacity(
                                                  0.12,
                                                ),
                                                width: 1,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.arrow_back_rounded,
                                              color: kSenseColor,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 16),
                                  ],

                                  Text(
                                    widget.isEditing
                                        ? 'Edit Your Profile'.tr()
                                        : 'Complete Your Profile'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: isSmall ? 24 : 29,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.7,
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF171A2D),
                                    ),
                                  ),

                                  SizedBox(height: isSmall ? 20 : 27),

                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                      isSmall ? 18 : 22,
                                      isSmall ? 20 : 25,
                                      isSmall ? 18 : 22,
                                      isSmall ? 18 : 23,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(
                                              0xFF1B1B22,
                                            ).withOpacity(0.96)
                                          : Colors.white.withOpacity(0.88),
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
                                                    'Personal details'.tr(),
                                                    style: TextStyle(
                                                      fontSize: isSmall
                                                          ? 14
                                                          : 16,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color:
                                                          Theme.of(
                                                                context,
                                                              ).brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : const Color(
                                                              0xFF202235,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: isSmall ? 20 : 25),

                                        _buildLabel(
                                          'Name'.tr(),
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
                                          onChanged: (_) => setState(() {}),
                                          onSubmitted: (_) =>
                                              _emailFocusNode.requestFocus(),
                                          style: _fieldTextStyle(isSmall),
                                          decoration: _fieldDecoration(
                                            hint: 'Enter your name',
                                            icon: Icons.person_outline_rounded,
                                            isSmall: isSmall,
                                          ),
                                        ),

                                        SizedBox(height: isSmall ? 16 : 19),

                                        _buildLabel(
                                          'Date of birth'.tr(),
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

                                        _buildLabel(
                                          'Email address (optional)'.tr(),
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
                                          onChanged: (_) => setState(() {}),
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

                                        _buildContinueButton(isSmall),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: isSmall ? 14 : 18),

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
                                          'Your information is secure'.tr(),
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

  Widget _buildLabel(String text, IconData icon, bool isSmall) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              color: isDark ? Colors.white : const Color(0xFF35394B),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _fieldTextStyle(bool isSmall) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextStyle(
      fontSize: isSmall ? 14 : 15.5,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : const Color(0xFF171A2D),
    );
  }

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData icon,
    required bool isSmall,
    Widget? suffixIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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

      fillColor: isDark
          ? const Color(0xFF25252D)
          : kSenseColor.withOpacity(0.025),

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

  Widget _buildContinueButton(bool isSmall) {
    final buttonText = widget.isEditing ? 'Save Changes'.tr() : 'Continue'.tr();

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

class _ProfileBackground extends StatelessWidget {
  const _ProfileBackground();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF0D0D11), Color(0xFF15151B), Color(0xFF101014)]
              : const [Color(0xFFFFFAFD), Color(0xFFF7F3F7), Color(0xFFFFF8FC)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -130,
            right: -120,
            child: _GlowCircle(
              size: 350,
              color: isDark ? const Color(0xFF990056) : const Color(0xFFF4C8DF),
            ),
          ),
          Positioned(
            top: 280,
            left: -170,
            child: _GlowCircle(
              size: 330,
              color: isDark ? const Color(0xFF6D0040) : const Color(0xFFF8D9E9),
            ),
          ),
          Positioned(
            bottom: -160,
            right: -100,
            child: _GlowCircle(
              size: 380,
              color: isDark ? const Color(0xFF520030) : const Color(0xFFF5D7E6),
            ),
          ),
          Positioned(
            bottom: -130,
            left: -120,
            child: _GlowCircle(
              size: 300,
              color: isDark ? const Color(0xFF72003F) : const Color(0xFFF9E5F0),
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
