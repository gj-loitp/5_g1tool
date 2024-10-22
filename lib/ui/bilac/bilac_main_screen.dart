import 'dart:convert';

import 'package:animated_background/animated_background.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/model/bilac.dart';
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
    _onDateChanged(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
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
              child: Column(
                children: [
                  if (_cBilacMainController.isShowCalendar.value)
                    CalendarAppBar(
                      accent: ColorConstants.appColor.withOpacity(0.7),
                      onDateChanged: (value) {
                        _onDateChanged(value);
                      },
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30 * 3)),
                      lastDate: DateTime.now(),
                      selectedDate: DateTime.now(),
                      fullCalendar: true,
                      locale: 'vi',
                      padding: 5.0,
                    ),
                  if (!_cBilacMainController.isShowCalendar.value)
                    const SizedBox(
                        height: DimenConstants.marginPaddingLarge +
                            DimenConstants.marginPaddingMedium),
                  _buildScoreSelectorView(),
                  const SizedBox(height: DimenConstants.marginPaddingSmall),
                  Expanded(
                    child: _buildBody(),
                  ),
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
    _cBilacMainController.setSelectedDatetime(dateTime);
    _cBilacMainController.getBilacByTime();
  }

  Widget _buildBody() {
    var listBilac = _cBilacMainController.listBilac;
    var width = 40.0;
    if (listBilac.isEmpty) {
      return UIUtils.buildNoDataView();
    } else {
      Widget buildChartView(int index) {
        var listPlayer = _cBilacMainController.getListPlayer(index);
        var data = <Map<String, dynamic>>[];
        int scoreWinAll = 0;

        var list = <Player>[];
        for (var p in listPlayer) {
          var deepCopyPlayer = Player.fromJson(p.toJson());
          list.add(deepCopyPlayer);
        }
        list.sort((a, b) => a.getScoreWin().compareTo(b.getScoreWin()));

        for (var p in list) {
          scoreWinAll += p.getScoreWin();
        }
        log(">>>scoreWinAll $scoreWinAll");

        if (scoreWinAll == 0) {
          return UIUtils.buildNoDataView();
        } else {
          for (var p in list) {
            var rate = p.getScoreAndTotalRound();
            var scoreWin = p.getScoreWin();
            var measure = 0;
            try {
              measure = scoreWin * 100 ~/ scoreWinAll;
            } catch (e) {
              // log("Error measure $e");
            }
            data.add({
              'domain': '($rate) ${p.name}',
              'measure': measure,
            });
          }

          Color getColor(int? i) {
            if (i == 0) {
              return Colors.red;
            } else if (i == 1) {
              return Colors.pink;
            } else if (i == 2) {
              return Colors.purple;
            } else if (i == 3) {
              return Colors.deepPurple;
            } else if (i == 4) {
              return Colors.indigo;
            } else if (i == 5) {
              return Colors.blue;
            } else if (i == 6) {
              return Colors.lightBlue;
            } else if (i == 7) {
              return Colors.cyan;
            } else if (i == 8) {
              return Colors.teal;
            } else if (i == 9) {
              return Colors.green;
            } else if (i == 10) {
              return Colors.lightGreen;
            } else if (i == 11) {
              return Colors.lime;
            } else if (i == 12) {
              return Colors.yellow;
            } else if (i == 13) {
              return Colors.amber;
            } else if (i == 14) {
              return Colors.orange;
            } else if (i == 15) {
              return Colors.deepOrange;
            } else if (i == 16) {
              return Colors.brown;
            } else if (i == 17) {
              return Colors.blueGrey;
            }
            return Colors.red;
          }

          return Padding(
            padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: DChartPie(
                labelColor: Colors.white,
                labelLineColor: Colors.white,
                data: data,
                fillColor: (pieData, index) {
                  return getColor(index);
                },
                pieLabel: (pieData, index) {
                  return "${pieData['domain']}:\n${pieData['measure']}%";
                },
                labelPosition: PieLabelPosition.outside,
                labelFontSize: 8,
                labelPadding: 0,
              ),
            ),
          );
        }
      }

      Widget buildItem(int indexBilac, Bilac bilac) {
        var listPlayer = _cBilacMainController.getListPlayer(indexBilac);
        var maxRound = _cBilacMainController.getMaxRound(listPlayer.length);
        // log("maxRound $maxRound");

        List<DataColumn> getListDataColumn() {
          DataColumn genDataColumn(String label, double width) {
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
          list.add(genDataColumn('Tên', width * 2));
          for (int i = 0; i < maxRound; i++) {
            list.add(genDataColumn('${i + 1}', width));
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
                  padding:
                      const EdgeInsets.all(DimenConstants.marginPaddingTiny),
                  width: width * 2,
                  alignment: Alignment.centerLeft,
                  child: UIUtils.getText(
                    "${player.getName()} (${player.getScoreAndTotalRound()})",
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
          for (int i = 0; i < listPlayer.length; i++) {
            Player p = listPlayer[i];
            list.add(
              genDataRow(
                i,
                p,
                (indexPlayer, player, indexScore) {
                  log("onTap $indexPlayer ${jsonEncode(player)} $indexScore");
                  _onTap(indexBilac, listPlayer, indexScore, player);
                },
              ),
            );
          }
          return list;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: DimenConstants.marginPaddingMedium),
              child: UIUtils.getText(
                "GAME ${indexBilac + 1}",
                fontSize: DimenConstants.txtLarge,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: DimenConstants.marginPaddingMedium),
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
            const SizedBox(height: DimenConstants.marginPaddingMedium),
            buildChartView(indexBilac),
            const SizedBox(height: DimenConstants.marginPadding98),
          ],
        );
      }

      return ListView.builder(
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: listBilac.length,
        itemBuilder: (context, i) {
          return buildItem(i, listBilac[i]);
        },
      );
    }
  }

  void _onTap(
    int indexBilac,
    List<Player> listPlayer,
    int index,
    Player player,
  ) {
    // print(">>>_onTap index $index - ${jsonEncode(player)}");
    var currentScore = _cBilacMainController.scoreSelector.value;
    _cBilacMainController.updateScoreOfPlayer(
      indexBilac,
      listPlayer,
      index,
      player,
      currentScore,
    );
  }

  Widget _buildScoreSelectorView() {
    return Row(
      children: [
        const SizedBox(width: DimenConstants.marginPaddingMedium),
        Expanded(
          child: InkWell(
            onTap: () {
              _showScoreSheet(context);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _cBilacMainController.getScoreSelectorColor(),
                border: Border.all(
                  color: _cBilacMainController.getScoreSelectorColor(),
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(DimenConstants.marginPaddingSmall),
              child:
                  UIUtils.getText(_cBilacMainController.getScoreSelectorText()),
            ),
          ),
        ),
        const SizedBox(width: DimenConstants.marginPaddingMedium),
        Expanded(
          child: InkWell(
            onTap: () {
              _cBilacMainController.toggleShowCalendar();
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(DimenConstants.marginPaddingSmall),
              child: _cBilacMainController.isShowCalendar.value
                  ? UIUtils.getText("Ẩn lịch")
                  : UIUtils.getText("Hiện lịch"),
            ),
          ),
        ),
        const SizedBox(width: DimenConstants.marginPaddingMedium),
      ],
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
