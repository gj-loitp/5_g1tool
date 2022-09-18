import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g1tool/common/c/color_constant.dart';

import '../../common/utils/ui_utils.dart';

class ListPlayerScreen extends StatelessWidget {
  const ListPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Danh sách người chơi",
        () {
          SystemNavigator.pop();
        },
        null,
      ),
      body: Stack(
        children: [
          UIUtils.buildCachedNetworkImage(
              "https://live.staticflickr.com/4705/28140165009_ba3a77fdfc_b.jpg"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.appColor,
          onPressed: () {},
          child: const Icon(Icons.add)),
    );
  }
}
