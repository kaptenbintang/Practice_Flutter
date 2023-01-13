// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/pages/detailPractionerPage/detail_practioner_desktop.dart';
import 'package:login_uix_firebase/pages/detailPractionerPage/detail_practioner_mobile.dart';
import 'package:flutter/material.dart';

import '../../helper/responsive.dart';

class DetailPagePractioner extends ConsumerStatefulWidget {
  static const routeName = '/detailPage';
  final Practioner practioner;
  const DetailPagePractioner({super.key, required this.practioner});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailPagePractionerState();
}

class _DetailPagePractionerState extends ConsumerState<DetailPagePractioner> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return DetailPractionerDesktop(widget.practioner);
    } else {
      return DetailPractionerMobile(widget.practioner);
    }
  }
}
