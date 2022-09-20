import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:get/get.dart';

import '../../common/c/string_constant.dart';
import '../../common/core/base_stateful_state.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/bilac/bilac_main_controller.dart';

class BiLacMainScreen extends StatefulWidget {
  const BiLacMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BiLacMainScreenState();
  }
}

class _BiLacMainScreenState extends BaseStatefulState<BiLacMainScreen> {
  final _cListPlayer = Get.put(BilacMainController());

  @override
  void initState() {
    super.initState();
    _cListPlayer.getListPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Bi lắc",
        () {
          Get.back();
        },
        null,
      ),
      body: Obx(() {
        return Stack(
          children: [
            UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.appColor,
          onPressed: () {},
          child: const Icon(Icons.add)),
    );
  }
}
