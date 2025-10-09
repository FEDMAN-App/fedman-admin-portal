
import 'package:fedman_admin_app/core/common_widgets/custom_buttons.dart';
import 'package:fedman_admin_app/core/extensions/extensions_barrell.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';



class RetryWidget extends StatelessWidget {
  const RetryWidget(
      {super.key, this.message = "Something went wrong, try again",this.onTapOnRetry});

  final String message;
  final  VoidCallback?  onTapOnRetry;

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Text(
            message,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.baseBlackColor,),
                      ),
        10.verticalSpace,

         CustomButton(
          onTap:onTapOnRetry ,
          isSecondaryBtn: true,
          borderColor: AppColors.primaryColor,
          title: "Retry",
        )
      ],
    );
  }
}
