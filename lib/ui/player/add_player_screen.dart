import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g1tool/common/c/color_constant.dart';

import '../../common/utils/ui_utils.dart';

class AddPlayerScreen extends StatelessWidget {
  final VoidCallback onAddSuccess;

  const AddPlayerScreen({
    Key? key,
    required this.onAddSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Thêm người chơi",
        () {
          SystemNavigator.pop();
        },
        null,
      ),
      body: Stack(
        children: [
          UIUtils.buildCachedNetworkImage(
              "https://live.staticflickr.com/65535/48556433996_fb33140ec1_b.jpg"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.appColor,
          onPressed: () {},
          child: const Icon(Icons.add)),
    );
  }
}
