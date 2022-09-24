import 'dart:io';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/ui/player/list_player_screen.dart';
import 'package:get/get.dart';

import '../common/c/string_constant.dart';
import '../common/utils/ui_utils.dart';
import 'bilac/bilac_main_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuScreen();
  }
}

class _MenuScreen extends State<MenuScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "G1 tools",
        () {
          exit(0);
        },
        null,
      ),
      body: Stack(
        children: [
          UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
          AnimatedBackground(
            behaviour: BubblesBehaviour(),
            vsync: this,
            child: Padding(
              padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
              child: Column(
                children: [
                  const Spacer(),
                  UIUtils.getButton(
                    "Bi lắc",
                    () {
                      Get.to(() => const BiLacMainScreen());
                    },
                  ),
                  //TODO iplm button uno
                  // UIUtils.getButton(
                  //   "Uno",
                  //   () {
                  //   },
                  // ),
                  UIUtils.getButton(
                    "Quản lý người chơi",
                    () {
                      Get.to(() => const ListPlayerScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
