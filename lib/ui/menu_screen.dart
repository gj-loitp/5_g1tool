import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/c/dimen_constant.dart';
import '../common/utils/ui_utils.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Main menu",
        () {
          SystemNavigator.pop();
        },
        null,
      ),
      body: Stack(
        children: [
          UIUtils.buildCachedNetworkImage(
              "https://live.staticflickr.com/8653/28179077686_ec36b85f0b_b.jpg"),
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
            children: [
              UIUtils.getButton(
                "Animation",
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
