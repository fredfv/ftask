import 'package:flutter/widgets.dart';
import 'package:task/src/core/presenter/theme/size_outlet.dart';

abstract class ResponsiveOutlet {
  //#region Responsive
  static double width(BuildContext context) => MediaQuery.of(context).size.width;

  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide < SizeOutlet.magicNumber;

  static double aspectRatio(BuildContext context) => isTablet(context)
      ? SizeOutlet.appSizeMobile * MediaQuery.of(context).size.aspectRatio
      : SizeOutlet.appSizeTablet * MediaQuery.of(context).size.aspectRatio;

  static double aspectRatioSizeable(BuildContext context, double size) => width(context) / height(context) * size;

  //#endregion

  //#CardResponsive
  static double cardRatio(BuildContext context) => isTablet(context)
      ? SizeOutlet.cardSizeMobile * MediaQuery.of(context).size.shortestSide
      : SizeOutlet.cardSizeTablet * MediaQuery.of(context).size.shortestSide;

  static double cardSliverRatio(BuildContext context) =>
      isTablet(context) ? SizeOutlet.sliverCardSizeMobile : SizeOutlet.sliverCardSizeTablet;
  //#endregion

  //#region LoadingResponsiveSize
  static double loadingResponsiveSize(BuildContext context, int size) => aspectRatio(context) * size;

  //#endregion

  //#region TextResponsiveSize
  static double textMicro(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeMicro;

  static double textSmall(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeSmall;

  static double textDefault(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeDefault;

  static double textMedium(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeMedium;

  static double textLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeLarge;

  static double textExtraLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeExtraLarge;

  static double textHuge(BuildContext context) => aspectRatio(context) * SizeOutlet.textSizeHuge;

  //#endregion

  //#region PaddingResponsiveSize
  static double paddingSmall(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingSmall;

  static double paddingDefault(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingDefault;

  static double paddingMedium(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingMedium;

  static double paddingLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingLarge;

  static double paddingExtraLarge(BuildContext context) => aspectRatio(context) * SizeOutlet.paddingExtraLarge;
//#endregion
}
