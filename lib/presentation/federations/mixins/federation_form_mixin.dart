import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import '../../country_and_its_cities/data/models/country_and_its_cities.dart';

class DocumentFile {
  final String name;
  final DropzoneFileInterface file;
  final String id;

  DocumentFile({
    required this.name,
    required this.file,
    required this.id,
  });
}

mixin FederationFormMixin<T extends StatefulWidget> on State<T> {
  // Text Controllers
  final TextEditingController federationNameController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  
  // Value Notifiers
  final ValueNotifier<String?> selectedTypeNotifier = ValueNotifier(null);
  final ValueNotifier<CountryAndItsCities?> selectedCountryNotifier = ValueNotifier(null);
  final ValueNotifier<String?> selectedCityNotifier = ValueNotifier(null);
  final ValueNotifier<bool> hasLogoNotifier = ValueNotifier(false);
  final ValueNotifier<bool> hasDocumentsNotifier = ValueNotifier(false);
  
  // File upload properties
  String? logoFileName;
  String? logoFileUrl;
  DropzoneFileInterface? logoFile;
  
  // Multiple documents support
  List<DropzoneFileInterface> documentFiles = [];
  List<String> documentFileNames = [];
  final ValueNotifier<List<DocumentFile>> selectedDocumentsNotifier = ValueNotifier([]);
  
  DropzoneViewController? logoDropzoneController;
  DropzoneViewController? documentsDropzoneController;

  @override
  void dispose() {
    // Dispose text controllers
    federationNameController.dispose();
    streetAddressController.dispose();
    postCodeController.dispose();
    
    // Dispose value notifiers
    selectedTypeNotifier.dispose();
    selectedCountryNotifier.dispose();
    selectedCityNotifier.dispose();
    hasLogoNotifier.dispose();
    hasDocumentsNotifier.dispose();
    selectedDocumentsNotifier.dispose();
    
    super.dispose();
  }
  
  void clearForm() {
    federationNameController.clear();
    streetAddressController.clear();
    postCodeController.clear();
    selectedTypeNotifier.value = null;
    selectedCountryNotifier.value = null;
    selectedCityNotifier.value = null;
    hasLogoNotifier.value = false;
    hasDocumentsNotifier.value = false;
    logoFileName = null;
    logoFile = null;
    logoFileUrl = null;
    documentFiles.clear();
    documentFileNames.clear();
    selectedDocumentsNotifier.value = [];
  }
}