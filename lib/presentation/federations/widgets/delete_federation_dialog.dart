import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import 'package:fedman_admin_app/presentation/federations/bloc/federation_details_bloc/federation_details_bloc.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/federation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';

class DeleteFederationDialog extends StatelessWidget {
  final FederationModel federationModel;

  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  const DeleteFederationDialog({
    super.key,
    required this.federationModel,
    this.onCancel,
    this.onDelete,
  });

  static Future<bool?> show({
    required BuildContext context,
    required FederationModel federation,
    final VoidCallback? onCancel,
    final VoidCallback? onDelete
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          DeleteFederationDialog(
            federationModel: federation,
            onCancel: onCancel,
            onDelete: onDelete,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            24.verticalSpace,
            _buildTitle(),
            16.verticalSpace,
            _buildDescription(),
            32.verticalSpace,
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      AppAssets.deleteIcon,
      width: 83,
      height: 83,
      colorFilter: ColorFilter.mode(
        AppColors.primaryColor,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildTitle() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Are you sure you want to delete\n"',
            style: AppTextStyles.subHeading1.copyWith(
              color: AppColors.baseBlackColor,
              height: 1.4,
            ),
          ),
          TextSpan(
            text: federationModel.name,
            style: AppTextStyles.subHeading1.copyWith(
              color: AppColors.baseBlackColor,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          TextSpan(
            text: '?"',
            style: AppTextStyles.subHeading1.copyWith(
              color: AppColors.baseBlackColor,
              height: 1.4,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Text(
      'This action is permanent and cannot be undone. All federation data, events, and associated records will be permanently removed from the system.',
      style: AppTextStyles.body1.copyWith(
        color: AppColors.neutral600,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: CustomButton(


              title: 'Cancel',
              isSecondaryBtn: true,
              onTap:() {
                context.pop();
                onCancel?.call();
              },
            ),
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: SizedBox(
            height: 48,
            child: BlocProvider(
              create: (context) => FederationDetailsBloc(GetIt.I.get()),
              child: BlocConsumer<FederationDetailsBloc, FederationDetailsState>(
                listener: (context, state) {
                 if(state is FederationDeleted){
                   context.pop();
                   SnackbarUtils.showCustomToast(context, "Federation deleted successfully");
                   onDelete?.call();
                 }
                },
                builder: (context, state) {
                  return CustomButton(
                    isLoading: state is FederationDeleting,
                    title: 'Delete',
                    onTap: () {
                      context.read<FederationDetailsBloc>().add(DeleteFederationRequested(federationModel.id!));

                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}