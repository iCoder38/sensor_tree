// ignore: must_be_immutable
import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  String? type;
  final List<Widget>? actions;
  final Widget? leading;

  CustomAppbar({
    super.key,
    required this.title,
    this.type,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: customText(
        title,
        16.0,
        context,
        fontWeight: FontWeight.w700,
        lightModeColor: AppColor().kAppWhiteColor,
      ),
      centerTitle: true,
      leading: leading,
      actions: actions,
      backgroundColor: AppColor().kAppNavigationColor,

      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
