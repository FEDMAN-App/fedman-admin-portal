import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/common_widgets/custom_cached_image_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../blocs/discipline_image_bloc/discipline_image_bloc.dart';
import '../../data/repositories/discipline_repo.dart';
import 'default_discipline_image_widget.dart';

class DisciplineImageWidget extends StatelessWidget {
  final int disciplineId;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;

  const DisciplineImageWidget({
    super.key,
    required this.disciplineId,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.fit = BoxFit.cover,
  });

  Widget _buildPlaceholder() {
    return DefaultDisciplineImageWidget(
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DisciplineImageBloc(disciplineRepo: GetIt.instance<DisciplineRepo>())
            ..add(GetDisciplineImageRequested(disciplineId: disciplineId)),
      child: BlocBuilder<DisciplineImageBloc, DisciplineImageState>(
        builder: (context, state) {
          if (state is DisciplineImageLoading) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.neutral100,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: AppColors.neutral200,
                  width: 1,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            );
          }

          if (state is DisciplineImageError) {
            return _buildPlaceholder();
          }

          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: AppColors.neutral200,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: BlocBuilder<DisciplineImageBloc, DisciplineImageState>(
                builder: (context, state) {
                  if (state is DisciplineImageLoaded) {
                    if (state.imageUrl.isEmpty) {
                      return _buildPlaceholder();
                    }
                    return CustomCachedImageWidget(
                      url: state.imageUrl,
                      // width: width,
                      // height: height,
                      fit: fit,
                      errorWidget: _buildPlaceholder(),
                    );
                  }
                  return _buildPlaceholder();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}