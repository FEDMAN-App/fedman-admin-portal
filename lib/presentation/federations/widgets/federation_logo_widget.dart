import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../../core/common_widgets/custom_cached_image_widget.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/federation_logo_bloc/federation_logo_bloc.dart';
import '../data/repositories/federation_repo.dart';

class FederationLogoWidget extends StatelessWidget {
  final int federationId;
  final double size;

  const FederationLogoWidget({
    super.key,
    required this.federationId,
    this.size = 40,
  });

  Widget _buildPlaceholder() {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.bgColor,
      ),
      child: SvgPicture.asset(
        AppAssets.federationIcon,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FederationLogoBloc(federationRepo: GetIt.instance<FederationRepo>())
            ..add(GetFederationLogoRequested(federationId: federationId)),
      child: BlocBuilder<FederationLogoBloc, FederationLogoState>(
        builder: (context, state) {
          if (state is FederationLogoLoading) {
            return CircularProgressIndicator(strokeWidth: 0.5,);
          }

          if (state is FederationLogoError) {
            return _buildPlaceholder();
          }
          return Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.bgColor,
            ),
            child: ClipOval(
              child: BlocBuilder<FederationLogoBloc, FederationLogoState>(
                builder: (context, state) {
                  if (state is FederationLogoLoaded) {
                    return CustomCachedImageWidget(
                      url: state.logoUrl,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,

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
