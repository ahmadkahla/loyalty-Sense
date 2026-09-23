import 'package:flutter/material.dart';

import 'loyalty_transaction.dart';

class TransactionCell extends StatelessWidget {
  final LoyaltyTransaction transaction;

  const TransactionCell({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isIncoming = transaction.transType == TransactionType.incoming;

    final Color color = isIncoming
        ? (isDark ? const Color(0xFF66BB6A) : Colors.green)
        : (isDark ? const Color(0xFFEF6C6C) : Colors.red);

    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.grey.shade200;

    final title = transaction.loyaltyTransDesc?.isNotEmpty == true
        ? transaction.loyaltyTransDesc!
        : (transaction.transTypeDesc?.isNotEmpty == true
              ? transaction.transTypeDesc!
              : (isIncoming ? 'Purchase' : 'Redeemed'));

    final pointsText = isIncoming
        ? '+${transaction.point}'
        : '${transaction.point}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.16 : 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncoming
                  ? Icons.add_circle_outline
                  : Icons.remove_circle_outline,
              color: color,
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  _formatDate(transaction.transDate),
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          Text(
            pointsText,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }
}
