import 'package:flutter/material.dart';
import 'package:fedman_admin_app/core/extensions/space.dart';
import 'package:fedman_admin_app/core/theme/app_text_styles.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';

import '../mixins/federation_form_mixin.dart';

class SelectedDocumentsWidget extends StatelessWidget {
  final List<DocumentFile> documents;
  final Function(String documentId) onRemove;

  const SelectedDocumentsWidget({
    super.key,
    required this.documents,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Documents (${documents.length})',
          style: AppTextStyles.body1.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        8.verticalSpace,
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: documents.length,
            separatorBuilder: (context, index) => 12.horizontalSpace,
            itemBuilder: (context, index) {
              final document = documents[index];
              return DocumentItemWidget(
                document: document,
                onRemove: () => onRemove(document.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DocumentItemWidget extends StatelessWidget {
  final DocumentFile document;
  final VoidCallback onRemove;

  const DocumentItemWidget({
    super.key,
    required this.document,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.neutral200,
        ),
      ),
      child: Stack(
        children: [
          // Main content based on your file preview design
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description_outlined,
                  color: AppColors.positiveColor,
                  size: 24,
                ),
                8.verticalSpace,
                Flexible(
                  child: Text(
                    document.name,
                    style: AppTextStyles.body2.copyWith(


                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),


              ],
            ),
          ),
          // Remove button positioned at top right
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.negativeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: AppColors.baseWhiteColor,
                  size: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}