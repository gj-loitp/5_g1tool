import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/model/player.dart';
import 'package:g1tool/ui/player/add_player_screen.dart';
import 'package:g1tool/ui/player/update_player_screen.dart';
import 'package:get/get.dart';

import '../../common/c/string_constant.dart';
import '../../common/core/base_stateful_state.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/list_player_controller.dart';

class ListPlayerScreen extends StatefulWidget {
  const ListPlayerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListPlayerScreenState();
  }
}

class _ListPlayerScreenState extends BaseStatefulState<ListPlayerScreen> {
  final _cListPlayer = Get.put(ListPlayerController());

  @override
  void initState() {
    super.initState();
    _cListPlayer.getListPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Danh sách người chơi",
        () {
          Get.back();
        },
        [
          IconButton(
            icon: const Icon(
              Icons.supervisor_account,
              color: Colors.white,
            ),
            onPressed: () {
              _genDefaultPlayer();
            },
          ),
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
            _buildListPlayerView(),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.appColor,
          onPressed: () {
            Get.to(
              () => AddPlayerScreen(
                onAddSuccess: (name) {
                  showSnackBarFull(
                    StringConstants.warning,
                    "Đã thêm người chơi `$name` thành công",
                  );
                  _cListPlayer.getListPlayer();
                },
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget _buildListPlayerView() {
    var list = _cListPlayer.listPlayer;
    if (list.isEmpty) {
      return UIUtils.buildNoDataView();
    } else {
      Widget buildItem(Player p, GestureTapCallback onTap) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
            margin:
                const EdgeInsets.only(top: DimenConstants.marginPaddingMedium),
            color: Colors.white70,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: Image.network(
                    p.avatar ?? '',
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: DimenConstants.marginPaddingMedium),
                UIUtils.getText(
                  p.getName(),
                  fontSize: DimenConstants.txtLarge,
                ),
              ],
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, i) {
            Player p = list[i];
            return buildItem(
              p,
              () {
                Get.to(
                  () => UpdatePlayerScreen(
                    onUpdateSuccess: (updatedPlayer) {
                      _cListPlayer.getListPlayer();
                    },
                    player: p,
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }

  void _genDefaultPlayer() {
    showWarningDialog(
      StringConstants.warning,
      "Bạn có muốn thêm danh sách người chơi mặc định?",
      () {
        //do nothing
      },
      () {
        _cListPlayer.genListPlayerDefault();
      },
      (type) {
        //do nothing
      },
    );
  }
}
