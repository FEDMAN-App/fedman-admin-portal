import 'package:fedman_admin_app/core/common_widgets/custom_cached_image_widget.dart';
import 'package:fedman_admin_app/core/common_widgets/option_selector.dart';
import 'package:fedman_admin_app/core/common_widgets/responsive_row_column.dart';
import 'package:fedman_admin_app/core/common_widgets/retry_widget.dart';
import 'package:fedman_admin_app/core/constants/app_constants.dart';
import 'package:fedman_admin_app/core/navigation/route_name.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:fedman_admin_app/presentation/federations/bloc/federation_details_bloc/federation_details_bloc.dart';
import 'package:fedman_admin_app/presentation/federations/bloc/federations_bloc.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/federation_model.dart';
import 'package:fedman_admin_app/presentation/federations/data/enums/federation_types.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/deactivate_federation_dialog.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/delete_federation_dialog.dart';
import 'package:fedman_admin_app/presentation/federations/widgets/federation_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common_widgets/screen_body.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/federation_details_view.dart';
import '../widgets/linked_disciplines_view.dart';
import '../widgets/federation_members_or_affiliations_view.dart';

class FederationDetailsScreen extends StatefulWidget {
  const FederationDetailsScreen({super.key, required this.id});
final int id;
  @override
  State<FederationDetailsScreen> createState() =>
      _FederationDetailsScreenState();
}

class _FederationDetailsScreenState extends State<FederationDetailsScreen> {
  final ValueNotifier<int> _selectedTabNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      child: BlocProvider(
        create: (context) => FederationDetailsBloc(GetIt.I.get())..add(GetFederationRequested(widget.id)),
        child: BlocConsumer<FederationDetailsBloc, FederationDetailsState>(
          listener: (context, state) {

          },
          builder: (context, state) {


            if(state is FederationLoading){
              return Center(heightFactor: 3,child: CircularProgressIndicator(),);
            }else if(state is GetFederationError){

                return RetryWidget();
            }else if(state is FederationLoaded){
                final federation=state.federation;
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(federation),
                      24.verticalSpace,
                      _buildTabSelector(federation),
                      24.verticalSpace,
                      ValueListenableBuilder<int>(
                        valueListenable: _selectedTabNotifier,
                        builder: (context, selectedTab, child) {
                          return _buildTabContent(selectedTab,federation);
                        },
                      ),
                    ],
                  ),
                );
              }else{

            return SizedBox();
            }

          },
        ),
      ),
    );
  }

  void _editFederation(FederationModel federation) {


    context.go('/addFederation/?id=${federation.id}',extra: {"comingFromFederationDetailsScreen":true},);
  }
  Widget _buildHeader(FederationModel federation) {
    return ResponsiveRowColumn(
      columnMainAxisAlignment: MainAxisAlignment.start,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      layout: ResponsiveLayout.mobileColumn,
      children: [
        FederationLogoWidget(size: 120,federationId: federation.id!),
        ResponsiveHelper.isMobile(context) ? 16.verticalSpace : 16
            .horizontalSpace,
        ResponsiveHelper.isMobile(context) ? _buildFedInfoView(federation) : Expanded(

            child: _buildFedInfoView(federation)
        ),
        ResponsiveHelper.isMobile(context) ? 10.verticalSpace : 0.verticalSpace,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {

                _editFederation(federation);
              },
              icon: SvgPicture.asset(
                AppAssets.editIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.infoColor,
                  BlendMode.srcIn,
                ),
              ),
            ),

            IconButton(
              onPressed: () {
                DeleteFederationDialog.show(
                  context: context,
                  federation: federation,
                  onDelete: () => context.go(RouteName.federations),
                );
              },
              icon: SvgPicture.asset(
                AppAssets.deleteIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabSelector(FederationModel federation) {
    final String thirdTabLabel = (federation.type == FederationType.international || 
                                  federation.type == FederationType.continental) 
                                 ? 'Members' 
                                 : 'Associations';
    
    return SizedBox(
      width: ResponsiveHelper.isMobile(context) ? double.maxFinite :350,
      height: 45,
      child: OptionSelector(
        optionRadius: 4,
        options: ['Details', 'Disciplines', thirdTabLabel],
        selectedIndex: _selectedTabNotifier.value,
        onOptionSelected: (index) {
          _selectedTabNotifier.value = index;
        },
      ),
    );
  }

  Widget _buildTabContent(int selectedTab,FederationModel federation) {
    switch (selectedTab) {
      case 0:
        return FederationDetailsView(federationModel: federation);
      case 1:
        return const LinkedDisciplinesView();
      case 2:
        return  FederationMembersOrAffiliationsView(federationModel: federation,);
      default:
        return FederationDetailsView(federationModel: federation);
    }
  }

  Widget getFederationTypeIcon(FederationType federationType) {
    String iconPath;
    
    switch (federationType) {
      case FederationType.international:
        iconPath = AppAssets.internationalFedTypeIcon;
        break;
      case FederationType.national:
        iconPath = AppAssets.nationalFedTypeIcon;
        break;
      case FederationType.continental:
        iconPath = AppAssets.continentalFedTypeIcon;
        break;
      case FederationType.regional:
        iconPath = AppAssets.regionalFedTypeIcon;
        break;
      case FederationType.noType:
      default:
        iconPath = AppAssets.internationalFedTypeIcon;
        break;
    }
    
    return Image.asset(
      iconPath,
      width: 20,
      height: 20,
    );
  }

  @override
  void dispose() {
    _selectedTabNotifier.dispose();
    super.dispose();
  }

  Widget _buildFedInfoView(FederationModel federation) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          federation.name,
          style: AppTextStyles.subHeading1,
        ),
        12.verticalSpace,
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20,
              color: AppColors.neutral600,
            ),
            12.horizontalSpace,
            Text(
              '${federation.city}, ${federation.country}',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.neutral600,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            getFederationTypeIcon(federation.type),
            12.horizontalSpace,
            Text(
              federation.type.displayName,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.neutral900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
