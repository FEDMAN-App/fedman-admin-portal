import 'dart:developer';

import 'package:fedman_admin_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:fedman_admin_app/core/navigation/route_name.dart';
import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common_widgets/custom_buttons.dart';
import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/file_validation_utils.dart';
import '../../country_and_its_cities/bloc/country_bloc.dart';
import '../../country_and_its_cities/data/countries_repo.dart';
import '../../country_and_its_cities/data/models/country_and_its_cities.dart';
import '../../country_and_its_cities/widgets/city_dropdown_view.dart';
import '../../country_and_its_cities/widgets/country_drop_down_view.dart';
import '../bloc/add_federation_bloc/add_federation_bloc.dart';
import '../data/enums/federation_types.dart';
import '../data/models/federation_model.dart';
import '../data/repositories/federation_repo.dart';
import '../mixins/federation_form_mixin.dart';
import '../widgets/federation_added_successfully_dialog_widget.dart';
import '../widgets/federation_type_selector.dart';
import '../widgets/file_upload_widget.dart';
import '../widgets/selected_documents_widget.dart';

class AddFederationScreen extends StatefulWidget {
  final int? federationId;

  const AddFederationScreen({super.key, this.federationId});

  @override
  State<AddFederationScreen> createState() => _AddFederationScreenState();
}

class _AddFederationScreenState extends State<AddFederationScreen>
    with FederationFormMixin {
  bool get isEditing => widget.federationId != null;

  // Track upload completion
  bool _logoUploadCompleted = false;
  bool _documentsUploadCompleted = false;
  bool _hasDocumentsToUpload = false;
  int? _createdFederationId;
late AddFederationBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc=AddFederationBloc(federationRepo: GetIt.I<FederationRepo>());
    if (isEditing) {
      _bloc.add(
        LoadFederationForEditRequested(federationId: widget.federationId!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CountryBloc(GetIt.I<CountryRepo>())),
        BlocProvider(
          create: (context) => _bloc,
        ),
      ],
      child: BlocListener<AddFederationBloc, AddFederationState>(
        listener: (context, state) {
          if (state is AddFederationLoaded) {
            _populateFormWithFederation(state.federation);
          } else if (state is AddFederationSuccess) {
            SnackbarUtils.showCustomToast(
              context,
              state.message,
              isError: false,
            );
            if (state.isUpdate) {
              context.go(RouteName.federations);
            } else {
              // Store federation ID and prepare upload tracking
              _createdFederationId = state.federation.id!;
              _hasDocumentsToUpload = selectedDocumentsNotifier.value.isNotEmpty;
              _logoUploadCompleted = false;
              _documentsUploadCompleted =
                  !_hasDocumentsToUpload; // If no documents, mark as completed

              // Upload logo and documents after successful federation creation
              _uploadFilesAfterCreation(context, state.federation.id!);
            }
          } else if (state is AddFederationError) {
            SnackbarUtils.showCustomToast(
              context,
              state.message,
              isError: true,
            );
          } else if (state is FileUploadSuccess) {


            SnackbarUtils.showCustomToast(
              context,
              state.message,
              isError: false,
            );

            // Track upload completion
            if (state.fileType == 'logo') {
              _logoUploadCompleted = true;
            } else if (state.fileType == 'documents') {
              _documentsUploadCompleted = true;
            }

            // Show dialog when all uploads are complete
            if (_logoUploadCompleted && _documentsUploadCompleted) {
              showDialog(
                context: context,
                builder: (context) => FederationAddedSuccessfullyDialogWidget(),
              );
            }
          } else if (state is FileUploadError) {
            SnackbarUtils.showCustomToast(
              context,
              state.message,
              isError: true,
            );

            // Mark failed uploads as completed to stop loading
            if (state.fileType == 'logo') {
              _logoUploadCompleted = true;
            } else if (state.fileType == 'documents') {
              _documentsUploadCompleted = true;
            }

            // Show dialog even if uploads failed (federation was created successfully)
            if (_logoUploadCompleted && _documentsUploadCompleted) {
              showDialog(
                context: context,
                builder: (context) => FederationAddedSuccessfullyDialogWidget(),
              );
            }
          }
        },
        child: ScreenBody(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: RoundedContainerWidget(
              showShadow: false,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing ? 'Edit Federation' : 'Create a new federation',
                      style: AppTextStyles.subHeading1.copyWith(),
                    ),
                    12.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Federation Name',
                          style: AppTextStyles.body1.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        CustomTextFormField(
                          controller: federationNameController,
                          hintText: 'Enter federation name',
                        ),
                        24.verticalSpace,
                        ValueListenableBuilder<String?>(
                          valueListenable: selectedTypeNotifier,
                          builder: (context, selectedType, child) {
                            return FederationTypeSelector(
                              selectedType: selectedType,
                              onTypeSelected: (type) {
                                selectedTypeNotifier.value = type;
                              },
                              onSelect: (selectedFedIds) {
                                // Update the appropriate list in BLoC based on federation type
                                final bloc = context.read<AddFederationBloc>();
                                if (selectedType == 'International' ||
                                    selectedType == 'Continental') {
                                  bloc.memberFederationIds = selectedFedIds;
                                } else if (selectedType == 'National' ||
                                    selectedType == 'Regional') {
                                  bloc.parentFederationIds = selectedFedIds;
                                }
                              },
                            );
                          },
                        ),
                        24.verticalSpace,
                        Text(
                          'Address',
                          style: AppTextStyles.body1.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child:
                                  ValueListenableBuilder<CountryAndItsCities?>(
                                    valueListenable: selectedCountryNotifier,
                                    builder: (context, selectedCountry, child) {
                                      return CountryDropdownView(
                                        hintText: 'Select country',
                                        selectedCountry: selectedCountry,
                                        onCountrySelected: (country) {
                                          selectedCountryNotifier.value =
                                              country;
                                          selectedCityNotifier.value = null;
                                          if (country != null) {
                                            context
                                                .read<CountryBloc>()
                                                .countrySelected(country);
                                          }
                                        },
                                      );
                                    },
                                  ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: ValueListenableBuilder<String?>(
                                valueListenable: selectedCityNotifier,
                                builder: (context, selectedCity, child) {
                                  return CityDropdownView(
                                    hintText: 'Select city',
                                    selectedCity: selectedCity,
                                    onCitySelected: (city) {
                                      selectedCityNotifier.value = city;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                controller: streetAddressController,
                                hintText: 'Street Address',
                              ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: CustomTextFormField(
                                controller: postCodeController,
                                hintText: 'Post code',
                              ),
                            ),
                          ],
                        ),
                        24.verticalSpace,
                        ValueListenableBuilder<bool>(
                          valueListenable: hasLogoNotifier,
                          builder: (context, hasLogo, child) {
                            return FileUploadWidget(
                              title: 'Federation Logo (required)',
                              description:
                                  'PNG, JPG up to 5MB. Recommended size: 500x500px. Drag and drop supported on web.',
                              fileName: logoFileName,
                              fileUrl: logoFileUrl,
                              isLogo: true,
                              onTap: _handleLogoUpload,
                              onDropFile: kIsWeb ? _handleLogoDrop : null,
                              onControllerCreated: kIsWeb
                                  ? (controller) =>
                                        logoDropzoneController = controller
                                  : null,
                            );
                          },
                        ),
                        24.verticalSpace,
                        FileUploadWidget(
                          title: 'Federation Documents (optional)',
                          description:
                              'Upload statutes, rules, and other federation documents (PDF). Select multiple files. Drag and drop supported on web.',
                          fileName: null, // We don't show filename in the upload widget anymore
                          isLogo: false,
                          onTap: _handleDocumentsUpload,
                          onDropFile: kIsWeb ? _handleDocumentsDrop : null,
                          onControllerCreated: kIsWeb
                              ? (controller) =>
                                    documentsDropzoneController = controller
                              : null,
                        ),
                        12.verticalSpace,
                        ValueListenableBuilder<List<DocumentFile>>(
                          valueListenable: selectedDocumentsNotifier,
                          builder: (context, documents, child) {
                            return SelectedDocumentsWidget(
                              documents: documents,
                              onRemove: _removeDocument,
                            );
                          },
                        ),
                        32.verticalSpace,
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            isSecondaryBtn: true,
                            title: 'Cancel',

                            titleColor: AppColors.baseBlackColor,
                            onTap: _handleCancel,
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: BlocBuilder<AddFederationBloc, AddFederationState>(
                            builder: (context, state) {
                              final isLoading =
                                  state is AddFederationLoading ||
                                  state is FileUploadLoading;
                              // (_createdFederationId != null && (!_logoUploadCompleted || !_documentsUploadCompleted));
                              return CustomButton(
                                title: isEditing
                                    ? 'Update Federation'
                                    : 'Create Federation',
                                isLoading: isLoading,
                                onTap: () => isLoading
                                    ? null
                                    : _handleCreateFederation(context),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogoUpload() async {
    if (kIsWeb && logoDropzoneController != null) {
      final logoFileList = await logoDropzoneController!.pickFiles(
        multiple: false,
        mime: ["image/png", "image/jpeg"],
      );
      if (logoFileList.isNotEmpty) {
        final file = logoFileList[0];
        final fileName = file.name;
        final mimeType = await logoDropzoneController!.getFileMIME(file);

        if (!FileValidationUtils.isImageFile(fileName, mimeType: mimeType)) {
          if (!mounted) return;
          SnackbarUtils.showCustomToast(
            context,
            FileValidationUtils.getInvalidFileTypeMessage(['PNG', 'JPEG']),
          );
          return;
        }

        final fileSize = await logoDropzoneController!.getFileSize(file);
        if (!FileValidationUtils.isFileSizeValid(fileSize, 5)) {
          if (!mounted) return;
          SnackbarUtils.showCustomToast(
            context,
            FileValidationUtils.getFileSizeErrorMessage(5),
          );
          return;
        }

        logoFile = file;
        logoFileName = fileName;
        logoFileUrl = await logoDropzoneController!.createFileUrl(file);
        hasLogoNotifier.value = !hasLogoNotifier.value;
      }
    } else {
      // For non-web platforms, simulate image upload
      logoFileName = 'federation_logo_bloc.png';
      hasLogoNotifier.value = !hasLogoNotifier.value;
    }
  }

  void _handleDocumentsUpload() async {
    if (kIsWeb && documentsDropzoneController != null) {
      final documentFiles = await documentsDropzoneController!.pickFiles(
        multiple: true,
        mime: ["application/pdf"],
      );
      if (documentFiles.isNotEmpty) {
        final List<DocumentFile> validDocuments = [];
        
        for (final file in documentFiles) {
          final fileName = file.name;
          final mimeType = await documentsDropzoneController!.getFileMIME(file);
          final fileSize = await documentsDropzoneController!.getFileSize(file);

          // Validate file type
          if (!FileValidationUtils.isPdfFile(fileName, mimeType: mimeType)) {
            if (!mounted) return;
            SnackbarUtils.showCustomToast(
              context,
              'Invalid file type for "$fileName". Only PDF files are allowed.',
              isError: true,
            );
            continue;
          }

          // Validate file size
          if (!FileValidationUtils.isFileSizeValid(fileSize, 10)) {
            if (!mounted) return;
            SnackbarUtils.showCustomToast(
              context,
              'File "$fileName" is too large. Maximum size is 10MB.',
              isError: true,
            );
            continue;
          }

          // Add valid document
          validDocuments.add(DocumentFile(
            name: fileName,
            file: file,
            id: DateTime.now().millisecondsSinceEpoch.toString() + fileName,
          ));
        }
        
        if (validDocuments.isNotEmpty) {
          final currentDocuments = List<DocumentFile>.from(selectedDocumentsNotifier.value);
          currentDocuments.addAll(validDocuments);
          selectedDocumentsNotifier.value = currentDocuments;
          hasDocumentsNotifier.value = currentDocuments.isNotEmpty;
        }
      }
    } else {}
  }

  Future<void> _handleLogoDrop(DropzoneFileInterface file) async {
    if (logoDropzoneController == null) return;

    final fileName = await logoDropzoneController!.getFilename(file);
    final fileSize = await logoDropzoneController!.getFileSize(file);
    final mimeType = await logoDropzoneController!.getFileMIME(file);

    if (!FileValidationUtils.isImageFile(fileName, mimeType: mimeType)) {
      if (!mounted) return;
      SnackbarUtils.showCustomToast(
        context,
        FileValidationUtils.getInvalidFileTypeMessage(['PNG', 'JPEG']),
      );
      return;
    }

    if (!FileValidationUtils.isFileSizeValid(fileSize, 5)) {
      if (!mounted) return;
      SnackbarUtils.showCustomToast(
        context,
        FileValidationUtils.getFileSizeErrorMessage(5),
      );
      return;
    }

    final fileUrl = await logoDropzoneController!.createFileUrl(file);

    logoFile = file;
    logoFileUrl = fileUrl;
    logoFileName = fileName;
    hasLogoNotifier.value = !hasLogoNotifier.value;
  }

  Future<void> _handleDocumentsDrop(DropzoneFileInterface file) async {
    if (documentsDropzoneController == null) return;

    final fileName = await documentsDropzoneController!.getFilename(file);
    final fileSize = await documentsDropzoneController!.getFileSize(file);
    final mimeType = await documentsDropzoneController!.getFileMIME(file);

    if (!FileValidationUtils.isPdfFile(fileName, mimeType: mimeType)) {
      if (!mounted) return;
      SnackbarUtils.showCustomToast(
        context,
        FileValidationUtils.getInvalidFileTypeMessage(['PDF']),
        isError: true,
      );
      return;
    }

    if (!FileValidationUtils.isFileSizeValid(fileSize, 10)) {
      if (!mounted) return;
      SnackbarUtils.showCustomToast(
        context,
        FileValidationUtils.getFileSizeErrorMessage(10),
        isError: true,
      );
      return;
    }

    // Add the dropped document to the list
    final newDocument = DocumentFile(
      name: fileName,
      file: file,
      id: DateTime.now().millisecondsSinceEpoch.toString() + fileName,
    );
    
    final currentDocuments = List<DocumentFile>.from(selectedDocumentsNotifier.value);
    currentDocuments.add(newDocument);
    selectedDocumentsNotifier.value = currentDocuments;
    hasDocumentsNotifier.value = currentDocuments.isNotEmpty;
  }

  void _removeDocument(String documentId) {
    final currentDocuments = List<DocumentFile>.from(selectedDocumentsNotifier.value);
    currentDocuments.removeWhere((doc) => doc.id == documentId);
    selectedDocumentsNotifier.value = currentDocuments;
    hasDocumentsNotifier.value = currentDocuments.isNotEmpty;
  }

  void _handleCancel() {
    context.go(RouteName.federations);
  }

  void _populateFormWithFederation(FederationModel federation) {
    federationNameController.text = federation.name;
    streetAddressController.text = federation.streetAddress;
    postCodeController.text = federation.postCode;
    selectedTypeNotifier.value = federation.type.displayName;

    // Set country if available
    if (federation.country.isNotEmpty) {
      final country = CountryAndItsCities(
        iso2: '',
        iso3: '',
        country: federation.country,
        cities: federation.city.isNotEmpty ? [federation.city] : [],
      );
      selectedCountryNotifier.value = country;
      context.read<CountryBloc>().countrySelected(country);
    }

    // Set city if available
    if (federation.city.isNotEmpty) {
      selectedCityNotifier.value = federation.city;
    }
  }

  void _handleCreateFederation(BuildContext context) {
    final federationType = selectedTypeNotifier.value != null
        ? FederationType.values.firstWhere(
            (type) => type.displayName == selectedTypeNotifier.value,
            orElse: () => FederationType.international,
          )
        : FederationType.noType;

    final federation = FederationModel(
      name: federationNameController.text.trim(),
      type: federationType,
      country: selectedCountryNotifier.value?.country ?? '',
      city: selectedCityNotifier.value ?? '',
      streetAddress: streetAddressController.text.trim(),
      postCode: postCodeController.text.trim(),
      fedLogo: logoFileUrl,
      memberFederationIdsWhenCreation: context
          .read<AddFederationBloc>()
          .memberFederationIds,
      parentFederationIdsWhenCreation: context
          .read<AddFederationBloc>()
          .parentFederationIds,
    );

    if (isEditing) {
      context.read<AddFederationBloc>().add(
        UpdateFederationRequested(
          federationId: widget.federationId!,
          federation: federation,
        ),
      );
    } else {
      context.read<AddFederationBloc>().add(
        CreateFederationRequested(federation: federation),
      );
    }
  }

  void _uploadFilesAfterCreation(BuildContext context, int federationId) async {
    // Upload logo if available
    if (logoFile != null &&
        logoFileName != null &&
        logoDropzoneController != null) {
      try {
        final logoBytes = await logoDropzoneController!.getFileData(logoFile!);
        if (context.mounted) {
          context.read<AddFederationBloc>().add(
            UploadFederationLogoRequested(
              federationId: federationId,
              logoFileBytes: logoBytes,
              fileName: logoFileName,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          SnackbarUtils.showCustomToast(
            context,
            'Failed to read logo file: $e',
            isError: true,
          );
        }
      }
    }

    // Upload documents if available
    final documents = selectedDocumentsNotifier.value;
    if (documents.isNotEmpty && documentsDropzoneController != null) {
      try {
        final List<({Uint8List bytes, String? fileName})> documentData = [];
        
        for (final document in documents) {
          final documentsBytes = await documentsDropzoneController!.getFileData(
            document.file,
          );
          documentData.add((bytes: documentsBytes, fileName: document.name));
        }
        
        if (context.mounted && documentData.isNotEmpty) {
          context.read<AddFederationBloc>().add(
            UploadMultipleFederationDocumentsRequested(
              federationId: federationId,
              documents: documentData,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          SnackbarUtils.showCustomToast(
            context,
            'Failed to read document files: $e',
            isError: true,
          );
        }
      }
    }
  }

  // dispose method is handled by the mixin
}
