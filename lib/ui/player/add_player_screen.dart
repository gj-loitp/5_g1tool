import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/common/core/base_stateful_state.dart';
import 'package:get/get.dart';

import '../../common/c/string_constant.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/player/add_player_controller.dart';

class AddPlayerScreen extends StatefulWidget {
  final Function(String name) onAddSuccess;

  const AddPlayerScreen({
    Key? key,
    required this.onAddSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddPlayerScreenState();
  }
}

class _AddPlayerScreenState extends BaseStatefulState<AddPlayerScreen>
    with TickerProviderStateMixin {
  final _cAddPlayer = Get.put(AddPlayerController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: UIUtils.getAppBar(
          "Thêm người chơi",
          () {
            Get.back();
          },
          null,
        ),
        body: Stack(
          children: [
            UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
            AnimatedBackground(
              behaviour: BubblesBehaviour(),
              vsync: this,
              child: ListView(
                padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    color: Colors.white,
                    padding:
                    const EdgeInsets.all(DimenConstants.marginPaddingMedium),
                    child: TextFormField(
                      maxLength: 30,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(Icons.person),
                        hintText: 'Nhập tên người chơi',
                        labelText: 'Tên *',
                      ),
                      onChanged: (text) {
                        _cAddPlayer.setName(text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: _cAddPlayer.isValidName()
                ? ColorConstants.appColor
                : Colors.grey,
            onPressed: () {
              addPlayer();
            },
            child: const Icon(Icons.add)),
      );
    });
  }

  void addPlayer() {
    if (_cAddPlayer.isValidName()) {
      _cAddPlayer.addPlayer(_cAddPlayer.name.value).then((value) {
        Get.back();
        widget.onAddSuccess.call(_cAddPlayer.name.value);
      });
    }
  }
}
