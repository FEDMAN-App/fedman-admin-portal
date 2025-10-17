import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';
import 'package:fedman_admin_app/core/constants/app_assets.dart';
import 'package:fedman_admin_app/core/utils/snackbar_utils.dart';
import '../../blocs/discipline_image_bloc/discipline_image_bloc.dart';
import 'discipline_image_widget.dart';

class EditableDisciplineImageWidget extends StatefulWidget {
  final int disciplineId;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;

  const EditableDisciplineImageWidget({
    super.key,
    required this.disciplineId,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
  });

  @override
  State<EditableDisciplineImageWidget> createState() => _EditableDisciplineImageWidgetState();
}

class _EditableDisciplineImageWidgetState extends State<EditableDisciplineImageWidget> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _previewImageBytes;
  bool _isUploading = false;
  String? _uploadedImageUrl;
  int _imageRefreshKey = 0;

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (image != null) {
        final Uint8List imageBytes = await image.readAsBytes();
        final String fileName = image.name;
        
        setState(() {
          _previewImageBytes = imageBytes;
          _isUploading = true;
        });
        
        if (mounted) {
          context.read<DisciplineImageBloc>().add(
            UploadDisciplineImageRequested(
              disciplineId: widget.disciplineId,
              imageBytes: imageBytes,
              fileName: fileName,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        SnackbarUtils.showCustomToast(
          context,
          'Failed to pick image: $e',
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisciplineImageBloc, DisciplineImageState>(
      listener: (context, state) {
        if (state is DisciplineImageUploaded) {
          setState(() {
            _isUploading = false;
            _previewImageBytes = null;
            _uploadedImageUrl = state.imageUrl;
            _imageRefreshKey++; // Force refresh of DisciplineImageWidget
          });
          SnackbarUtils.showCustomToast(
            context,
            state.message,
            isError: false,
          );
        } else if (state is DisciplineImageError) {
          setState(() {
            _isUploading = false;
            _previewImageBytes = null;
          });
          SnackbarUtils.showCustomToast(
            context,
            state.message,
            isError: true,
          );
        }
      },
      child: Stack(
        children: [
          // Image widget
          Container(
            width: widget.width ?? 100,
            height: widget.height ?? 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              border: Border.all(
                color: AppColors.neutral200,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              child: _previewImageBytes != null
                  ? Image.memory(
                      _previewImageBytes!,
                      width: widget.width ?? 100,
                      height: widget.height ?? 100,
                      fit: widget.fit ?? BoxFit.cover,
                    )
                  : DisciplineImageWidget(
                      key: ValueKey(_imageRefreshKey), // Force rebuild when image changes
                      disciplineId: widget.disciplineId,
                      width: widget.width ?? 100,
                      height: widget.height ?? 100,
                      borderRadius: widget.borderRadius ?? 8,
                      fit: widget.fit ?? BoxFit.cover,
                    ),
            ),
          ),
          
          // Loading overlay
          if (_isUploading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.baseBlackColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.baseWhiteColor,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          
          // Edit icon
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: _isUploading ? null : _pickAndUploadImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.baseBlackColor.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  AppAssets.editIcon,
                  width: 12,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                    AppColors.baseWhiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}