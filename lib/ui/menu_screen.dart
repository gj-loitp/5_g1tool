import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/ui/player/list_player_screen.dart';
import 'package:get/get.dart';

import '../common/c/string_constant.dart';
import '../common/utils/ui_utils.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
          Padding(
            padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Column(
              children: [
                const Spacer(),
                UIUtils.getButton(
                  "Bi lắc",
                  () {},
                ),
                UIUtils.getButton(
                  "Uno",
                  () {},
                ),
                UIUtils.getButton(
                  "Quản lý người chơi",
                  () {
                    Get.to(() => const ListPlayerScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
