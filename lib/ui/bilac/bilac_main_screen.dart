import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:get/get.dart';

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
  }

  void _onDateChanged(DateTime dateTime) {
    // print("_onDateChanged $dateTime");
    // _cBilacMainController.getBilacByTime(TimeConstants.getTime(dateTime));
  }

  Widget _buildBody() {
    return Container();
    // if (_cBilacMainController.bilac.value.time == null) {
    //   return UIUtils.buildNoDataView();
    // } else {
    //   return Container();
    // }
  }
}
