import 'package:flutter/material.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/common/core/base_stateful_state.dart';
import 'package:get/get.dart';

import '../../common/c/string_constant.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/update_player_controller.dart';
import '../../model/player.dart';

class UpdatePlayerScreen extends StatefulWidget {
  final Player player;
  final Function(Player updatedPlayer) onUpdateSuccess;

  const UpdatePlayerScreen({
    Key? key,
    required this.player,
    required this.onUpdateSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UpdatePlayerScreenState();
  }
}

class _UpdatePlayerScreenState extends BaseStatefulState<UpdatePlayerScreen> {
  final _cUpdatePlayer = Get.put(UpdatePlayerController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Chỉnh sửa người chơi",
            () {
          Get.back();
        },
        null,
      ),
      body: Stack(
        children: [
          UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
          ListView(
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
                    _cUpdatePlayer.setName(text);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
