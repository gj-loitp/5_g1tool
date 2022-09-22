import 'dart:convert';

import 'package:animated_background/animated_background.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:get/get.dart';

import '../../common/c/string_constant.dart';
import '../../common/core/base_stateful_state.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/bilac/bilac_main_controller.dart';
import '../../model/player.dart';
import '../player/select_player_screen.dart';

class BiLacMainScreen extends StatefulWidget {
  const BiLacMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BiLacMainScreenState();
  }
}

class _BiLacMainScreenState extends BaseStatefulState<BiLacMainScreen>
    with TickerProviderStateMixin {
  final _cBilacMainController = Get.put(BilacMainController());

  @override
  void initState() {
    super.initState();
    // _cBilacMainController.getBilacByTime(TimeConstants.getTime(DateTime.now()));
  }

  @override
  void dispose() {
    super.dispose();
    //TODO save db
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
            AnimatedBackground(
              behaviour: BubblesBehaviour(),
              vsync: this,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  CalendarAppBar(
                    accent: ColorConstants.appColor.withOpacity(0.7),
                    onDateChanged: (value) {
                      _onDateChanged(value);
                    },
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30 * 3)),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    selectedDate: DateTime.now(),
                    fullCalendar: true,
                    locale: 'vi',
                    padding: 5.0,
                  ),
                  _buildScoreSelectorView(),
                  // Expanded(child: _buildBody()),
                  _buildBody(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstants.appColor,
            onPressed: () {
              showWarningDialog(
                StringConstants.warning,
                "Bạn có muốn tạo Game mới?",
                () {},
                () {
                  Get.to(
                    () => SelectPlayerScreen(
                      onListPlayerSelected: (listPlayerSelected) {
                        _cBilacMainController.genNewGame(listPlayerSelected);
                      },
                    ),
                  );
                },
                (type) {},
              );
            },
            child: const Icon(Icons.add)),
      );
    });
  }

  void _onDateChanged(DateTime dateTime) {
    // print("_onDateChanged $dateTime");
    // _cBilacMainController.getBilacByTime(TimeConstants.getTime(dateTime));
  }

  Widget _buildBody() {
    if (_cBilacMainController.listPlayer.isEmpty) {
      return UIUtils.buildNoDataView();
    } else {
      var maxRound = _cBilacMainController.getMaxRound();
      var width = 70.0;
      log("maxRound $maxRound");
      /*return ScrollableTableView(
        rowDividerHeight: 0.0,
        columns: columns.map((column) {
          return TableViewColumn(
            label: column,
          );
        }).toList(),
        rows: rows.map((record) {
          return TableViewRow(
            height: 40,
            cells: record.mapIndexed((index, player) {
              String text;
              String? score = player.getScoreByIndex(index);
              if (index == 0) {
                text = '${player.name} (${player.getNumberOfRound()})';
              } else {
                text = "$score";
              }
              return TableViewCell(
                child: InkWell(
                  child: Container(
                    margin: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Player.getColorByScore(index, score),
                      border: Border.all(
                        color: Colors.red,
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    child: UIUtils.getText(
                      text,
                      fontSize: 12.0,
                    ),
                  ),
                  onTap: () {
                    _onTap(index, player);
                  },
                ),
              );
            }).toList(),
          );
        }).toList(),
      );*/

      List<DataColumn> getListDataColumn() {
        DataColumn genDataColumn(String label) {
          return DataColumn(
            label: Container(
              padding: const EdgeInsets.all(DimenConstants.marginPaddingTiny),
              width: width,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: DimenConstants.txtMedium,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        var list = <DataColumn>[];
        list.add(genDataColumn('Tên'));
        for (int i = 0; i < maxRound; i++) {
          list.add(genDataColumn('$i'));
        }
        return list;
      }

      List<DataRow> getListDataRow() {
        DataRow genDataRow(
          int index,
          Player player,
          Function(int indexPlayer, Player player, int indexScore) onTap,
        ) {
          var cells = <DataCell>[];
          cells.add(
            DataCell(
              Container(
                padding: const EdgeInsets.all(DimenConstants.marginPaddingTiny),
                width: width,
                alignment: Alignment.centerLeft,
                child: UIUtils.getText(
                  player.getName(),
                  fontSize: DimenConstants.txtSmall,
                ),
              ),
            ),
          );
          var listScore = player.getListScore();
          log(">>>${player.name} index $index, listScore ${jsonEncode(listScore)}");
          for (int i = 0; i < listScore.length; i++) {
            var score = listScore[i];
            cells.add(
              DataCell(
                Container(
                  padding:
                      const EdgeInsets.all(DimenConstants.marginPaddingTiny),
                  color: Player.getColorByScore(score),
                  alignment: Alignment.center,
                  width: width,
                  child: UIUtils.getText(
                    score,
                    fontSize: DimenConstants.txtMedium,
                  ),
                ),
                onTap: () {
                  onTap.call(index, player, i);
                },
              ),
            );
          }
          return DataRow(cells: cells);
        }

        var list = <DataRow>[];
        var listPlayer = _cBilacMainController.listPlayer;
        for (int i = 0; i < listPlayer.length; i++) {
          Player p = listPlayer[i];
          list.add(
            genDataRow(
              i,
              p,
              (index, player, indexScore) {
                log("onTap $index ${jsonEncode(player)} $indexScore");
                _onTap(indexScore, player);
              },
            ),
          );
        }
        return list;
      }

      return ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: DimenConstants.marginPaddingMedium),
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.white.withOpacity(0.9)),
              dataRowHeight: 45.0,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue.withOpacity(0.9)),
              headingRowHeight: 45.0,
              horizontalMargin: 0.0,
              columnSpacing: 0.0,
              columns: getListDataColumn(),
              rows: getListDataRow(),
            ),
          ),
        ],
      );
    }
  }

  void _onTap(int index, Player player) {
    // print(">>>_onTap index $index - ${jsonEncode(player)}");
    var currentScore = _cBilacMainController.scoreSelector.value;
    _cBilacMainController.updateScoreOfPlayer(index, player, currentScore);
  }

  Widget _buildScoreSelectorView() {
    return Visibility(
      visible: _cBilacMainController.listPlayer.isNotEmpty,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: DimenConstants.marginPaddingMedium),
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                _showScoreSheet(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _cBilacMainController.getScoreSelectorColor(),
                  border: Border.all(
                    color: Colors.red,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding:
                    const EdgeInsets.all(DimenConstants.marginPaddingSmall),
                child: UIUtils.getText(
                    _cBilacMainController.getScoreSelectorText()),
              ),
            ),
          ),
          const SizedBox(width: DimenConstants.marginPaddingMedium),
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                //TODO ket qua
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  border: Border.all(
                    color: Colors.red,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding:
                    const EdgeInsets.all(DimenConstants.marginPaddingSmall),
                child: UIUtils.getText("Kết quả"),
              ),
            ),
          ),
          const SizedBox(width: DimenConstants.marginPaddingMedium),
        ],
      ),
    );
  }

  Future<void> _showScoreSheet(BuildContext context) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: UIUtils.getText("Mời chọn"),
          message: UIUtils.getText("Chọn trạng thái trận đấu"),
          actions: [
            CupertinoActionSheetAction(
              child: UIUtils.getText("Mặc định"),
              onPressed: () {
                _cBilacMainController.setScoreSelector(Player.RESULT_NONE);
                Get.back();
              },
            ),
            CupertinoActionSheetAction(
              child: UIUtils.getText("Thắng"),
              onPressed: () {
                _cBilacMainController.setScoreSelector(Player.RESULT_WIN);
                Get.back();
              },
            ),
            CupertinoActionSheetAction(
              child: UIUtils.getText("Thua"),
              onPressed: () {
                _cBilacMainController.setScoreSelector(Player.RESULT_LOSE);
                Get.back();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: UIUtils.getText("Đóng"),
            onPressed: () {
              Get.back();
            },
          ),
        );
      },
    );
  }
}
