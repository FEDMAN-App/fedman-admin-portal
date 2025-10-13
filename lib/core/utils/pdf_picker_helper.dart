import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'file_validation_utils.dart';
import 'snackbar_utils.dart';

/// Result class for PDF file picking operations
class PdfPickResult {
  final String fileName;
  final String filePath;
  final Uint8List? fileBytes; // For web platform
  final dynamic file; // For DropzoneFileInterface on web

  PdfPickResult({
    required this.fileName,
    required this.filePath,
    this.fileBytes,
    this.file,
  });
}

/// Helper class for PDF file picking and validation
class PdfPickerHelper {
  PdfPickerHelper._();

  /// Picks a single PDF file using file_picker package (cross-platform)
  ///
  /// [context] - Build context for showing error messages
  /// [maxSizeInMB] - Maximum file size allowed in MB (default: 10MB)
  ///
  /// Returns [PdfPickResult] if successful, null if cancelled or validation failed
  static Future<PdfPickResult?> pickSinglePdfWithFilePicker(
    BuildContext context, {
    int maxSizeInMB = 10,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return null; // User cancelled
      }

      final file = result.files.first;
      final fileName = file.name;
      final fileSize = file.size;
      final filePath = file.path ?? '';

      // Validate file type
      if (!FileValidationUtils.isPdfFile(fileName)) {
        if (context.mounted) {
          SnackbarUtils.showCustomToast(
            context,
            FileValidationUtils.getInvalidFileTypeMessage(['PDF']),
            isError: true,
          );
        }
        return null;
      }

      // Validate file size
      if (!FileValidationUtils.isFileSizeValid(fileSize, maxSizeInMB)) {
        if (context.mounted) {
          SnackbarUtils.showCustomToast(
            context,
            FileValidationUtils.getFileSizeErrorMessage(maxSizeInMB),
            isError: true,
          );
        }
        return null;
      }

      return PdfPickResult(
        fileName: fileName,
        filePath: filePath,
        fileBytes: file.bytes,
      );
    } catch (e) {
      if (context.mounted) {
        SnackbarUtils.showCustomToast(
          context,
          'Error picking PDF file: $e',
          isError: true,
        );
      }
      return null;
    }
  }

  /// Picks multiple PDF files using file_picker package (cross-platform)
  ///
  /// [context] - Build context for showing error messages
  /// [maxSizeInMB] - Maximum file size allowed in MB (default: 10MB)
  ///
  /// Returns list of [PdfPickResult] for valid files
  static Future<List<PdfPickResult>> pickMultiplePdfsWithFilePicker(
    BuildContext context, {
    int maxSizeInMB = 10,
        bool allowMultiple=true
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: allowMultiple,
      );

      if (result == null || result.files.isEmpty) {
        return []; // User cancelled
      }

      final List<PdfPickResult> validFiles = [];

      for (final file in result.files) {
        final fileName = file.name;
        final fileSize = file.size;
        final filePath = file.path ?? '';

        // Validate file type
        if (!FileValidationUtils.isPdfFile(fileName)) {
          if (context.mounted) {
            SnackbarUtils.showCustomToast(
              context,
              'Invalid file type for "$fileName". Only PDF files are allowed.',
              isError: true,
            );
          }
          continue;
        }

        // Validate file size
        if (!FileValidationUtils.isFileSizeValid(fileSize, maxSizeInMB)) {
          if (context.mounted) {
            SnackbarUtils.showCustomToast(
              context,
              'File "$fileName" is too large. Maximum size is ${maxSizeInMB}MB.',
              isError: true,
            );
          }
          continue;
        }

        validFiles.add(PdfPickResult(
          fileName: fileName,
          filePath: filePath,
          fileBytes: file.bytes,
        ));
      }

      return validFiles;
    } catch (e) {
      if (context.mounted) {
        SnackbarUtils.showCustomToast(
          context,
          'Error picking PDF files: $e',
          isError: true,
        );
      }
      return [];
    }
  }

  /// Validates a dropped PDF file (for web drag-and-drop)
  ///
  /// [context] - Build context for showing error messages
  /// [dropzoneController] - Dropzone controller for file operations
  /// [file] - Dropped file interface
  /// [maxSizeInMB] - Maximum file size allowed in MB (default: 10MB)
  ///
  /// Returns [PdfPickResult] if valid, null if validation failed
  static Future<PdfPickResult?> validateDroppedPdf(
    BuildContext context,
    DropzoneViewController dropzoneController,
    DropzoneFileInterface file, {
    int maxSizeInMB = 10,
  }) async {
    try {
      final fileName = await dropzoneController.getFilename(file);
      final fileSize = await dropzoneController.getFileSize(file);
      final mimeType = await dropzoneController.getFileMIME(file);

      // Validate file type
      if (!FileValidationUtils.isPdfFile(fileName, mimeType: mimeType)) {
        if (context.mounted) {
          SnackbarUtils.showCustomToast(
            context,
            FileValidationUtils.getInvalidFileTypeMessage(['PDF']),
            isError: true,
          );
        }
        return null;
      }

      // Validate file size
      if (!FileValidationUtils.isFileSizeValid(fileSize, maxSizeInMB)) {
        if (context.mounted) {
          SnackbarUtils.showCustomToast(
            context,
            FileValidationUtils.getFileSizeErrorMessage(maxSizeInMB),
            isError: true,
          );
        }
        return null;
      }

      return PdfPickResult(
        fileName: fileName,
        filePath: '', // Not applicable for dropped files
        file: file,
      );
    } catch (e) {
      if (context.mounted) {
        SnackbarUtils.showCustomToast(
          context,
          'Error validating dropped PDF: $e',
          isError: true,
        );
      }
      return null;
    }
  }

  /// Picks PDFs using dropzone controller (for web)
  ///
  /// [context] - Build context for showing error messages
  /// [dropzoneController] - Dropzone controller for file operations
  /// [allowMultiple] - Whether to allow multiple file selection
  /// [maxSizeInMB] - Maximum file size allowed in MB (default: 10MB)
  ///
  /// Returns list of [PdfPickResult] for valid files
  static Future<List<PdfPickResult>> pickPdfsWithDropzone(
    BuildContext context,
    DropzoneViewController dropzoneController, {
    bool allowMultiple = true,
    int maxSizeInMB = 10,
  }) async {
    try {
      final files = await dropzoneController.pickFiles(
        multiple: allowMultiple,
        mime: ["application/pdf"],
      );

      if (files.isEmpty) {
        return []; // User cancelled
      }

      final List<PdfPickResult> validFiles = [];

      for (final file in files) {
        final fileName = file.name;
        final mimeType = await dropzoneController.getFileMIME(file);
        final fileSize = await dropzoneController.getFileSize(file);

        // Validate file type
        if (!FileValidationUtils.isPdfFile(fileName, mimeType: mimeType)) {
          if (context.mounted) {
            SnackbarUtils.showCustomToast(
              context,
              'Invalid file type for "$fileName". Only PDF files are allowed.',
              isError: true,
            );
          }
          continue;
        }

        // Validate file size
        if (!FileValidationUtils.isFileSizeValid(fileSize, maxSizeInMB)) {
          if (context.mounted) {
            SnackbarUtils.showCustomToast(
              context,
              'File "$fileName" is too large. Maximum size is ${maxSizeInMB}MB.',
              isError: true,
            );
          }
          continue;
        }

        validFiles.add(PdfPickResult(
          fileName: fileName,
          filePath: '', // Not applicable for dropzone files
          file: file,
        ));
      }

      return validFiles;
    } catch (e) {
      if (context.mounted) {
        SnackbarUtils.showCustomToast(
          context,
          'Error picking PDF files: $e',
          isError: true,
        );
      }
      return [];
    }
  }

  /// Simplified PDF picker for single file selection
  ///
  /// [context] - Build context for showing error messages
  /// [dropzoneController] - Dropzone controller for file operations
  /// [maxSizeInMB] - Maximum file size allowed in MB (default: 10MB)
  ///
  /// Returns [PdfPickResult] if successful, null if cancelled or validation failed
  static Future<PdfPickResult?> pickSinglePdf(
    BuildContext context,
    DropzoneViewController dropzoneController, {
    int maxSizeInMB = 10,
  }) async {
    final results = await pickPdfsWithDropzone(
      context,
      dropzoneController,
      allowMultiple: false,
      maxSizeInMB: maxSizeInMB,
    );
    
    return results.isNotEmpty ? results.first : null;
  }

  /// Validates multiple dropped PDF files
  ///
  /// [context] - Build context for showing error messages
  /// [dropzoneController] - Dropzone controller for file operations
  /// [files] - List of dropped file interfaces
  /// [maxSizeInMB] - Maximum file size allowed in MB (default: 10MB)
  ///
  /// Returns list of [PdfPickResult] for valid files
  static Future<List<PdfPickResult>> validateMultipleDroppedPdfs(
    BuildContext context,
    DropzoneViewController dropzoneController,
    List<DropzoneFileInterface> files, {
    int maxSizeInMB = 10,
  }) async {
    final List<PdfPickResult> validFiles = [];

    for (final file in files) {
      final result = await validateDroppedPdf(
        context,
        dropzoneController,
        file,
        maxSizeInMB: maxSizeInMB,
      );
      
      if (result != null) {
        validFiles.add(result);
      }
    }

    return validFiles;
  }

  /// Converts PdfPickResult to DocumentFile (if DocumentFile class exists)
  /// This is a utility method to integrate with existing document management
  static dynamic convertToDocumentFile(PdfPickResult result) {
    // This would need to be implemented based on your DocumentFile class structure
    // For now, returning a simple map structure
    return {
      'name': result.fileName,
      'file': result.file,
      'id': DateTime.now().millisecondsSinceEpoch.toString() + result.fileName,
    };
  }
}