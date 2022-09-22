import 'package:animated_background/animated_background.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:collection/collection.dart';
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
      var columns = <String>[];
      columns.add("Tên");
      for (int i = 1; i < maxRound; i++) {
        columns.add("Ván $i");
      }

      var rows = <List<Player>>[];
      var listPlayer = _cBilacMainController.listPlayer;
      for (int i = 0; i < listPlayer.length; i++) {
        var p = listPlayer[i];
        var r = <Player>[];

        for (int i = 0; i < maxRound; i++) {
          if (i == 0) {
            r.add(p);
          } else {
            r.add(p);
          }
        }

        rows.add(r);
      }

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

      DataColumn genDataColumn(String label) {
        return DataColumn(
          label: Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      }

      DataRow genDataRow(
          String id,
          String name,
          String profession,
          String c1,
          String c2,
          String c3,
          String c4,
          String c5,
          ) {
        return DataRow(cells: [
          DataCell(Text(id)),
          DataCell(Text(name)),
          DataCell(Text(profession)),
          DataCell(Text(c1)),
          DataCell(Text(c2)),
          DataCell(Text(c3)),
          DataCell(Text(c4)),
          DataCell(Text(c5)),
        ]);
      }

      return ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                genDataColumn('Id'),
                genDataColumn('Name'),
                genDataColumn('Profession'),
                genDataColumn('Column1'),
                genDataColumn('Column2'),
                genDataColumn('Column3'),
                genDataColumn('Column4'),
                genDataColumn('Column5'),
              ],
              rows: [
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
                genDataRow('1', 'Loi1', "Profession", "1", "2", "3", "4", "5"),
              ],
            ),
          ),
        ],
      );
    }
  }

  void _onTap(int index, Player player) {
    // print(">>>_onTap index $index - ${jsonEncode(player)}");
    if (index == 0) {
      return;
    }

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
