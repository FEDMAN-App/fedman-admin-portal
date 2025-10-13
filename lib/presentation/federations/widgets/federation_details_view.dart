import 'package:fedman_admin_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:fedman_admin_app/core/common_widgets/custom_buttons.dart';
import 'package:fedman_admin_app/core/utils/format_date.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:fedman_admin_app/core/utils/pdf_picker_helper.dart';
import 'package:fedman_admin_app/core/utils/responsive_helper.dart';
import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import 'package:fedman_admin_app/presentation/federations/bloc/federation_document_bloc/federation_document_bloc.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/document_model.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/federation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/src/dropzone_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/common_widgets/responsive_row_column.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';

class FederationDetailsView extends StatefulWidget {
  const FederationDetailsView({super.key, required this.federationModel});

  final FederationModel federationModel;

  @override
  State<FederationDetailsView> createState() => _FederationDetailsViewState();
}

class _FederationDetailsViewState extends State<FederationDetailsView> {
  final ValueNotifier<List<DocumentModel>> documentsNotifier = ValueNotifier(
      []);

  @override
  void initState() {
    super.initState();
    documentsNotifier.value = List.from(widget.federationModel.documents);
  }

  @override
  void dispose() {
    documentsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return ResponsiveRowColumn(
      layout: ResponsiveLayout.mobileTabletColumn,
      wrapInExpanded: true,

      rowCrossAxisAlignment: CrossAxisAlignment.start,

      children: [
        _buildFederationInformation(),
        isDesktop ? 20.horizontalSpace : 20.verticalSpace,
        _buildDocumentsSection(),
      ],
    );
  }

  Widget _buildFederationInformation() {
    return RoundedContainerWidget(
      showShadow: false,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Federation Information', style: AppTextStyles.subHeading2),
            24.verticalSpace,
            _buildInfoRow('Name', widget.federationModel.name),
            24.verticalSpace,
            _buildAddressSection(),
            24.verticalSpace,
            _buildInfoRow(
              'Status',
              widget.federationModel.status ?? 'Unknown',
              isStatus: true,
            ),
            24.verticalSpace,
            _buildInfoRow(
              'Created Date',
              formatDate(
                DateTime.tryParse(widget.federationModel.createdDate??""),
                'MMM dd, yyyy',
              )??"Unknown",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: AppColors.greyColor,
            ),
            6.horizontalSpace,
            Text(
              'Address',
              style: AppTextStyles.body2.copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        6.verticalSpace,
        Text(
          '${widget.federationModel.streetAddress}\n${widget.federationModel
              .city}, ${widget.federationModel.postCode}\n${widget
              .federationModel.country}',
          style: AppTextStyles.body1,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body2.copyWith(color: AppColors.neutral600),
        ),
        6.verticalSpace,
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.positive50Color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.positiveColor,
                    shape: BoxShape.circle,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  value,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.baseBlackColor,
                  ),
                ),
              ],
            ),
          )
        else
          Text(value, style: AppTextStyles.body1),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    return RoundedContainerWidget(
      showShadow: false,

      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Documents', style: AppTextStyles.subHeading2),
                SizedBox(
                    width: 120,
                    height: 45,
                    child: BlocProvider(
                      lazy: true,
                      create: (context) =>
                          FederationDocumentBloc(GetIt.I.get()),
                      child: BlocConsumer<
                          FederationDocumentBloc,
                          FederationDocumentState>(
                        listener: (context, state) {
                          if (state is FederationDocumentUploaded) {



                            documentsNotifier.value = state.docs;

                            SnackbarUtils.showCustomToast(
                                context, "Document uploaded successfully");
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            isLoading: state is FederationDocumentUploadLoading,
                            onTap: () async {
                              final results = await PdfPickerHelper
                                  .pickMultiplePdfsWithFilePicker(
                                  allowMultiple: false, context);
                              if(!context.mounted) return;
                              context.read<FederationDocumentBloc>().add(
                                  UploadFederationDocumentRequested(
                                      fedId: widget.federationModel.id!,
                                      fileBytes: results.first.fileBytes!,
                                      fileName: results.first.fileName));
                            },
                            title: "Upload",
                            isSecondaryBtn: true,
                            isLeadingIcon: true,
                            icon: SvgPicture.asset(
                              AppAssets.fileUploadIcon,
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                AppColors.primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),);
                        },
                      ),
                    ))
              ],
            ),
            24.verticalSpace,

            ValueListenableBuilder<List<DocumentModel>>(
              valueListenable: documentsNotifier,
              builder: (context, documents, child) {
                return documents.isNotEmpty
                    ? Column(
                  children: documents
                      .map(
                        (document) =>
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: _buildDocumentItem(
                            document.name ?? 'Unknown Document',
                            'PDF • ${document.size ??
                                'Unknown size'} • ${document.uploadedAt ??
                                'Unknown date'}',
                            document,
                          ),
                        ),
                  )
                      .toList(),
                )
                    : Text(
                  'No documents available',
                  style: AppTextStyles.body2.copyWith(
                      color: AppColors.greyColor),
                );
              },
            ),


          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem(String title,
      String details,
      DocumentModel document,) {
    return RoundedContainerWidget(
      showShadow: false,
      color: AppColors.neutral50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(AppAssets.pdfFileIcon, width: 20, height: 20),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    details,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            BlocProvider(
              create: (context) => FederationDocumentBloc(GetIt.I.get()),
              child:
              BlocConsumer<FederationDocumentBloc, FederationDocumentState>(
                listener: (context, state) {
                  if (state is FederationDocumentLoaded) {
                    _launchUrl(state.documentUrl);
                  }
                },
                builder: (context, state) {
                  if (state is FederationDocumentLoading) {
                    return SizedBox(width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 0.5));
                  } else if (state is FederationDocumentLoaded) {
                    return _buildDownloadIcon(context, document);
                  } else if (state is FederationDocumentError) {
                    return IconButton(
                      onPressed: () {},
                      icon: Icon(size: 20, Icons.refresh),
                    );
                  } else {
                    return _buildDownloadIcon(context, document);
                  }
                },
              ),
            ),
            10.horizontalSpace,
            BlocProvider(
              create: (context) => FederationDocumentBloc(GetIt.I.get()),
              child:
              BlocConsumer<FederationDocumentBloc, FederationDocumentState>(
                listener: (context, state) {
                  if (state is FederationDocumentRemoved) {
                    final updatedDocuments = List<DocumentModel>.from(
                        documentsNotifier.value);
                    updatedDocuments.removeWhere((doc) =>
                    doc.id == document.id);
                    documentsNotifier.value = updatedDocuments;
                    GetIt.I.get<LoggerService>().i(
                        "Document removed: ${document.id}");
                  }
                },
                builder: (context, state) {
                  if (state is FederationDocumentRemoveLoading) {
                    return SizedBox(width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 0.5));
                  } else if (state is FederationDocumentRemoved) {
                    return _buildDeleteIcon(context, document);
                  } else if (state is FederationDocumentRemoveError) {
                    return _buildDeleteIcon(context, document);
                  } else {
                    return _buildDeleteIcon(context, document);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadIcon(BuildContext context, DocumentModel document) {
    return IconButton(
        onPressed: () {
          context.read<FederationDocumentBloc>().add(
            GetFederationDocumentRequested(
              docId: document.id,
              fedId: widget.federationModel.id!,
            ),
          );
        },
        icon: SvgPicture.asset(
          AppAssets.downloadIcon,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            AppColors.greyColor,
            BlendMode.srcIn,
          ),
        )
    );
  }

  Widget _buildDeleteIcon(BuildContext context, DocumentModel document) {
    return IconButton(
        onPressed: () {
          context.read<FederationDocumentBloc>().add(
            DeleteFederationDocumentRequested(
              docId: document.id,
              fedId: widget.federationModel.id!,
            ),
          );
        },
        icon: Icon(Icons.delete_outline_outlined, color: AppColors.greyColor,)
    );
  }

  void _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch URL: $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
