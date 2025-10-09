// import 'package:cached_network_image/cached_network_image.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html show ImageElement;
import 'dart:ui_web' as ui;



class CustomCachedImageWidget extends StatelessWidget {
  const CustomCachedImageWidget({
    super.key,
    required this.url,
    this.width = double.maxFinite,
    this.height = 100,
    this.fit = BoxFit.fill,
    this.errorWidget,
  });

  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? errorWidget;

  Widget _buildHtmlImageWidget() {
    final String viewId = 'img-${url.hashCode}';

    // Register the HTML element
    ui.platformViewRegistry.registerViewFactory(
      viewId,
      (int viewId) {
        final html.ImageElement imgElement = html.ImageElement()
          ..src = url
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = _getObjectFit()
          ..style.border = 'none'
          ..style.display = 'block';

        return imgElement;
      },
    );

    return SizedBox(
      width: width == double.maxFinite ? null : width,
      height: height,
      child: HtmlElementView(viewType: viewId),
    );
  }

  String _getObjectFit() {
    switch (fit) {
      case BoxFit.cover:
        return 'cover';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.fitWidth:
        return 'scale-down';
      case BoxFit.fitHeight:
        return 'scale-down';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
    }
  }

  @override
  Widget build(BuildContext context) {
    // For Flutter web and localhost URLs, use HTML img element to bypass CORS
    if (kIsWeb && (url.contains('localhost') || url.contains('127.0.0.1'))) {
      return _buildHtmlImageWidget();
    }

    // For mobile and other URLs, use CachedNetworkImage
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: fit,
      imageUrl: url,
      httpHeaders: const {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
      errorWidget: (context, error, stackTrace) {
        GetIt.I.get<LoggerService>().e('Image loading error: $error');
        GetIt.I.get<LoggerService>().e('StackTrace: $stackTrace');

        // For web localhost errors, fallback to HTML img element
        if (kIsWeb && (url.contains('localhost') || url.contains('127.0.0.1'))) {
          return _buildHtmlImageWidget();
        }

        if (errorWidget != null) {
          return errorWidget!;
        }

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: width == height ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: const Icon(
            Icons.person,
            color: Colors.grey,
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: width == height ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    );
    //Image.network(gifUrl,width: width,height: height,fit: BoxFit.fill,);
    //   CachedNetworkImage(width: width,height: height,fit: BoxFit.fill,placeholder:(context, url) {
    //   return const CircularProgressIndicator();
    // },imageUrl: gifUrl);
  }
}
