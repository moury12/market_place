
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_static_strings.dart';
import '../widgets/profile_card_item_widget.dart';

class ProfileInfoListWidget extends StatelessWidget {
  const ProfileInfoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        ProfileCardItemWidget(title: AppStaticStrings.fullName, value: 'Robert Smith'),
        ProfileCardItemWidget(title: AppStaticStrings.email, value: 'robertsmith34@gmail.com'),
        ProfileCardItemWidget(title: AppStaticStrings.contactNumber, value: '+3489 9999 9778'),
        ProfileCardItemWidget(title: AppStaticStrings.location, value: 'Juvenal Ridge, Port Vestach'),

      ],
    );
  }
}
