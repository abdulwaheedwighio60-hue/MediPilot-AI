import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    this.title,
    this.centerTitle = true,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.bottom,
    this.flexibleSpace,
    this.titleSpacing,
    this.toolbarHeight = kToolbarHeight,
    this.onBackPressed,
    this.showBackButton = false,
  });

  final Widget? title;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final double scrolledUnderElevation;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final double? titleSpacing;
  final double toolbarHeight;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      bottom: bottom,
      flexibleSpace: flexibleSpace,
      titleSpacing: titleSpacing,
      toolbarHeight: toolbarHeight,
      leading: showBackButton
          ? IconButton(
        onPressed: onBackPressed ??
                () {
              Navigator.pop(context);
            },
        icon: const Icon(CupertinoIcons.back),
      )
          : leading,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0));
}