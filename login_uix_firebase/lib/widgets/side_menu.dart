// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/constant/controllers.dart';
import 'package:login_uix_firebase/constant/style.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/routing/routes.dart';
import 'package:login_uix_firebase/widgets/custom_text.dart';
import 'package:login_uix_firebase/widgets/side_menu_item.dart';
import 'package:social_media_flutter/social_media_flutter.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _width / 48,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 12),
                    //   child: Image.asset("assets/icons/logo.png"),
                    // ),
                    Flexible(
                        child: CustomText(
                      text: "Relationary",
                      size: 20,
                      weight: FontWeight.bold,
                      color: active,
                    )),
                  ],
                )
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((itemName) => SideMenuItem(
                      itemName: itemName == LoginRoute ? "Log In" : itemName,
                      onTap: () {
                        if (itemName == LoginRoute) {}

                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveitemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo(itemName);
                        }
                      },
                    ))
                .toList(),
          ),
          // Generated code for this Column Widget...
          ResponsiveWidget.isCustomSize(context)
              ? Row(
                  children: [
                    Container(
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: InkWell(
                                  onTap: () {},
                                  child: SocialWidget(
                                    placeholderText:
                                        'Facebook', //text visible to viewers
                                    iconData: SocialIconsFlutter
                                        .facebook_box, //use the respective social logo
                                    iconColor:
                                        Color.fromARGB(255, 26, 119, 196),
                                    iconSize: Dimensions
                                        .iconSize28, //(optional, default - grey)
                                    link:
                                        'https://www.facebook.com/pg/TheRelationary/', //provide the link
                                    placeholderStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions
                                            .font10), //placeholder text style
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: SocialWidget(
                                  placeholderText:
                                      'Twitter', //text visible to viewers
                                  iconData: SocialIconsFlutter
                                      .instagram, //use the respective social logo
                                  iconColor: Colors.pink,
                                  iconSize: Dimensions
                                      .iconSize28, //(optional, default - grey)
                                  link:
                                      'https://twitter.com/TheRelationary', //provide the link
                                  placeholderStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions
                                          .font10), //placeholder text style
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: SocialWidget(
                                  placeholderText:
                                      'Instagram', //text visible to viewers
                                  iconData: SocialIconsFlutter
                                      .twitter, //use the respective social logo
                                  iconColor: Colors.blueAccent,
                                  iconSize: Dimensions
                                      .iconSize28, //(optional, default - grey)
                                  link:
                                      'https://www.instagram.com/therelationary/', //provide the link
                                  placeholderStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions
                                          .font10), //placeholder text style
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: SocialWidget(
                                  placeholderText:
                                      'Youtube', //text visible to viewers
                                  iconData: SocialIconsFlutter
                                      .youtube, //use the respective social logo
                                  iconColor: Color.fromARGB(255, 235, 25, 25),
                                  iconSize: Dimensions
                                      .iconSize28, //(optional, default - grey)
                                  link:
                                      'https://www.youtube.com/channel/UCJDgsezvoL79bTAycsJtTog', //provide the link
                                  placeholderStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions
                                          .font10), //placeholder text style
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height05, 0, Dimensions.height05),
                      child: InkWell(
                        onTap: () {},
                        child: SocialWidget(
                          placeholderText: '', //text visible to viewers
                          iconData: SocialIconsFlutter
                              .facebook_box, //use the respective social logo
                          iconColor: Color.fromARGB(
                              255, 26, 119, 196), //(optional, default - grey)
                          link:
                              'https://www.facebook.com/pg/TheRelationary/', //provide the link
                          placeholderStyle: TextStyle(
                              color: Colors.black, fontSize: Dimensions.font20),
                          iconSize:
                              Dimensions.iconSize28, //placeholder text style
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height05, 0, Dimensions.height05),
                      child: SocialWidget(
                        placeholderText: '', //text visible to viewers
                        iconData: SocialIconsFlutter
                            .instagram, //use the respective social logo
                        iconColor: Colors.pink, //(optional, default - grey)
                        link:
                            'https://twitter.com/TheRelationary', //provide the link
                        placeholderStyle: TextStyle(
                            color: Colors.black, fontSize: Dimensions.font20),
                        iconSize:
                            Dimensions.iconSize28, //placeholder text style
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height05, 0, Dimensions.height05),
                      child: SocialWidget(
                        placeholderText: '', //text visible to viewers
                        iconData: SocialIconsFlutter
                            .twitter, //use the respective social logo
                        iconColor:
                            Colors.blueAccent, //(optional, default - grey)
                        link:
                            'https://www.instagram.com/therelationary/', //provide the link
                        placeholderStyle: TextStyle(
                            color: Colors.black, fontSize: Dimensions.font20),
                        iconSize:
                            Dimensions.iconSize28, //placeholder text style
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height05, 0, Dimensions.height05),
                      child: SocialWidget(
                        placeholderText: '', //text visible to viewers
                        iconData: SocialIconsFlutter
                            .youtube, //use the respective social logo
                        iconColor: Color.fromARGB(
                            255, 235, 25, 25), //(optional, default - grey)
                        link:
                            'https://www.youtube.com/channel/UCJDgsezvoL79bTAycsJtTog', //provide the link
                        placeholderStyle: TextStyle(
                            color: Colors.black, fontSize: Dimensions.font20),
                        iconSize:
                            Dimensions.iconSize28, //placeholder text style
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
