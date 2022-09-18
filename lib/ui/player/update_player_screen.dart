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
  final Function(Player? updatedPlayer) onUpdateSuccess;

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
  final _tecName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tecName.text = widget.player.name ?? "";
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
          Padding(
            padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 250,
                        child: UIUtils.buildCachedNetworkImage(
                            widget.player.avatar ?? ""),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(
                            DimenConstants.marginPaddingMedium),
                        child: TextFormField(
                          controller: _tecName,
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
                ),
                UIUtils.getButton(
                  "Xoá",
                  () {
                    _deletePlayer();
                  },
                ),
                UIUtils.getButton(
                  "Cập nhật",
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deletePlayer() {
    showConfirmDialog(
      StringConstants.warning,
      "Bạn có muốn xoá người chơi ${widget.player.name}?",
      StringConstants.ok,
      () {
        _cUpdatePlayer.deletePlayer(widget.player).then((value) {
          Get.back();
          showSnackBarFull(StringConstants.warning,
              "Đã xoá người chơi ${widget.player.name}");
          widget.onUpdateSuccess.call(null);
        });
      },
    );
  }
}
