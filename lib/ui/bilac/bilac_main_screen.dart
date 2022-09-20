import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:get/get.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';

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

class _BiLacMainScreenState extends BaseStatefulState<BiLacMainScreen> {
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
            if (_cBilacMainController.listPlayer.isNotEmpty == false)
              UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
            Column(
              children: [
                CalendarAppBar(
                  accent: ColorConstants.appColor,
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
                Expanded(child: _buildBody()),
              ],
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

      var rows = <List<String>>[];
      var listPlayer = _cBilacMainController.listPlayer;
      for (int i = 0; i < listPlayer.length; i++) {
        var p = listPlayer[i];
        var r = <String>[];

        for (int i = 0; i < maxRound; i++) {
          if (i == 0) {
            r.add("${p.name} (${p.getNumberOfRound()})");
          } else {
            r.add("${p.getScoreByIndex(i)}");
          }
        }

        rows.add(r);
      }

      return ScrollableTableView(
        rowDividerHeight: 0.0,
        columns: columns.map((column) {
          return TableViewColumn(
            label: column,
          );
        }).toList(),
        rows: rows.map((record) {
          return TableViewRow(
            height: 40,
            cells: record.mapIndexed((index, value) {
              return TableViewCell(
                child: InkWell(
                  child: Container(
                    margin: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Player.getColorByScore(value),
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
                      value,
                      fontSize: 12.0,
                    ),
                  ),
                  onTap: () {
                    _onTap(value, index);
                  },
                ),
              );
            }).toList(),
          );
        }).toList(),
      );
    }
  }

  void _onTap(String score, int indexScore) {
    print(">>>_onTap score $score, indexScore $indexScore");
    if (indexScore == 0) {
      return;
    }
  }
}
