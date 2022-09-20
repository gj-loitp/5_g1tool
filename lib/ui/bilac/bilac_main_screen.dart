import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:get/get.dart';

import '../../common/c/string_constant.dart';
import '../../common/core/base_stateful_state.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/bilac/bilac_main_controller.dart';

class BiLacMainScreen extends StatefulWidget {
  const BiLacMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BiLacMainScreenState();
  }
}

class _BiLacMainScreenState extends BaseStatefulState<BiLacMainScreen> {
  final _cListPlayer = Get.put(BilacMainController());

  @override
  void initState() {
    super.initState();
    _cListPlayer.getListPlayer();
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
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.appColor,
          onPressed: () {},
          child: const Icon(Icons.add)),
    );
  }

  void _onDateChanged(DateTime dateTime) {
    print("_onDateChanged $dateTime");
    //TODO
  }
}
