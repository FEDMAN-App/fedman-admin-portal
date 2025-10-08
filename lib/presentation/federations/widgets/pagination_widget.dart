import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final Function(int)? onPageSelected;
  final int visiblePageCount;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPrevious,
    this.onNext,
    this.onPageSelected,
    this.visiblePageCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 1 ? onPrevious : null,
          icon: Icon(
            Icons.chevron_left,
            color: currentPage > 1 ? AppColors.greyColor : AppColors.greyColor.withOpacity(0.5),
          ),
        ),
        8.horizontalSpace,
        Text(
          'Previous',
          style: AppTextStyles.body2.copyWith(
            color: currentPage > 1 ? AppColors.greyColor : AppColors.greyColor.withOpacity(0.5),
          ),
        ),
        24.horizontalSpace,
        ..._buildPageNumbers(),
        24.horizontalSpace,
        Text(
          'Next',
          style: AppTextStyles.body2.copyWith(
            color: currentPage < totalPages ? AppColors.greyColor : AppColors.greyColor.withOpacity(0.5),
          ),
        ),
        8.horizontalSpace,
        IconButton(
          onPressed: currentPage < totalPages ? onNext : null,
          icon: Icon(
            Icons.chevron_right,
            color: currentPage < totalPages ? AppColors.greyColor : AppColors.greyColor.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];
    
    final maxVisiblePages = visiblePageCount + 2; // +2 for first and last page
    
    if (totalPages <= maxVisiblePages) {
      for (int i = 1; i <= totalPages; i++) {
        pages.add(_buildPageButton(i));
      }
    } else {
      pages.add(_buildPageButton(1));
      
      final halfVisible = (visiblePageCount / 2).floor();
      final showLeftEllipsis = currentPage > halfVisible + 2;
      final showRightEllipsis = currentPage < totalPages - halfVisible - 1;
      
      if (showLeftEllipsis) {
        pages.add(_buildEllipsis());
      }
      
      int start = (currentPage - halfVisible).clamp(2, totalPages - visiblePageCount);
      int end = (currentPage + halfVisible).clamp(visiblePageCount + 1, totalPages - 1);
      
      for (int i = start; i <= end; i++) {
        pages.add(_buildPageButton(i));
      }
      
      if (showRightEllipsis) {
        pages.add(_buildEllipsis());
      }
      
      if (totalPages > 1) {
        pages.add(_buildPageButton(totalPages));
      }
    }
    
    return pages;
  }

  Widget _buildPageButton(int pageNumber) {
    final isSelected = pageNumber == currentPage;
    
    return GestureDetector(
      onTap: () => onPageSelected?.call(pageNumber),
      child: Container(
        width: 32,
        height: 32,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          shape: BoxShape.circle,
          border: !isSelected ? Border.all(color: AppColors.greyColor.withOpacity(0.3)) : null,
        ),
        child: Center(
          child: Text(
            pageNumber.toString(),
            style: AppTextStyles.body2.copyWith(
              color: isSelected ? AppColors.baseWhiteColor : AppColors.greyColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Container(
      width: 32,
      height: 32,
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: Text(
          '...',
          style: AppTextStyles.body2.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ),
    );
  }
}