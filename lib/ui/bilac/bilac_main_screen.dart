import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:get/get.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';

import '../../common/c/string_constant.dart';
import '../../common/core/base_stateful_state.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/bilac/bilac_main_controller.dart';
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
              Get.to(
                () => SelectPlayerScreen(
                  onListPlayerSelected: (listPlayerSelected) {
                    _cBilacMainController.genNewGame(listPlayerSelected);
                  },
                ),
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
      columns.add("Name");
      for (int i = 1; i < maxRound; i++) {
        columns.add("Set $i");
      }

      var rows = <List<String>>[];
      var listPlayer = _cBilacMainController.listPlayer;
      for (int i = 0; i < listPlayer.length; i++) {
        var p = listPlayer[i];
        var r = <String>[];

        for (int i = 0; i < maxRound; i++) {
          if (i == 0) {
            r.add("${p.name}");
          } else {
            r.add("$i");
          }
        }

        rows.add(r);
      }

      // var rows1 = <String>[];
      // rows1.add("Loi");
      // rows1.add("1");
      // rows1.add("0");
      //
      // var rows2 = <String>[];
      // rows2.add("Toai");
      // rows2.add("0");
      // rows2.add("1");
      //
      // var rows = <List<String>>[];
      // rows.add(rows1);
      // rows.add(rows2);

      return ScrollableTableView(
        columns: columns.map((column) {
          return TableViewColumn(
            label: column,
          );
        }).toList(),
        rows: rows.map((record) {
          return TableViewRow(
            height: 50,
            cells: record.map((value) {
              return TableViewCell(
                child: Text(value),
              );
            }).toList(),
          );
        }).toList(),
      );
    }
  }
}
