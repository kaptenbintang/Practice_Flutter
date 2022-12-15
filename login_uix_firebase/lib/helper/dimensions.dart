import 'package:get/get.dart';
import 'package:login_uix_firebase/helper/responsive.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  static double width = ResponsiveWidget.isphoneScreen(Get.context!)
      ? 414
      : ResponsiveWidget.isSmallScreen(Get.context!)
          ? 912
          : 1280;
  static double height = ResponsiveWidget.isphoneScreen(Get.context!)
      ? 896
      : ResponsiveWidget.isSmallScreen(Get.context!)
          ? 1368
          : 800;
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;
  static double screenResponseSize() =>
      ResponsiveWidget.isSmallScreen(Get.context!) ? screenHeight : screenWidth;
  static double responseSize() =>
      ResponsiveWidget.isSmallScreen(Get.context!) ? height : width;
  //dynamic height padding and margin
  static double height05 = screenHeight / (height / 5);
  static double height08 = screenHeight / (height / 8);
  static double height10 = screenHeight / (height / 10);
  static double height15 = screenHeight / (height / 15);
  static double height20 = screenHeight / (height / 20);
  static double height24 = screenHeight / (height / 24);
  static double height30 = screenHeight / (height / 30);
  static double height31 = screenHeight / (height / 31);
  static double height60 = height30 * 2;
  static double height45 = screenHeight / (height / 45);
  static double height100 = height10 * 10;
  static double height500 = height10 * 50;

//dynamic width padding and margin
  static double width08 = screenWidth / (width / 8);
  static double width10 = screenWidth / (width / 10);
  static double width15 = screenWidth / (width / 15);
  static double width16 = screenWidth / (width / 16);
  static double width20 = screenWidth / (width / 20);
  static double width24 = screenWidth / (width / 24);
  static double width30 = screenWidth / (width / 30);
  static double width60 = width30 * 2;
  static double width40 = width20 * 2;
  static double width100 = width10 * 10;

//fontsize
  static double font2point6 = font26 / 10;
  static double font09 = screenResponseSize() / (responseSize() / 09);
  static double font10 = screenResponseSize() / (responseSize() / 10);
  static double font11 = screenResponseSize() / (responseSize() / 11);
  static double font12 = screenResponseSize() / (responseSize() / 12);
  static double font13 = font26 / 2;
  static double font14 = screenResponseSize() / (responseSize() / 14);
  static double font15 = screenResponseSize() / (responseSize() / 15);
  static double font16 = screenResponseSize() / (responseSize() / 16);
  static double font17 = screenResponseSize() / (responseSize() / 17);
  static double font18 = screenResponseSize() / (responseSize() / 18);
  static double font20 = screenResponseSize() / (responseSize() / 20);
  static double font22 = screenResponseSize() / (responseSize() / 22);
  static double font23 = screenResponseSize() / (responseSize() / 23);
  static double font26 = screenResponseSize() / (responseSize() / 26);
  static double font50 = screenResponseSize() / (responseSize() / 50);
  static double font52 = font26 * 2;

//radius
  static double radius10 = screenResponseSize() / (responseSize() / 10);
  static double radius12 = screenResponseSize() / (responseSize() / 12);
  static double radius15 = screenResponseSize() / (responseSize() / 15);
  static double radius20 = screenResponseSize() / (responseSize() / 20);
  static double radius30 = screenResponseSize() / (responseSize() / 30);

  //icon size
  static double iconSize18 = screenResponseSize() / (responseSize() / 18);
  static double iconSize24 = screenResponseSize() / (responseSize() / 24);
  static double iconSize28 = screenResponseSize() / (responseSize() / 28);
  static double iconSize16 = screenResponseSize() / (responseSize() / 16);

  //list view size 390
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  //popular food
  static double popularFoodImgSize = screenHeight / 2.41;

//bottom height
  static double bottomHeightBar = screenHeight / 7.03;

  //splash
  static double splashImg = screenHeight / 3.38;
}
