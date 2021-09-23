import 'package:face_attendance/constants/app_colors.dart';
import 'package:face_attendance/constants/app_defaults.dart';
import 'package:face_attendance/constants/app_sizes.dart';
import 'package:face_attendance/controllers/user/user_controller.dart';
import 'package:face_attendance/views/themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangeHolidaySheet extends StatefulWidget {
  const ChangeHolidaySheet({Key? key}) : super(key: key);

  @override
  _ChangeHolidaySheetState createState() => _ChangeHolidaySheetState();
}

class _ChangeHolidaySheetState extends State<ChangeHolidaySheet> {
  /* <---- Dependency -----> */
  AppUserController _controller = Get.find();

  /// List of days to show in option
  List<String> _days = [];

  @override
  void initState() {
    super.initState();
    _days = _controller.allWeekDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppSizes.DEFAULT_PADDING,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDefaults.defaultBottomSheetRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select a holiday',
            style: AppText.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          AppSizes.hGap10,
          Divider(),
          AppSizes.hGap10,
          /* <---- Days List -----> */
          GetBuilder<AppUserController>(builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                _days.length,
                (index) => _DayTile(
                  isSelected: index + 1 == controller.currentUser.holiday,
                  dayName: _days[index],
                  onTap: () async {
                    print(index + 1);
                    await controller.updateHoliday(selectedDay: index + 1);
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _DayTile extends StatelessWidget {
  const _DayTile({
    Key? key,
    required this.isSelected,
    required this.dayName,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String dayName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: isSelected
            ? Icon(
                Icons.check,
                color: AppColors.APP_GREEN,
              )
            : null,
        title: Text(
          dayName,
          style: AppText.b1.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w100,
          ),
        ),
        subtitle: isSelected
            ? Text(
                'Currently Selected',
                style: AppText.caption,
              )
            : null,
      ),
    );
  }
}