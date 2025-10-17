import 'package:fedman_admin_app/core/constants/app_colors.dart';
import 'package:fedman_admin_app/core/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:fedman_admin_app/core/extensions/space.dart';
import 'package:fedman_admin_app/core/theme/app_text_styles.dart';

import '../../data/models/discipline_model.dart';
import 'discipline_image_widget.dart';
import 'discipline_context_menu.dart';



class DisciplineCard extends StatelessWidget {
  final DisciplineModel discipline;
  final VoidCallback? onTap;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DisciplineCard({
    super.key,
    required this.discipline,
    this.onTap,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisciplineImageWidget(
                    disciplineId: discipline.id!,
                    width: 90,
                    height: 70,
                    borderRadius: 8,
                    fit: BoxFit.cover,
                  ),
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () => _showContextMenu(context),
                        icon: const Icon(Icons.more_horiz),
                        color: Colors.grey[600],
                      );
                    }
                  ),
                ],
              ),
              16.verticalSpace,
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: discipline.hasRanking
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      discipline.hasRanking ? 'Ranking enabled' : 'Ranking disabled',
                      style: AppTextStyles.line.copyWith(
                        color: discipline.hasRanking
                            ? Colors.green[700]
                            : Colors.orange[700],
                        fontSize: 12,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${discipline.levels.length} Levels',
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.blue[700],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              Text(
                discipline.name,
                style: AppTextStyles.subHeading1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              4.verticalSpace,
              Text(
                'Created: ${formatDate(discipline.createdAt,'MMM dd, yyyy' )}',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    
    // Get button position relative to overlay
    final Offset buttonPosition = button.localToGlobal(Offset.zero, ancestor: overlay);
    final Size buttonSize = button.size;
    
    // Position menu to the bottom right of the more icon
    final RelativeRect position = RelativeRect.fromLTRB(
      buttonPosition.dx + buttonSize.width - 120, // Right-align menu starting from button's right edge
      buttonPosition.dy + buttonSize.height + 4,   // Position below button with small gap
      buttonPosition.dx,                           // Right boundary
      buttonPosition.dy,                           // Bottom boundary
    );

    DisciplineContextMenu.show(
      context: context,
      position: position,
      onView: onView,
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}