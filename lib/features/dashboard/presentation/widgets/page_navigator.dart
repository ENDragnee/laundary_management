import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {
  final int currentPage;
  final int totalCount;
  final int pageSize;
  final Function(int) onPageChanged;

  const PageNavigator({
    super.key,
    required this.currentPage,
    required this.totalCount,
    required this.pageSize,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final int totalPages = (totalCount / pageSize).ceil();
    final bool hasNext = currentPage < totalPages;
    final bool hasPrev = currentPage > 1;
    final theme = Theme.of(context);

    if (totalCount == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          IconButton.filledTonal(
            onPressed: hasPrev ? () => onPageChanged(currentPage - 1) : null,
            icon: const Icon(Icons.chevron_left),
          ),

          // Page Info
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Page $currentPage of ${totalPages == 0 ? 1 : totalPages}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total: $totalCount items',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),

          // Next Button
          IconButton.filledTonal(
            onPressed: hasNext ? () => onPageChanged(currentPage + 1) : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
