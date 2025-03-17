import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

void showLoadingUI(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: AppColor().kAppWhiteColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: getSpinKitWidget(SpinKitIndicatorType.fadingCube),
                  ),
                  // const SizedBox(
                  //   height: 20.0,
                  // ),
                  /*textFont(
                    message,
                    hexToColor(AppResources.hexColor.whiteColor),
                    14.0,
                    FontFamiltyNameUtils().fontPoppins,
                  ),*/
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// SPINKIT
Widget getSpinKitWidget(
  SpinKitIndicatorType type, {
  Color? color,
  double? size,
}) {
  final effectiveColor = AppColor().kAppPrimaryColor;
  final effectiveSize = size ?? 50.0; // Default size if `size` is null

  switch (type) {
    case SpinKitIndicatorType.rotatingCircle:
      return SpinKitRotatingCircle(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.rotatingPlain:
      return SpinKitRotatingPlain(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.pulse:
      return SpinKitPulse(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.doubleBounce:
      return SpinKitDoubleBounce(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.fadingCircle:
      return SpinKitFadingCircle(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.fadingFour:
      return SpinKitFadingFour(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.fadingGrid:
      return SpinKitFadingGrid(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.wave:
      return SpinKitWave(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.threeBounce:
      return SpinKitThreeBounce(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.chasingDots:
      return SpinKitChasingDots(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.wanderingCubes:
      return SpinKitWanderingCubes(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.circle:
      return SpinKitCircle(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.cubeGrid:
      return SpinKitCubeGrid(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.fadingCube:
      return SpinKitFadingCube(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.foldingCube:
      return SpinKitFoldingCube(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.pumpingHeart:
      return SpinKitPumpingHeart(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.squareCircle:
      return SpinKitSquareCircle(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.ripple:
      return SpinKitRipple(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.ring:
      return SpinKitRing(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.hourGlass:
      return SpinKitHourGlass(color: effectiveColor, size: effectiveSize);
    case SpinKitIndicatorType.dancingSquare:
      return SpinKitDancingSquare(color: effectiveColor, size: effectiveSize);
    default:
      return SpinKitCircle(
        color: effectiveColor,
        size: effectiveSize,
      ); // Default option
  }
}

// Enum to define SpinKit types
enum SpinKitIndicatorType {
  rotatingCircle,
  rotatingPlain,
  pulse,
  doubleBounce,
  fadingCircle,
  fadingFour,
  fadingGrid,
  wave,
  threeBounce,
  chasingDots,
  wanderingCubes,
  circle,
  cubeGrid,
  fadingCube,
  foldingCube,
  pumpingHeart,
  squareCircle,
  ripple,
  ring,
  hourGlass,
  dancingSquare,
}
