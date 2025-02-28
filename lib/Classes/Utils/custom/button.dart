import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class CustomButton extends StatelessWidget {
  final String text; // Mandatory parameter
  final double? height;
  final double? width;
  final Color? color;
  final double? textFontWidth;
  final Color? textColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.color,
    this.textFontWidth,
    this.textColor,
    this.borderRadius = 12.0,
    this.textStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0, left: 14.0, top: 8.0),
        child: Container(
          height: height ?? 60,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: color ?? Colors.transparent, // Default color is blue
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          child: customText(
            text,
            textFontWidth ?? 14,
            context,
            fontWeight: FontWeight.w400,
            lightModeColor: textColor,
          ),
        ),
      ),
    );
  }
}
