// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// import 'notification_cell.dart';
// import 'notification_controller.dart';
//
// class NotificationsScreen extends StatefulWidget {
//   static const String routeName = '/notifications';
//
//   const NotificationsScreen({super.key});
//
//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }
//
// class _NotificationsScreenState extends State<NotificationsScreen> {
//   late final NotificationsController controller;
//   final RefreshController _refreshController = RefreshController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller = NotificationsController();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.loadNotifications();
//     });
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     _refreshController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<NotificationsController>.value(
//       value: controller,
//       child: Consumer<NotificationsController>(
//         builder: (context, controller, child) {
//           return Scaffold(
//             backgroundColor: const Color(0xFFF8F8F8),
//             appBar: AppBar(
//               title: Text('notifications'.tr()),
//               centerTitle: true,
//               // automaticallyImplyLeading: false,
//             ),
//             body: Column(
//               children: [
//                 // ============================================
//                 // FILTER SEGMENT
//                 // ============================================
//                 _buildFilterSegment(context, controller),
//
//                 // ============================================
//                 // LIST
//                 // ============================================
//                 Expanded(child: _buildBody(context, controller)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ============================================================
//   // FILTER SEGMENT
//   // ============================================================
//   Widget _buildFilterSegment(
//     BuildContext context,
//     NotificationsController controller,
//   ) {
//     final primaryColor = Theme.of(context).colorScheme.primary;
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           _buildFilterButton(
//             label: 'new'.tr(),
//             isSelected: controller.filter == NotificationFilter.unread,
//             onTap: () => controller.setFilter(NotificationFilter.unread),
//             primaryColor: primaryColor,
//           ),
//           _buildFilterButton(
//             label: 'old'.tr(),
//             isSelected: controller.filter == NotificationFilter.read,
//             onTap: () => controller.setFilter(NotificationFilter.read),
//             primaryColor: primaryColor,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFilterButton({
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//     required Color primaryColor,
//   }) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.05),
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     ),
//                   ]
//                 : null,
//           ),
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//               fontSize: 15,
//               color: isSelected ? primaryColor : Colors.grey.shade600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // BODY
//   // ============================================================
//   Widget _buildBody(BuildContext context, NotificationsController controller) {
//     // Loading
//     if (controller.isLoading && controller.notifications.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     // Error
//     if (controller.error != null && controller.notifications.isEmpty) {
//       return _buildError(context, controller);
//     }
//
//     // Empty
//     if (controller.notifications.isEmpty) {
//       return _buildEmpty();
//     }
//
//     // List
//     return SmartRefresher(
//       controller: _refreshController,
//       enablePullDown: true,
//       enablePullUp: controller.hasMore,
//       onRefresh: () async {
//         await controller.refresh();
//         _refreshController.refreshCompleted();
//       },
//       onLoading: () async {
//         await controller.loadMore();
//         _refreshController.loadComplete();
//       },
//       child: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: controller.notifications.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 8),
//         itemBuilder: (context, index) {
//           final notification = controller.notifications[index];
//           return NotificationCell(
//             notification: notification,
//             onTap: () {
//               controller.markAsRead(notification);
//               // TODO: عرض Dialog التفاصيل (الخطوة القادمة)
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   // ============================================================
//   // ERROR
//   // ============================================================
//   Widget _buildError(BuildContext context, NotificationsController controller) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline_rounded,
//               size: 60,
//               color: Theme.of(context).colorScheme.error,
//             ),
//             const SizedBox(height: 16),
//             Text(controller.error ?? 'Error', textAlign: TextAlign.center),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => controller.loadNotifications(),
//               child: Text('try_again'.tr()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // EMPTY
//   // ============================================================
//   Widget _buildEmpty() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.notifications_off_outlined,
//             size: 80,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No notifications'.tr(),
//             style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'notification_cell.dart';
import 'notification_controller.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = '/notifications';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationsController controller;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    controller = NotificationsController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadNotifications();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ChangeNotifierProvider<NotificationsController>.value(
      value: controller,
      child: Consumer<NotificationsController>(
        builder: (context, controller, child) {
          return Scaffold(
            // 👈 استخدام background من الثيم
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text('notifications'.tr()),
              centerTitle: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: isDark ? Colors.white : Colors.black87,
              ),
              titleTextStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            body: Column(
              children: [
                // ============================================
                // FILTER SEGMENT
                // ============================================
                _buildFilterSegment(context, controller, isDark),

                // ============================================
                // LIST
                // ============================================
                Expanded(child: _buildBody(context, controller, isDark)),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // FILTER SEGMENT
  // ============================================================
  Widget _buildFilterSegment(
    BuildContext context,
    NotificationsController controller,
    bool isDark,
  ) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        // 👈 الخلفية الرمادية تتبع الـ theme
        color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildFilterButton(
            label: 'new'.tr(),
            isSelected: controller.filter == NotificationFilter.unread,
            onTap: () => controller.setFilter(NotificationFilter.unread),
            primaryColor: primaryColor,
            isDark: isDark,
          ),
          _buildFilterButton(
            label: 'old'.tr(),
            isSelected: controller.filter == NotificationFilter.read,
            onTap: () => controller.setFilter(NotificationFilter.read),
            primaryColor: primaryColor,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color primaryColor,
    required bool isDark,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            // 👈 الزر المختار: أبيض في الفاتح، رمادي فاتح في الداكن
            color: isSelected
                ? (isDark ? const Color(0xFF2A2A3A) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.30 : 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 15,
              // 👈 النص المختار: اللون الأساسي
              // النص غير المختار: رمادي (يفرق بين الفاتح والداكن)
              color: isSelected
                  ? primaryColor
                  : (isDark ? Colors.white60 : Colors.grey.shade600),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BODY
  // ============================================================
  Widget _buildBody(
    BuildContext context,
    NotificationsController controller,
    bool isDark,
  ) {
    // Loading
    if (controller.isLoading && controller.notifications.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error
    if (controller.error != null && controller.notifications.isEmpty) {
      return _buildError(context, controller);
    }

    // Empty
    if (controller.notifications.isEmpty) {
      return _buildEmpty(isDark);
    }

    // List
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: controller.hasMore,
      onRefresh: () async {
        await controller.refresh();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        await controller.loadMore();
        _refreshController.loadComplete();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: controller.notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final notification = controller.notifications[index];
          return NotificationCell(
            notification: notification,
            onTap: () {
              controller.markAsRead(notification);
              // TODO: عرض Dialog التفاصيل (الخطوة القادمة)
            },
          );
        },
      ),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================
  Widget _buildError(BuildContext context, NotificationsController controller) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              controller.error ?? 'Error',
              textAlign: TextAlign.center,
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.loadNotifications(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: Text('try_again'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY
  // ============================================================
  Widget _buildEmpty(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            // 👈 الأيقونة تتبع الثيم
            color: isDark ? Colors.white24 : Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications'.tr(),
            style: TextStyle(
              fontSize: 16,
              // 👈 النص يتبع الثيم
              color: isDark ? Colors.white60 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
