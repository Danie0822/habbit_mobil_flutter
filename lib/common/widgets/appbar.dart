import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/utils/constants/sizes.dart';
import 'package:habbit_mobil_flutter/utils/constants/utils.dart';


class TAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TAppBar({
    super.key,
    this.title,
    this.action,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List <Widget>? action;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build (BuildContext context){
    return Padding
    (padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
    child: AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow ? IconButton(onPressed: leadingOnPressed ?? () => Get.back(),icon: Icon(leadingIcon ?? Icons.arrow_back),) : null,
      title: title,
      actions: action,
    ),
    );

  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}