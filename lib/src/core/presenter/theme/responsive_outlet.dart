import 'package:flutter/widgets.dart';
import 'package:task/src/core/presenter/theme/size_outlet.dart';

abstract class ResponsiveOutlet {
  //#region LoadingResponsiveSize
  static double loadingResponsiveSize(BuildContext context, int size) => aspectRatio(context) * size;
  //#endregion

  //#region Responsive
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double aspectRatio(BuildContext context) => width(context) / height(context);
  static double aspectRatioSizeable(BuildContext context, double size) => width(context) / height(context) * size;
  //#endregion

  //#region TextResponsiveSize
  static double textSmall(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeSmall;
  static double textDefault(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeDefault;
  static double textMedium(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeMedium;
  static double textLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeLarge;
  static double textExtraLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeExtraLarge;
  //#endregion

  //#region PaddingResponsiveSize
  static double paddingSmall(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingSmall;
  static double paddingDefault(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingDefault;
  static double paddingMedium(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingMedium;
  static double paddingLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingLarge;
  static double paddingExtraLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingExtraLarge;
  //#endregion
}