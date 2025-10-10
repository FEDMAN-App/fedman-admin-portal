/// Utility class for file validation operations
class FileValidationUtils {
  FileValidationUtils._();

  /// Validates if the file is a PDF based on extension and MIME type
  /// 
  /// [fileName] - The name of the file to validate
  /// [mimeType] - Optional MIME type for additional validation (mainly for web uploads)
  /// 
  /// Returns true if the file is a valid PDF, false otherwise
  static bool isPdfFile(String fileName, {String? mimeType}) {
    final hasValidExtension = fileName.toLowerCase().endsWith('.pdf');
    
    // Check MIME type if available (for web uploads)
    if (mimeType != null) {
      final hasValidMimeType = mimeType.toLowerCase() == 'application/pdf';
      return hasValidExtension && hasValidMimeType;
    }
    
    // For non-web platforms, rely on extension only
    return hasValidExtension;
  }

  /// Validates if the file is an image (JPG, JPEG, PNG) based on extension and MIME type
  /// 
  /// [fileName] - The name of the file to validate
  /// [mimeType] - Optional MIME type for additional validation (mainly for web uploads)
  /// 
  /// Returns true if the file is a valid image, false otherwise
  static bool isImageFile(String fileName, {String? mimeType}) {
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

  /// Validates file size against a maximum limit
  /// 
  /// [fileSize] - Size of the file in bytes
  /// [maxSizeInMB] - Maximum allowed size in megabytes
  /// 
  /// Returns true if file size is within limit, false otherwise
  static bool isFileSizeValid(int fileSize, int maxSizeInMB) {
    final maxSizeInBytes = maxSizeInMB * 1024 * 1024;
    return fileSize <= maxSizeInBytes;
  }

  /// Gets a user-friendly error message for invalid file types
  /// 
  /// [expectedTypes] - List of expected file types (e.g., ['PNG', 'JPG'])
  /// 
  /// Returns formatted error message
  static String getInvalidFileTypeMessage(List<String> expectedTypes) {
    if (expectedTypes.length == 1) {
      return 'Please upload only ${expectedTypes.first} files.';
    }
    
    final allButLast = expectedTypes.take(expectedTypes.length - 1).join(', ');
    final last = expectedTypes.last;
    return 'Please upload only $allButLast or $last files.';
  }

  /// Gets a user-friendly error message for oversized files
  /// 
  /// [maxSizeInMB] - Maximum allowed size in megabytes
  /// 
  /// Returns formatted error message
  static String getFileSizeErrorMessage(int maxSizeInMB) {
    return 'Max file size is ${maxSizeInMB}MB. Please upload a file with less than or equal to ${maxSizeInMB}MB.';
  }
}