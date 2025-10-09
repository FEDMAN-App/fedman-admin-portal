import 'package:easy_localization/easy_localization.dart';
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
import '../../../core/common_widgets/screen_body.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/space.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../country_and_its_cities/bloc/country_bloc.dart';
import '../../country_and_its_cities/data/countries_repo.dart';
import '../../country_and_its_cities/data/models/country_and_its_cities.dart';
import '../../country_and_its_cities/widgets/city_dropdown_view.dart';
import '../../country_and_its_cities/widgets/country_drop_down_view.dart';
import '../bloc/add_federation_bloc/add_federation_bloc.dart';
import '../data/enums/federation_types.dart';
import '../data/models/federation_model.dart';
import '../data/repositories/federation_repo.dart';
import '../widgets/federation_added_successfully_dialog_widget.dart';
import '../widgets/federation_type_selector.dart';
import '../widgets/file_upload_widget.dart';

class AddFederationScreen extends StatefulWidget {
  final int? federationId;
  const AddFederationScreen({super.key, this.federationId});

  @override
  State<AddFederationScreen> createState() => _AddFederationScreenState();
}

class _AddFederationScreenState extends State<AddFederationScreen> {
  final TextEditingController _federationNameController = TextEditingController();
  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  
  final ValueNotifier<String?> _selectedTypeNotifier = ValueNotifier(null);
  final ValueNotifier<CountryAndItsCities?> _selectedCountryNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _selectedCityNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _hasLogoNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _hasDocumentsNotifier = ValueNotifier(false);
  
  bool get isEditing => widget.federationId != null;
  
  String? _logoFileName;
  String? _documentsFileName;
  DropzoneFileInterface? _logoFile;
  DropzoneFileInterface? _documentsFile;
  String? _logoFileUrl;
  String? _documentsFileUrl;
  
  DropzoneViewController? _logoDropzoneController;
  DropzoneViewController? _documentsDropzoneController;


  @override
  void initState() {
    super.initState();
    if (isEditing) {
      context.read<AddFederationBloc>().add(
        LoadFederationForEditRequested(federationId: widget.federationId!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountryBloc(GetIt.I<CountryRepo>()),
        ),
        BlocProvider(
          create: (context) => AddFederationBloc(
            federationRepo: GetIt.I<FederationRepo>(),
          ),
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
              showDialog(
                context: context,
                builder: (context) => FederationAddedSuccessfullyDialogWidget(),
              );
            }
          } else if (state is AddFederationError) {
            SnackbarUtils.showCustomToast(
              context,
              state.message,
              isError: true,
            );
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
                  style: AppTextStyles.subHeading1.copyWith(
                  ),
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
                      controller: _federationNameController,
                      hintText: 'Enter federation name',
                    ),
                    24.verticalSpace,
                    ValueListenableBuilder<String?>(
                      valueListenable: _selectedTypeNotifier,
                      builder: (context, selectedType, child) {
                        return FederationTypeSelector(
                          selectedType: selectedType,
                          onTypeSelected: (type) {
                            _selectedTypeNotifier.value = type;
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
                          child: ValueListenableBuilder<CountryAndItsCities?>(
                            valueListenable: _selectedCountryNotifier,
                            builder: (context, selectedCountry, child) {
                              return CountryDropdownView(
                                hintText: 'Select country',
                                selectedCountry: selectedCountry,
                                onCountrySelected: (country) {
                                  _selectedCountryNotifier.value = country;
                                  _selectedCityNotifier.value = null;
                                  if (country != null) {
                                    context.read<CountryBloc>().countrySelected(country);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: ValueListenableBuilder<String?>(
                            valueListenable: _selectedCityNotifier,
                            builder: (context, selectedCity, child) {
                              return CityDropdownView(


                                hintText: 'Select city',
                                selectedCity: selectedCity,
                                onCitySelected: (city) {
                                  _selectedCityNotifier.value = city;
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
                            controller: _streetAddressController,
                            hintText: 'Street Address',
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: CustomTextFormField(
                            controller: _postCodeController,
                            hintText: 'Post code',
                          ),
                        ),
                      ],
                    ),
                    24.verticalSpace,
                    ValueListenableBuilder<bool>(
                      valueListenable: _hasLogoNotifier,
                      builder: (context, hasLogo, child) {
                        return FileUploadWidget(
                          title: 'Federation Logo',
                          description: 'PNG, JPG up to 5MB. Recommended size: 500x500px. Drag and drop supported on web.',
                          fileName: _logoFileName,
                          fileUrl: _logoFileUrl,
                          isLogo: true,
                          onTap: _handleLogoUpload,
                          onDropFile: kIsWeb ? _handleLogoDrop : null,
                          onControllerCreated: kIsWeb ? (controller) => _logoDropzoneController = controller : null,
                        );
                      },
                    ),
                    24.verticalSpace,
                    ValueListenableBuilder<bool>(
                      valueListenable: _hasDocumentsNotifier,
                      builder: (context, hasDocuments, child) {
                        return FileUploadWidget(
                          title: 'Federation Documents',
                          description: 'Upload statutes, rules, and other federation documents (PDF). Drag and drop supported on web.',
                          fileName: _documentsFileName,
                          isLogo: false,
                          onTap: _handleDocumentsUpload,
                          onDropFile: kIsWeb ? _handleDocumentsDrop : null,
                          onControllerCreated: kIsWeb ? (controller) => _documentsDropzoneController = controller : null,
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
                          final isLoading = state is AddFederationLoading;
                          return CustomButton(
                            title: isEditing ? 'Update Federation' : 'Create Federation',
                            isLoading: isLoading,
                            onTap: isLoading ? null : _handleCreateFederation,
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
    if (kIsWeb && _logoDropzoneController != null)  {
      final logoFile = await _logoDropzoneController!.pickFiles(multiple: false, mime: ["image/png", "image/jpeg"]);
      if(logoFile.isNotEmpty){
        final file = logoFile[0];
        final fileName = file.name;
        final mimeType = await _logoDropzoneController!.getFileMIME(file);
        
        if (!_isImageFile(fileName, mimeType: mimeType)) {
          if(!mounted) return;
          SnackbarUtils.showCustomToast(context, "Please upload only PNG or JPEG files for logo.");
          return;
        }
        
        final fileSize = await _logoDropzoneController!.getFileSize(file);
        if (fileSize > 5 * 1024 * 1024) {
          if(!mounted) return;
          SnackbarUtils.showCustomToast(context, "Max file size is 5MB, Please upload logo with less than or equal to 5MB");
          return;
        }
        
        _logoFile = file;
        _logoFileName = fileName;
        _logoFileUrl = await _logoDropzoneController!.createFileUrl(file);
        _hasLogoNotifier.value = !_hasLogoNotifier.value;
      }
    } else {
      // For non-web platforms, simulate image upload
      _logoFileName = 'federation_logo.png';
      _hasLogoNotifier.value = !_hasLogoNotifier.value;
    }
  }

  void _handleDocumentsUpload() async {
    if (kIsWeb && _documentsDropzoneController != null) {
      final documentFiles = await _documentsDropzoneController!.pickFiles(multiple: true,mime: ["application/pdf"]);
      if (documentFiles.isNotEmpty) {
        final file = documentFiles[0];
        final fileName = file.name;
        final mimeType = await _documentsDropzoneController!.getFileMIME(file);
        
        if (!_isPdfFile(fileName, mimeType: mimeType)) {
          if(!mounted) return;
          SnackbarUtils.showCustomToast(context, "Please upload only PDF files for documents.");
          return;
        }
        
        final fileSize = await _documentsDropzoneController!.getFileSize(file);
        if (fileSize > 10 * 1024 * 1024) {
          if(!mounted) return;
          SnackbarUtils.showCustomToast(context, "Max file size is 10MB, Please upload document with less than or equal to 10MB");
          return;
        }
        
        _documentsFile = file;
        _documentsFileName = fileName;
        _hasDocumentsNotifier.value = !_hasDocumentsNotifier.value;
      }
    } else {

    }
  }

  Future<void> _handleLogoDrop(DropzoneFileInterface file) async {
    if (_logoDropzoneController == null) return;
    
    final fileName = await _logoDropzoneController!.getFilename(file);
    final fileSize = await _logoDropzoneController!.getFileSize(file);
    final mimeType = await _logoDropzoneController!.getFileMIME(file);
    
    if (!_isImageFile(fileName, mimeType: mimeType)) {
      if(!mounted) return;
      SnackbarUtils.showCustomToast(context, "Please upload only PNG or JPEG files for logo.");
      return;
    }
    
    if (fileSize > 5 * 1024 * 1024) {
      if(!mounted) return;
      SnackbarUtils.showCustomToast(context, "Max file size is 5MB, Please upload logo with less than or equal to 5MB");
      return;
    }
    
    final fileUrl = await _logoDropzoneController!.createFileUrl(file);
    
    _logoFile = file;
    _logoFileUrl = fileUrl;
    _logoFileName = fileName;
    _hasLogoNotifier.value = !_hasLogoNotifier.value;
  }

  Future<void> _handleDocumentsDrop(DropzoneFileInterface file) async {
    if (_documentsDropzoneController == null) return;
    
    final fileName = await _documentsDropzoneController!.getFilename(file);
    final fileSize = await _documentsDropzoneController!.getFileSize(file);
    final mimeType = await _documentsDropzoneController!.getFileMIME(file);
    
    if (!_isPdfFile(fileName, mimeType: mimeType)) {
      if(!mounted) return;
      SnackbarUtils.showCustomToast(context, "Please upload only PDF files for documents. File appears to be renamed or corrupted.");
      return;
    }
    
    if (fileSize > 10 * 1024 * 1024) {
      if(!mounted) return;
      SnackbarUtils.showCustomToast(context, "Max file size is 10MB, Please upload document with less than or equal to 10MB");
      return;
    }
    
   // setState(() {
      _documentsFile = file;
      _documentsFileName = fileName;
      _hasDocumentsNotifier.value = !_hasDocumentsNotifier.value;
    ///});
  }

  bool _isPdfFile(String fileName, {String? mimeType}) {
    final hasValidExtension = fileName.toLowerCase().endsWith('.pdf');
    
    // Check MIME type if available (for web uploads)
    if (mimeType != null) {
      final hasValidMimeType = mimeType.toLowerCase() == 'application/pdf';
      return hasValidExtension && hasValidMimeType;
    }
    
    // For non-web platforms, rely on extension only
    return hasValidExtension;
  }

  bool _isImageFile(String fileName, {String? mimeType}) {
    final lowerFileName = fileName.toLowerCase();
    final hasValidExtension = lowerFileName.endsWith('.jpg') || 
                             lowerFileName.endsWith('.jpeg') || 
                             lowerFileName.endsWith('.png');
    
    // Check MIME type if available (for web uploads)
    if (mimeType != null) {
      final lowerMimeType = mimeType.toLowerCase();
      final hasValidMimeType = lowerMimeType == 'image/jpeg' || 
                              lowerMimeType == 'image/jpg' || 
                              lowerMimeType == 'image/png';
      return hasValidExtension && hasValidMimeType;
    }
    
    // For non-web platforms, rely on extension only
    return hasValidExtension;
  }

  void _handleCancel() {
    context.go(RouteName.federations);

  }

  void _populateFormWithFederation(FederationModel federation) {
    _federationNameController.text = federation.name ?? '';
    _streetAddressController.text = federation.streetAddress ?? '';
    _postCodeController.text = federation.postCode ?? '';
    _selectedTypeNotifier.value = federation.type?.displayName;
    
    // Set country if available
    if (federation.country != null) {
      final country = CountryAndItsCities(
        iso2: '',
        iso3: '',
        country: federation.country!,
        cities: federation.city != null ? [federation.city!] : [],
      );
      _selectedCountryNotifier.value = country;
      context.read<CountryBloc>().countrySelected(country);
    }
    
    // Set city if available
    if (federation.city != null) {
      _selectedCityNotifier.value = federation.city;
    }
  }

  void _handleCreateFederation() {
    if (_federationNameController.text.trim().isEmpty) {
      SnackbarUtils.showCustomToast(
        context,
        'Please enter federation name',
        isError: true,
      );
      return;
    }

    if (_selectedTypeNotifier.value == null) {
      SnackbarUtils.showCustomToast(
        context,
        'Please select federation type',
        isError: true,
      );
      return;
    }

    if (_selectedCountryNotifier.value == null) {
      SnackbarUtils.showCustomToast(
        context,
        'Please select Country',
        isError: true,
      );
      return;
    }

    if (_selectedCityNotifier.value == null) {
      SnackbarUtils.showCustomToast(
        context,
        'Please select City',
        isError: true,
      );
      return;
    }

    if (_streetAddressController.text.isEmpty) {
      SnackbarUtils.showCustomToast(
        context,
        'Please add street address',
        isError: true,
      );
      return;
    }


    if (_postCodeController.text.isEmpty) {
      SnackbarUtils.showCustomToast(
        context,
        'Please add postal code',
        isError: true,
      );
      return;
    }

    final federationType = FederationType.values.firstWhere(
      (type) => type.displayName == _selectedTypeNotifier.value,
    );

    final federation = FederationModel(
      name: _federationNameController.text.trim(),
      type: federationType,
      country: _selectedCountryNotifier.value!.country,
      city: _selectedCityNotifier.value!,
      streetAddress: _streetAddressController.text.trim(),
      postCode: _postCodeController.text.trim(),
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

  @override
  void dispose() {
    _federationNameController.dispose();
    _streetAddressController.dispose();
    _postCodeController.dispose();
    _selectedTypeNotifier.dispose();
    _selectedCountryNotifier.dispose();
    _selectedCityNotifier.dispose();
    _hasLogoNotifier.dispose();
    _hasDocumentsNotifier.dispose();
    super.dispose();
  }
}
